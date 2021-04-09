import 'dart:io';
import 'package:corona_stats_app/app/components/maps.dart';
import 'package:corona_stats_app/app/components/world_map.dart';
import 'package:corona_stats_app/app/repositories/data_repositories.dart';
import 'package:corona_stats_app/app/repositories/endpoints_data.dart';
import 'package:corona_stats_app/app/services/api.dart';
import 'package:corona_stats_app/app/services/climateAPI/data_repositories.dart';
import 'package:corona_stats_app/app/ui/dashborad_nCov.dart';
import 'package:corona_stats_app/app/ui/graphs.dart';
import 'package:corona_stats_app/app/ui/show_alert_dialog.dart';
import 'package:corona_stats_app/app/ui/updated_text.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'endpoint_card.dart';


class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  EndpointsData _endpointsData;
  bool showLineGraph = true;
  bool showPieChart = false;
  bool showBubbleChart = false;
  // 0 line, 1 pie, 2 bubble.
  List<bool> showGraphIndex = [true, false, false]; 

  @override
  void initState() {
    super.initState();
    final dataRepository = Provider.of<DataRepository>(context, listen: false);
    _endpointsData = dataRepository.getAllEndpointsCachedData();
    _updateData();
  }

  Future<void> _updateData() async {
    try {
    final dataRepository = Provider.of<DataRepository>(context, listen: false);
    final endpointsData = await dataRepository.getAllEndpointsData();
    setState(() => _endpointsData = endpointsData);
    } on SocketException catch (_) {
      showAlertDialog(
        context: context, 
        title: 'Something went wrong 😬', 
        content: 'Please check your connection or try again later.', 
        defaultActionText: 'Nonsense! I want to try again!'
      );
    } catch (_) { // if its not a Socket Exception.
      showAlertDialog(
        context: context, 
        title: 'Unknown Error 😬', 
        content: 'Please contact the support team or try again later', 
        defaultActionText: 'Ok 😔'
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final formatter = LastUpdatedDateFormatter(
      lastUpdated:  _endpointsData != null
                  ? _endpointsData.values[Endpoint.cases]?.date
                  : null,
      );
    final header = 'Corona Stats';
    //print(_endpointsData.values[Endpoint.values[0]].value);


      return  Scaffold(
        appBar: AppBar(title: Text('Data Viiiiisualization'),),
          body: Center(    
          child: //CovidPage()
                //ClimatePage()
                //MapsPage()
                WorldMapPage()
          ),

        drawer: Drawer(
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
        ),
      ),
      );
  }
}
