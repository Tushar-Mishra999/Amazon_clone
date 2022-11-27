# Ecommerce app
This an ecommerce multivendor platform where sellers and buyers can register themselves and buy and sell products.

Frontend
The frontend has been created using Flutter.

Backend
The backend has been created using Python(Flask framework) and Node.JS(Express.JS framework). Flask has been used to handle the operations between the user and the database.
Express.JS has been used for user authentication along with Firebase which has been used to manage the users and to maintain the user privacy.

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
