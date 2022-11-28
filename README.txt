# Ecommerce app
This an ecommerce multivendor platform where sellers and buyers can register themselves and buy and sell products.
- Sellers can upload products,delete products,change order status and view their sales analytics.
- User can search products either by manully searching or searching through respective categories.They can review products,add products to their cart and then buy it. After that they can view their order status. User can also view their past orders.

# Installing the app
- For running the app kindly download the .apk file on your android phone, install and signup as a user.
- For accessing the admin side kindly use the following credentials.
'tusharmishra16@gmail.com' as email and 'password' as password.

Frontend
The frontend has been created using Flutter.
Frontend code is in 'lib' folder:
- 'constants' folder contais the error handling logic, and global variables
- Then in 'features' folder there are various functionalities.
- account page has user info regarding order and logout option
- admin folder contains all the admin functionalities such as adding products,viewing orders, deleting orders and changing order status.
- auth folder contains the login and signup page logic.
- home page contains the home screen for client.
- order_details contains the order detail page about the quantity ,product id and order status.
- product_details page contains the product details and contains the option for buying and adding it to the cart
- cart page contains the cart and the option to proceed for buying it.
- search folder contains the logic for searching and returning appropriate products.
- all the folder under 'features' contain a subfolder 'services' which contains the logic for fetching and returning the data through API calls.
- buy folder contains the buying page and logic.
- model folder contains all the classes such as category,order,product,sales,user.
- provider folder contains the logic for state management of user details across different pages of the app.
- router file contains different routes for the screens of the app.
- main file contains the driver code of the app.
- tester folder contains the code for unit and widget testing the app.

# Backend
-The backend has been created using Python(Flask framework) and Node.JS(Express.JS framework). Flask has been used to handle the operations between the user and the database.
-Express.JS has been used for user authentication along with Firebase which has been used to manage the users and to maintain the user privacy.
-There is 'server' folder that contains two sub-folders 'python' and 'js' each having the respective code for the backend.
-The user operations are managed by 'main_user.py'.
-The seller operations are managed by 'main_seller.py'
-The required packaged can be installed using the requirements.txt file and package.json

Database
We have used MySQL as our database engine. There 9 tables in our database:
	1) Orders - This table records all the orders placed by the user with order no as the primary key.
	2) Products_in_order - This table records all the products in a specific order with the order no and sku as composite primary key.
	3) Products - This table records all the products that are listed on the platform with sku as the primary key.
	4) Keywords - This table records all the keywords of a specific product to make search easier with keywork and sku as primary key.
	5) Categories - This table records all the categories that are available on the platform with category id as the primary key.
	6) Users - This table maintains the records of the users with username as the primary key.
	7) Cart - This table maintains the users cart with the username and sku as the primary key.
	8) Seller - This table records the sellers that are registered on the platform.
	9) Reviews - This table maintains the review given by each user for a specific product.


## Creators
- Tushar Mishra     - Frontend           (Flutter, Node.JS & Firebase)
- Sarthak Singhania - Backend & Database (Flask & MySQL)
- Srikant Tripathi  - UI/UX              (Figma)
