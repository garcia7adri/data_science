-Project: 
Business search with YELP Fusion API

-Purpose:
This code allows users to search business in YELP. 
The main code is in adri_app_G file which is a .py extension file.

-URL:
http://adrigarcia.pythonanywhere.com/

-Programming Language and architectural style:
Python. The structure of the project follows REST API architectural style.

-Endpoints:
It includes three endpoints. The first one ('/') corresponds to the home endpoint which returns a welcoming greeting. 
http://adrigarcia.pythonanywhere.com/

The second endpoint ('/translation-san-francisco') is a predefined search which returns results according to the term "translation" and location "San Francisco". 
http://adrigarcia.pythonanywhere.com/translation-san-francisco

Finally, the third endpoint (/personalized-search) opens the posibility to return a personalized search, the paramenters Term and Location are open to the user. 
http://adrigarcia.pythonanywhere.com/personalized-search?location=<location you look for>&term=<the term you look for>
For example:
http://adrigarcia.pythonanywhere.com/personalized-search?location=california&term=restaurant

-The main parameters for the search are:

°Location, which receives a city, country or State in the United States. 
Examples:
Country: USA, Mexico
City: San Francisco, Sacramento.
State: CA - refering to California.

°Term: which accepts the main word for the search; e.g. 'translation', 'restaurant','bookstore'. 

Note: Some extra code to save the search results in Mongo database can be found in the Jupyter notebook.

The code provided in this repository lacks the personal YELP key and credentials for MongoDB. In case you want to use the code directly, please use your personal credentials.


