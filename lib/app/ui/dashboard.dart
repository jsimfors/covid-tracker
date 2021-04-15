import 'package:corona_stats_app/app/components/drawer.dart';
import 'package:corona_stats_app/app/components/maps.dart';
import 'package:corona_stats_app/app/components/world_map.dart';
import 'package:corona_stats_app/app/services/climateAPI/data_repositories.dart';
import 'package:corona_stats_app/app/ui/dashborad_nCov.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  // Dashboard: current homepage: map & climate page. 
  // TODO: add proper landing screen.
  
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {

    Widget climateSection = ClimatePage();
    //Widget mapSection = MapsPage();
    Widget mapSection = WorldMapPage();
    Widget drawerMenu = DrawerSection();

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Stack( // to place appbar on top of logo
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
                    child: Container(
                      color: Colors.transparent,
                      child: Image.asset('assets/images/header_logo.png') 
                  ),
                ),
                AppBar(
                  backgroundColor: Colors.transparent,   
                  toolbarHeight: 100,
                  elevation: 0,
                ),
            ],
            ),
            Container(
              child: Column(children: [
                climateSection,
                mapSection
              ],),

            ),
            Container(
              
            )
            
            
            /* Initial container
            Container(color: Colors.pink,
              width: 300,
              height: 300,
              child: Center(
                child: Text('Text 1'),
              )
            )*/
          ]
        )
      ),
      drawer: drawerMenu,
    );
  }
}