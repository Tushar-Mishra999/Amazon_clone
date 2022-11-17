from flask import Flask, request, make_response
from flask_cors import CORS, cross_origin
from flask_mysqldb import MySQL
from flask_limiter import Limiter, util
from datetime import datetime, timedelta
# from jwt import algorithms, ExpiredSignatureError, decode
from functools import wraps
from MySQLdb import OperationalError
import MySQLdb.cursors as curdict
import pandas as pd
import uuid

application = app = Flask(__name__)
cros = CORS(app)

limiter = Limiter(
    application,
    key_func=util.get_remote_address,
    default_limits=["200 per day", "50 per hour"],
    storage_uri="memory://"
)

app.config['CORS_HEADERS'] = 'Content-Type'
app.config['MYSQL_HOST'] = 'attendance.cbcvudzl6rdd.us-east-1.rds.amazonaws.com'
app.config['MYSQL_USER'] = 'admin'
app.config['MYSQL_PASSWORD'] = 'password'
app.config['MYSQL_DB'] = 'ecommerce'
app.config['JSON_SORT_KEYS'] = False
app.config['SECRET_KEY'] = '0898a671f37849d79ed8126dd469dcd1'

app.mysql = MySQL(app)


@app.get('/')
def home():
    return make_response({'message': 'Home'})


@app.post('/register')
def register():
    data = request.get_json()
    name = data['name']
    email = data['email']
    cur = app.mysql.connection.cursor()
    cur.execute("INSERT INTO users (name, email) VALUES (%s, %s)", (name, email))
    app.mysql.connection.commit()
    cur.close()
    return make_response({'message': 'User created'})


@app.get('/products')
def products():
    try:
        app.mysql.connection.commit()
    except OperationalError as SQLdbError:
        if "Lost connection" not in str(SQLdbError):
            return SQLdbError.__dict__
        app.mysql.connection = MySQL(app)
    cur = app.mysql.connection.cursor(curdict.DictCursor)
    if request.args.get('sku') and request.args.get('username'):
        cur.execute('select * from products where sku = %s',
                    (request.args.get('sku'),))
        result = cur.fetchone()
        if result:
            if result['Images']:
                result['Images'] = eval(result['Images'])
            if result['Promo_price'] == 0:
                del result['Promo_price']
            cur.execute(
                'select avg(rating) as rating from reviews where sku = %s', (request.args.get('sku'),))
            rating = cur.fetchone()
            if rating['rating']:
                result['rating'] = rating['rating']
            cur.execute('select * from reviews where sku = %s and username = %s',
                        (request.args.get('sku'), request.args.get('username')))
            review = cur.fetchone()
            if review:
                result['review'] = review['rating']
            cur.close()
            return make_response({'message': 'Product found', 'product': result}), 200
        else:
            return make_response({'message': 'Product not found'}), 404
    else:
        cur.execute('select * from products')
        result = cur.fetchall()
        cur.close()
        if result:
            for i in result:
                i['Images'] = eval(i['Images'])
            return make_response({'message': 'Products found', 'products': result}), 200
        else:
            return make_response({'message': 'Products not found'}), 404


@app.get('/category')
def category():
    try:
        app.mysql.connection.commit()
    except OperationalError as SQLdbError:
        if "Lost connection" not in str(SQLdbError):
            return SQLdbError.__dict__
        app.mysql.connection = MySQL(app)
    cur = app.mysql.connection.cursor(curdict.DictCursor)
    if request.args.get('category'):
        cur.execute('select * from products where category = %s',
                    (request.args.get('category'),))
        result = cur.fetchall()
        cur.close()
        if result:
            for i in result:
                i['Images'] = eval(i['Images'])
            return make_response({'message': 'Products found', 'products': result}), 200
        else:
            return make_response({'message': 'Products not found'}), 404
    else:
        return make_response({'message': 'Category not found'}), 404


@app.get('/search')
def search():
    try:
        app.mysql.connection.commit()
    except OperationalError as SQLdbError:
        if "Lost connection" not in str(SQLdbError):
            return SQLdbError.__dict__
        app.mysql.connection = MySQL(app)
    cur = app.mysql.connection.cursor(curdict.DictCursor)
    if request.args.get('query'):
        keywords = request.args.get('query').split()
        query = 'select * from products where sku in (select sku from keywords where '
        for keyword in keywords:
            query += 'name like "%s" or '
        query = query[:-3]
        cur.execute(query, tuple(['%'+keyword+'%' for keyword in keywords]))
        result = cur.fetchall()
        cur.execute('select * from products where name like %s',
                    ('%'+request.args.get('query')+'%',))
        result += cur.fetchall()
        cur.close()
        if result:
            return make_response({'message': 'Products found', 'products': result}), 200
        else:
            return make_response({'message': 'Products not found'}), 404
    else:
        return make_response({'message': 'Query not found'}), 404


@app.get('/cart')
def cart_get():
    try:
        app.mysql.connection.commit()
    except OperationalError as SQLdbError:
        if "Lost connection" not in str(SQLdbError):
            return SQLdbError.__dict__
        app.mysql.connection = MySQL(app)
    cur = app.mysql.connection.cursor(curdict.DictCursor)
    if request.args.get('username'):
        cur.execute('select * from cart join products using(sku) where username = %s',
                    (request.args.get('username'),))
        result = cur.fetchall()
        cur.close()
        if result:
            return make_response({'message': 'Cart found', 'cart': result}), 200
        else:
            return make_response({'message': 'Cart not found'}), 404
    else:
        return make_response({'message': 'Username not found'}), 404


@app.post('/cart')
def cart_post():
    data = request.get_json()
    username = data['username']
    sku = data['sku']
    quantity = data['quantity']
    try:
        app.mysql.connection.commit()
    except OperationalError as SQLdbError:
        if "Lost connection" not in str(SQLdbError):
            return SQLdbError.__dict__
        app.mysql.connection = MySQL(app)
    cur = app.mysql.connection.cursor(curdict.DictCursor)
    cur.execute("INSERT INTO cart VALUES(%s, %s, %s)" %
                (username, sku, quantity))
    app.mysql.connection.commit()
    cur.close()
    return make_response({'message': 'Added to cart'}), 200


@app.delete('/cart')
def cart_delete():
    data = request.get_json()
    username = data['username']
    sku = data['sku']
    try:
        app.mysql.connection.commit()
    except OperationalError as SQLdbError:
        if "Lost connection" not in str(SQLdbError):
            return SQLdbError.__dict__
        app.mysql.connection = MySQL(app)
    cur = app.mysql.connection.cursor(curdict.DictCursor)
    cur.execute("DELETE FROM cart WHERE username = %s AND sku = %s" %
                (username, sku))
    app.mysql.connection.commit()
    cur.close()
    return make_response({'message': 'Deleted from cart'}), 200


@app.get('/orders')
def orders_get():
    try:
        app.mysql.connection.commit()
    except OperationalError as SQLdbError:
        if "Lost connection" not in str(SQLdbError):
            return SQLdbError.__dict__
        app.mysql.connection = MySQL(app)
    cur = app.mysql.connection.cursor(curdict.DictCursor)
    if request.args.get('username'):
        cur.execute('select * from orders where username = %s',
                    (request.args.get('username'),))
        result = cur.fetchall()
        cur.close()
        if result:
            return make_response({'message': 'Orders found', 'orders': result}), 200
        else:
            return make_response({'message': 'Orders not found'}), 404
    else:
        return make_response({'message': 'Username not found'}), 404


@app.post('/order')
def order_post():
    data = request.get_json()
    date = datetime.datetime.now()
    username = data['username']
    products = data['products']
    quantity = data['quantity']
    order_id = uuid.uuid4()
    try:
        app.mysql.connection.commit()
    except OperationalError as SQLdbError:
        if "Lost connection" not in str(SQLdbError):
            return SQLdbError.__dict__
        app.mysql.connection = MySQL(app)
    cur = app.mysql.connection.cursor(curdict.DictCursor)
    cur.execute("INSERT INTO orders VALUES(%s, %s, %s, %s)" %
                (order_id, username, quantity, date))
    app.mysql.connection.commit()
    for i in products:
        cur.execute("INSERT INTO products_in_order VALUES(%s, %s)" %
                    (order_id, i))
        app.mysql.connection.commit()
    cur.close()
    return make_response({'message': 'Added to orders'}), 200


@app.get('/order')
def order_get():
    try:
        app.mysql.connection.commit()
    except OperationalError as SQLdbError:
        if "Lost connection" not in str(SQLdbError):
            return SQLdbError.__dict__
        app.mysql.connection = MySQL(app)
    cur = app.mysql.connection.cursor(curdict.DictCursor)
    if request.args.get('order_id'):
        cur.execute('select * from orders where order_id = %s',
                    (request.args.get('order_id'),))
        result = cur.fetchall()
        cur.execute('select * from products_in_order where order_id = %s',
                    (request.args.get('order_id'),))
        result1 = cur.fetchall()
        cur.close()
        if result and result1:
            return make_response({'message': 'Order found', 'order_details': result, 'order_products': result1}), 200
        else:
            return make_response({'message': 'Order not found'}), 404
    else:
        return make_response({'message': 'Order id not found'}), 404


@app.post('/review')
def review_post():
    data = request.get_json()
    username = data['username']
    sku = data['sku']
    review = data['review']
    try:
        app.mysql.connection.commit()
    except OperationalError as SQLdbError:
        if "Lost connection" not in str(SQLdbError):
            return SQLdbError.__dict__
        app.mysql.connection = MySQL(app)
    cur = app.mysql.connection.cursor(curdict.DictCursor)
    cur.execute("INSERT INTO reviews (username, sku, rating) VALUES(%s, %s, %s)" % (
        username, sku, review))
    app.mysql.connection.commit()
    cur.close()
    return make_response({'message': 'Added to reviews'}), 200


@app.get('/routes')
def routes():
    routes = []
    for route in app.url_map.iter_rules():
        routes.append('%s' % route)
    return make_response({'routes': routes}), 200


if __name__ == "__main__":
    app.run(host='0.0.0.0')
