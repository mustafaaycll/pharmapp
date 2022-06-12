# PharMapp

## Description

PharMapp is a prototype Flutter application that aims to enable its users to shop online in pharmacies and was developed in accordance with the Mobile Application Development course of Sabancı University coded as CS310.

Required backend service is provided by Firebase. Firebase Authentication (for Email/Password, Google, Facebook, Anonymous sign-in methods), Firestore Database (for storing pre-defined addresses, user information, product pool, pharmacy information, orders given by users, comments left on pharmacies, bookmarks created by users), Firebase Storage (for storing profile pictures of users, images of products that being sold) and Firebase Analytics services are used when necessary.

## Details

### Walkthrough, Login and Home Screen

Here user can login with email and password, google or facebook, or can continue anonymously


<p align="center">
<img src="markdown_resources/walkthrough.gif" width="285" height="600"/>
<img src="markdown_resources/home.gif" width="285" height="600"/>
</p>

### Address Addition
Pharmacies serves certain addresses, so user adds one or more address from a dropdown menu. Address structure consists of only cities to keep it simple. They are also predefined in Firestore Database.

<p align="center">
<img src="markdown_resources/address addition.gif" width="285" height="600"/>
</p>

### Listing Pharmacies Serving In Selected City and Their Products, Adding to Basket, Viewing Comments, Bookmarking a Product
<p align="center">
<img src="markdown_resources/pharm listing product listing and addition to basket.gif" width="285" height="600"/>
<img src="markdown_resources/comments.gif" width="285" height="600"/>
<img src="markdown_resources/bookmarking.gif" width="285" height="600"/>
<img src="markdown_resources/adding from different pharms.gif" width="285" height="600"/>
</p>

### Buying Products Added to Basket, Adding to Basket from Bookmarks - Removing Bookmark
<p align="center">
<img src="markdown_resources/check out.gif" width="285" height="600"/>
<img src="markdown_resources/shopping from bookmarks.gif" width="285" height="600"/>
</p>

### Rating Purchases, Adding a Pharmacy to Favorites
<p align="center">
<img src="markdown_resources/rating.gif" width="285" height="600"/>
<img src="markdown_resources/fav pharms.gif" width="285" height="600"/>
</p>

### Changing Name and Profile Picture, Managing Delivery Addresses, Favorite Pharmacies and Bookmarks
<p align="center">
<img src="markdown_resources/name changing.gif" width="285" height="600"/>
<img src="markdown_resources/pp change.gif" width="285" height="600"/>
<img src="markdown_resources/del addresses and fav pharm management.gif" width="285" height="600"/>
<img src="markdown_resources/bookmark management.gif" width="285" height="600"/>
</p>

### Opening Pharmacy, Selling Items, Changing Prices and Deleting Products
<p align="center">
<img src="markdown_resources/pharm creation.gif" width="285" height="600"/>
<img src="markdown_resources/product addition.gif" width="285" height="600"/>
<img src="markdown_resources/price change and product deletion.gif" width="285" height="600"/>
<img src="markdown_resources/comments and pharm deletion.gif" width="285" height="600"/>
</p>

### Logging Out, Anonym Shopping
<p align="center">
<img src="markdown_resources/logout and anonym shopping.gif" width="285" height="600"/>
</p>

## Notes Regarding the Code
State management is done with `StreamBuilder<Object>`. Functions used to flow data are defined in `lib/services`. `auth.dart` contains sign-in methods and Firestore Storage upload functions, while `database.dart` containing 7 different classes:

`DatabaseServices`: Functions related to user information flows and updates

`DatabaseServices_pharm`: Functions related to pharmacy information flows and updates

`DatabaseServices_address`: Functions related to address information flows and updates

`DatabaseServices_product`: Functions related to product information flows and updates

`DatabaseServices_order`: Functions related to order information flows and updates

`DatabaseServices_comment`: Functions related to comment information flows and updates

`DatabaseServices_bookmark`: Functions related to bookmark information flows and updates


### Above classes may require and id or list of ids to function. In case of a function belonging to any of above classes but not needing id nor ids, pass an empty string and list to those parameters:

```
DatabaseService_pharm(id:"SwkUgHqGXT65D", ids:[]).pharmdata
//returns a single pharmacy document with given id from Firebase
//as a Stream object 
```

```
DatabaseService_pharm(id:"", ids:["SwkU","gHqGX","T65D"]).pharms
//returns a list of pharmacy documents with given ids from Firebase
//as a Stream object 
```
