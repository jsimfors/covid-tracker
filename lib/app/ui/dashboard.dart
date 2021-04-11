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
        appBar: AppBar( // TODO: Styling:
            title: Image.asset('assets/logo.png'),
            ),
        body: ListView(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
              child: Text(
                'Please choose what to vizualise:',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color.fromRGBO(255, 255, 255, 1),
                      fontSize: 21,
                    )
              ),
            ),
            climateSection,
            mapSection
          ],
        ),
        drawer: drawerMenu         
    );
  }

}