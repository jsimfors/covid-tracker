![image 1](assets/images/readme/header.png)
 
*Vistics - Visualize Statistic* is a Flutter mobile app that visualizes different types of data. The app is written in Dart and uses two different REST APIs.
 
This app is not a part of any university course or previous work, just something I've worked with in my spare time because I think data visualization is really interesting.
 
![image 2](assets/images/readme/intro.png)
 
The first REST API connected to the app is the *nCov 2019 Coronavirus API*. The user can choose to visualize the data in several different ways with the click of a button or scroll down to see the data lined up in a list view. To update the numbers, the user simply uses pull-to-refresh, and a new API call is made.
 
![image 3](assets/images/readme/ncov.png)
 
The second REST API connected to the app is the *Climate Data API* from *The World Bank*. Through this API we can get data on several different categories, such as temperature and rainfall. The user can through a form choose from what time and for what countries to retrieve data from. The years can be information about years back in time, or predictions for future years, all the way to 2099.
 
![image 4](assets/images/readme/climate.png)
 
All graphs and maps are displayed with the Flutter widgets **Syncfusion Graphs** and **Syncfusion Maps**.
 
 
 
### Run this app on your device:
When cloning this project, please note that the following files are not included:
- .vscode/settings.json
- lib/app/services/api_keys.dart
 
You can create your own API key for free at [http://ncov2019-admin.firebaseapp.com/](http://ncov2019-admin.firebaseapp.com/).