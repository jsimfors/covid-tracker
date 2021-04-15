import 'package:corona_stats_app/app/components/drawer.dart';
import 'package:corona_stats_app/app/services/climateAPI/api_service.dart';
import 'package:corona_stats_app/app/ui/colors.dart';
import 'package:corona_stats_app/main.dart';
import 'package:flutter/material.dart';
import 'dart:io';
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


class CovidPage extends StatefulWidget {
    static const String routeName = '/covid';

    @override
  _CovidPageState createState() => _CovidPageState();

}

class _CovidPageState extends State<CovidPage> {

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

  final header = 'Corona Stats';

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

  Widget drawerMenu = DrawerSection();
  Map customColor = getCustomColors();
  String subheader = 'CHOOSE HOW TO VISUALIZE THE LATEST COVID-19 DATA';


  @override
  Widget build(BuildContext context) {
    
    return 
   Scaffold(
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
              child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(50, 30, 50, 20),
                child: Text(
                  subheader,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w500,
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
                    primary: showLineGraph? customColor['Dark Salmon'] : Colors.grey,
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
                    primary: showPieChart? customColor['Dark Salmon']  : Colors.grey,
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
                  child: Text('Bubble Chart'),
                   style: ElevatedButton.styleFrom(
                    primary: showBubbleChart? customColor['Dark Salmon']  : Colors.grey,
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                    textStyle: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      )
                    ),
                  )
                ],
              ),
              if(showPieChart)
                PieChart(
                // valueList: _endpointsData != null ? _endpointsData.values[Endpoint.values] : null,
                valueD: _endpointsData != null ?  _endpointsData.values[Endpoint.values[3]]?.value : null,
                valueR:  _endpointsData != null ?  _endpointsData.values[Endpoint.values[4]]?.value : null,
                )else if(showBubbleChart)
                 BubbleChart(
                  valueList: Endpoint != null ? Endpoint.values : null,
                  endpoints: _endpointsData != null ? _endpointsData.values : null,
                )else // if showLineGraph OR all false.
                LineGraph(
                  value: _endpointsData != null
                      ? _endpointsData.values[Endpoint.values[0]]?.value
                      : null),
               Padding(
                 padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                 child: Text(
                  'The data used:',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: customColor['Salmon'],
                    fontSize: 24,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold
                    
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
    ),        
            
        )
        ]
        )
        ),
        drawer: drawerMenu 
        );
    
  }
}
