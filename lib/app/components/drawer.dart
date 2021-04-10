import 'package:corona_stats_app/app/services/climateAPI/api_service.dart';
import 'package:corona_stats_app/app/services/climateAPI/data_repositories.dart';
import 'package:corona_stats_app/app/ui/dashboard.dart';
import 'package:corona_stats_app/app/ui/dashborad_nCov.dart';
import 'package:corona_stats_app/routes/routes.dart';
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
  return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          _createHeader(),
          _createDrawerItem(
            icon: Icons.contacts,
            text: 'Covid',
            onTap: () =>
            Navigator.pushReplacementNamed(context, Routes.climate)),
          _createDrawerItem(
            icon: Icons.event, 
            text: 'Climate',
            onTap: () =>
            Navigator.pushReplacementNamed(context, Routes.covid)),
          /*
          _createDrawerItem(icon: Icons.note, text: 'Notes',),
          Divider(),
          _createDrawerItem(icon: Icons.collections_bookmark, text:           'Steps'),
          _createDrawerItem(icon: Icons.face, text: 'Authors'),
          _createDrawerItem(icon: Icons.account_box, text: 'Flutter Documentation'),
          _createDrawerItem(icon: Icons.stars, text: 'Useful Links'),
          Divider(),
          _createDrawerItem(icon: Icons.bug_report, text: 'Report an issue'),
          */
          ListTile(
            title: Text('0.0.1'),
            onTap: () {},
          ),
        ],
      ),
    );

   
}
}Widget _createHeader() {
  return DrawerHeader(
      margin: EdgeInsets.zero,
      padding: EdgeInsets.zero,
      /*decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.fill,
              image:  AssetImage('path/to/header_background.png'))),*/
      child: Stack(children: <Widget>[
        Positioned(
            bottom: 12.0,
            left: 16.0,
            child: Text("Flutter Step-by-Step",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w500))),
      ]));
}




Widget _createDrawerItem(
    {IconData icon, String text, GestureTapCallback onTap}) {
  return ListTile(
    title: Row(
      children: <Widget>[
        Icon(icon),
        Padding(
          padding: EdgeInsets.only(left: 8.0),
          child: Text(text),
        )
      ],
    ),
    onTap: onTap,
  );
}
