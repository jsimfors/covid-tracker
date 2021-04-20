
import 'package:corona_stats_app/app/components/maps.dart';
import 'package:corona_stats_app/app/components/world_map.dart';
import 'package:corona_stats_app/app/services/climateAPI/api_service.dart';
import 'package:corona_stats_app/app/ui/dashboard.dart';
import 'package:flutter/material.dart';

class ClimatePage extends StatefulWidget {
  static const String routeName = '/climate';

  final String url;
  final List<double> averageFromAPI;
  final List<String> countryISO;
  const ClimatePage({Key key, this.url, this.averageFromAPI, this.countryISO}) : super(key: key);

  @override
  _ClimatePageState createState() => _ClimatePageState();
}

class _ClimatePageState extends State<ClimatePage> {
  final TextEditingController _fromYearController = TextEditingController();
  final TextEditingController _toYearController = TextEditingController();
  final TextEditingController _countryISOsController = TextEditingController();
  bool _displayRain = true;

  ClimateApi _climateApi;
  double _average;
  String _averageString;
  double _averageVal1;
  double _averageVal2;
  double _averageVal3;
  List<double> _averageValList;
  List<String> _listOfCountries;


  @override
  void initState() {
    super.initState();
    if (widget.url != null)
      _climateApi = ClimateApi(apiUrl: widget.url);
    else
      _climateApi = ClimateApi();
  }
  
  @override
  Widget build(BuildContext context) {
    return 
      Container(  
        alignment: Alignment.center,
        margin: const EdgeInsets.all(32.0),
        child: Column(
          //scrollDirection: Axis.vertical,
          //mainAxisAlignment: MainAxisAlignment.center,
          //shrinkWrap: true,
          children: <Widget>[
            TextField(
              key: ValueKey('fromYear'),
              controller: _fromYearController,
              decoration: InputDecoration(hintText: 'From Year'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              key: ValueKey('toYear'),
              controller: _toYearController,
              decoration: InputDecoration(hintText: 'To Year'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              key: ValueKey('countryISOs'),
              controller: _countryISOsController,
              decoration:
                  InputDecoration(hintText: 'Country ISOs (space separated)'),
            ),
             Padding(
               padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
               child: Text(
                'Get Average Annual: ',
                style: Theme.of(context).textTheme.headline6, textAlign: TextAlign.center
            ),
             ),
            Row(  
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  key: ValueKey('getAverageRain'),
                  child: Text('Rainfall'),
                  onPressed: () => getAverage('pr'), //getAverage,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  key: ValueKey('getAverageTemp'),
                  child: Text('Temperature'),
                  onPressed: () => getAverage('tas'), //getAverage,
            ),
              ),],
            ),
             Padding(
              padding: const EdgeInsets.all(10.0),
              child: (_displayRain?Text('World Annual rainfall per Country'):Text('World Annual temperature per Country')),
            ),
             Text((_displayRain?'${_averageString ?? ''} mm':'${_averageString ?? ''}°C'),
              key: ValueKey('average'),
              style: Theme.of(context).textTheme.headline6,
            ),
            WorldMapPage(averageFromAPI: widget.averageFromAPI, countryISO: widget.countryISO)
          ],
        ),
      );
  }

   Future<void> getAverage(typeofdata) async {
    typeofdata=='pr'?_displayRain==true:_displayRain=false;

     // To use in future!
    var value = await _climateApi.getAverageAnnual(
      fromYear: int.parse(_fromYearController.text),
      toYear: int.parse(_toYearController.text),
      rainOrTemp: typeofdata,
      countryISOs: _countryISOsController.text.split(' '),
    );
    setState(() {
      _average = value;
      _averageString = value.toStringAsFixed(1);
      //_averageValList = valueList;
      _listOfCountries = _countryISOsController.text.split(' ');

    /* For future implementation, to pass data to WorldMapPage: (display data in map)
       Navigator.push(
         context, 
         PageRouteBuilder(
           pageBuilder: (context, __, _) =>  Dashboard(averageFromAPI: _averageValList),
           transitionDuration: Duration(seconds: 0)
                  //WorldMapPage(averageFromAPI: _averageValList);
       ));
    */
    });
  }

  }
