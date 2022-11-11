from flask import Flask, request, make_response
from flask_cors import CORS, cross_origin
from flask_mysqldb import MySQL
from flask_limiter import Limiter, util
from datetime import datetime, timedelta
# from jwt import algorithms, ExpiredSignatureError, decode
from functools import wraps
from MySQLdb import OperationalError
import MySQLdb.cursors as cur
import pandas as pd
import uuid
import boto3

application=app=Flask(__name__)
cros=CORS(app)

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

app.get('/')
def home():
    return make_response({'message':'Home'})

@app.get('/orders')
def orders_get():
    try:
        app.mysql.connection.commit()
    except OperationalError as SQLdbError:
        if "Lost connection" not in str(SQLdbError):
            return SQLdbError.__dict__
        app.mysql.connection = MySQL(app)
    seller_id=request.args.get('seller_id')
    cur = app.mysql.connection.cursor()
    cur.execute("SELECT * from order join products_in_order using(order_no) join products using(sku) where seller_id='%s'"%(seller_id))
    data = cur.fetchall()
    app.mysql.connection.commit()
    cur.close()
    return make_response({'data':data}), 200

@app.post('/add_product')
def add_product():
    data = request.get_json()
    sku = data['sku']
    name = data['name']
    reg_price = data['reg_price']
    seller_id = data['seller_id']
    category = data['category']
    description = data['description']
    images = data['images']
    inventory = data['inventory']
    try:
        app.mysql.connection.commit()
    except OperationalError as SQLdbError:
        if "Lost connection" not in str(SQLdbError):
            return SQLdbError.__dict__
        app.mysql.connection = MySQL(app)
    cur = app.mysql.connection.cursor()
    cur.execute("INSERT INTO products VALUES('%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s')"%(sku, name, description, images, reg_price, inventory, seller_id, category))
    app.mysql.connection.commit()
    cur.close()
    return make_response({'message':'Product added'}), 200



if __name__ == "__main__":
    app.run(host='0.0.0.0',port=5002,debug=True)