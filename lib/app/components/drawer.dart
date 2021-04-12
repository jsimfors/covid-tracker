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
            icon: Icons.cloud,
            text: 'Climate',
            onTap: () =>
            Navigator.pushReplacementNamed(context, Routes.climate)),
          _createDrawerItem(
            icon: Icons.masks, 
            text: 'Covid-19',
            onTap: () =>
            Navigator.pushReplacementNamed(context, Routes.covid)),
           _createDrawerItem(
            icon: Icons.local_pizza, 
            text: 'Something else',
            onTap: () =>
            Navigator.pushReplacementNamed(context, Routes.covid)),
            _createDrawerItem(
            icon: Icons.theater_comedy, 
            text: 'Something else again',
            onTap: () =>
            Navigator.pushReplacementNamed(context, Routes.covid)),
             Divider(),
          ListTile(
            title: Text('Data vizualisation'),
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
      decoration: BoxDecoration(
          image: DecorationImage( 
              fit: BoxFit.fitHeight, // TODO: path
              image:  AssetImage('/Users/johanna/Development/dart-project/nCov/corona_stats_app/assets/images/drawer_header.png'))),
      child: Stack(children: <Widget>[
        Positioned(
            bottom: 16.0,
            left: 16.0,
            child: Text("Choose Cathegory",
                style: TextStyle(
                    color: Colors.black87,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w500))
                    ),
      ])
  );
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
