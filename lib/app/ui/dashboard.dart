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

      return  Scaffold(
        appBar: AppBar(title: Text('Data Visualization'),),
        body: Center(
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 30, 0, 10),
                child: Text(
                header,
                textAlign: TextAlign.center,
                style: Theme.of(context)
                  .textTheme
                  .headline3
                  .copyWith(color: Colors.white, fontWeight: FontWeight.w800),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 5),
                child: Text(
                  'Visualization type:',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color.fromRGBO(255, 255, 255, 0.8),
                    fontSize: 16,
                  )
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [ // onPressed: () {},
                  ElevatedButton(onPressed: () => setState(() => {
                    showLineGraph = !showLineGraph,
                    showPieChart = false,
                    showBubbleChart = false
                    }), 
                  child: Text('Linear Graph'), 
                  style: ElevatedButton.styleFrom(
                    primary: showLineGraph? Colors.purple : Colors.blue,
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                    textStyle: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold
                    )
                  ),
                  ),
                  ElevatedButton(onPressed: () => setState(() => {
                    showPieChart = !showPieChart,
                    showLineGraph = false,
                    showBubbleChart = false
                    }), 
                  child: Text('Pie Chart'),
                  style: ElevatedButton.styleFrom(
                    primary: showLineGraph? Colors.blue : Colors.purple,
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                    textStyle: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold
                    )
                    ),
                  ),
                  ElevatedButton(onPressed: () => setState(() => {
                    showBubbleChart = !showBubbleChart,
                    showPieChart = false,
                    showLineGraph = false
                    }), 
                  child: Text('Bubble Chart')),
                ],
              ),
              if(showLineGraph)
                LineGraph(
                  value: _endpointsData != null
                      ? _endpointsData.values[Endpoint.values[0]]?.value
                      : null,
                )
              else if(showPieChart)
                PieChart(
                value: _endpointsData != null
                      ? _endpointsData.values[Endpoint.values[0]]?.value
                      : null,
                )else if(showBubbleChart)
                 BubbleChart(
                  value: _endpointsData != null
                      ? _endpointsData.values[Endpoint.values[0]]?.value
                      : null,
                )else
                Text('Choose a visualizationtype above'),
               Padding(
                 padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                 child: Text(
                  'The data used:',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color.fromRGBO(255, 255, 255, 0.8),
                    fontSize: 18,
                    
                  )
              ),
               ),
              for (var endpoint in Endpoint.values)
              EndpointCard(
                endpoint: endpoint,
                value: _endpointsData != null
                    ? _endpointsData.values[endpoint]?.value
                    : null,
              )
            ],
          )
          
          ),
      );
  }
}
