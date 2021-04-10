import 'package:corona_stats_app/app/components/maps.dart';
import 'package:corona_stats_app/app/services/climateAPI/data_repositories.dart';
import 'package:corona_stats_app/app/ui/dashborad_nCov.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {

    // WIDGET 1 - Climate page
    Widget climateSection = ClimatePage();
    // WIDGET 2 - Map page
    Widget mapSection = MapsPage();
    // WIDGET 3 - Covid Statistics Page¨
    Widget covidSection = CovidPage();
    
    /*Container(
      padding: const EdgeInsets.all(32),
      child: Text(
        'Covid section',
        softWrap: true,
      ),
    );*/

    return Scaffold(
        appBar: AppBar(
          title: Text('Data Vizualisation'),
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
            mapSection,
            covidSection,
          ],
        ),
    );
  }

}