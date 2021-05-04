import 'package:corona_stats_app/app/components/drawer.dart';
import 'package:corona_stats_app/app/services/climateAPI/data_repositories.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  // Dashboard: current homepage: map & climate page. 
  final List<double> averageFromAPI;
  final List<String> countryISO;

  const Dashboard({Key key, this.averageFromAPI, this.countryISO}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {

    Widget climateSection = ClimatePage(averageFromAPI: widget.averageFromAPI, countryISO: widget.countryISO);
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
                //mapSection
              ],),

            ),
            Container(
              
            )
          ]
        )
      ),
      drawer: drawerMenu,
    );
  }
}