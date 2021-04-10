import 'package:corona_stats_app/app/services/climateAPI/api_service.dart';
import 'package:corona_stats_app/app/ui/dashboard.dart';
import 'package:corona_stats_app/app/ui/dashborad_nCov.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_maps/maps.dart';

class DrawerSection extends StatefulWidget {

  const DrawerSection({Key key}) : super(key: key);

  @override
  _DrawerSection createState() => _DrawerSection();
}

class _DrawerSection extends State<DrawerSection> {


@override
Widget build(BuildContext context) {
  return 

    Container( child:
   Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('What data do you want to visualize?'),
              decoration: BoxDecoration(
                color: Colors.indigo.shade200,
              ),
            ),
            ListTile(
              title: Text('Covid-19 Statistic'),
              onTap: () {
                // Update the state of the app
                // ...
                // To close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Option 2'),
              onTap: () {
                
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
          ],
        )
   ));
}
}




