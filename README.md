# Ecommerce app
This an ecommerce multivendor platform where sellers and buyers can register themselves and buy and sell products.
- Sellers can upload products,delete products,change order status and view their sales analytics.
- User can search products either by manully searching or searching through respective categories.They can review products,add products to their cart and then buy it. After that they can view their order status. User can also view their past orders.

# Installing the app
- For running the app kindly download the .apk file on your android phone, install and signup as a user.
- For accessing the admin side kindly use the following credentials.
'tusharmishra16@gmail.com' as email and 'password' as password.

# Frontend
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


## Creators
- Tushar Mishra     - Frontend           (Flutter)
- Sarthak Singhania - Backend & Database (Flask & MySQL)
- Srikant Tripathi  - Backend and UI/UX  (Node.js and Figma)
