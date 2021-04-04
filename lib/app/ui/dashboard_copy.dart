import 'dart:io';
import 'package:corona_stats_app/app/repositories/data_repositories.dart';
import 'package:corona_stats_app/app/repositories/endpoints_data.dart';
import 'package:corona_stats_app/app/services/api.dart';
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
          return Scaffold(
      appBar: AppBar(
        title: Text('Coronavirus Tracker'),
      ),
      body: RefreshIndicator(
        onRefresh: _updateData,
        child: ListView(
          children: <Widget>[
            // Row 1 - Status text:
            LastUpdatedStatusText(
              text: formatter.lastUpdatedStatusText(),
            ),
            // Row 2 0 The chart
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,

              children: [ 
              Text('Corona Stats',
              textAlign: TextAlign.center, 
              style: Theme.of(context).textTheme.headline4),
            ]),
             Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
 
              children: [ 
              LineGraph(
              value: _endpointsData != null
                    ? _endpointsData.values[Endpoint.values[0]]?.value
                    : null,
              )],),
            // Row 3 - the cards.
            for (var endpoint in Endpoint.values)
              EndpointCard(
                endpoint: endpoint,
                value: _endpointsData != null
                    ? _endpointsData.values[endpoint]?.value
                    : null,
              ),
          ],
        ),
      ),
    );
  }
}
