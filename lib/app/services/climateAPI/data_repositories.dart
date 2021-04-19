
import 'package:corona_stats_app/app/components/maps.dart';
import 'package:corona_stats_app/app/components/world_map.dart';
import 'package:corona_stats_app/app/services/climateAPI/api_service.dart';
import 'package:corona_stats_app/app/ui/dashboard.dart';
import 'package:flutter/material.dart';

class ClimatePage extends StatefulWidget {
  static const String routeName = '/climate';

  final String url;
  final List<double> averageFromAPI;
  const ClimatePage({Key key, this.url, this.averageFromAPI}) : super(key: key);

  @override
  _ClimatePageState createState() => _ClimatePageState();
}

class _ClimatePageState extends State<ClimatePage> {
  final TextEditingController _fromYearController = TextEditingController();
  final TextEditingController _toYearController = TextEditingController();
  final TextEditingController _countryISOsController = TextEditingController();
  final TextEditingController _rainOrTemp = TextEditingController();
  ClimateApi _climateApi;
  double _average;
  double _averageVal1;
  double _averageVal2;
  double _averageVal3;
  List<double> _averageValList;


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
              key: ValueKey('rainOrTemp'),
              controller: _rainOrTemp,
              decoration: InputDecoration(hintText: 'pr or tas'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              key: ValueKey('countryISOs'),
              controller: _countryISOsController,
              decoration:
                  InputDecoration(hintText: 'Country ISOs (space separated)'),
            ),
            ElevatedButton(
              key: ValueKey('getAverage'),
              child: Text('Get Average Annual Rainfall'),
              onPressed: getValues, //getAverage,
            ),
             Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text('World Annual Rainfall per Country'),
            ),
             Text(
              '${_averageVal1 ?? ''}',
              key: ValueKey('average'),
              style: Theme.of(context).textTheme.display1,
            ),
            WorldMapPage(averageFromAPI: widget.averageFromAPI)
          ],
        ),
      );
  }

 Future<void> getAverage() async {
    var value = await _climateApi.getAverageAnnual(
      fromYear: int.parse(_fromYearController.text),
      toYear: int.parse(_toYearController.text),
      rainOrTemp: _rainOrTemp.text,
      countryISOs: _countryISOsController.text.split(' '),
    );
    setState(() {
      _average = value;
    });
  }

 Future<void> getValues() async {
   List<String> countryISOhardcode = ['SWE', 'USA', 'BRA'];


  // Sweden
    var value1 = await _climateApi.getAverageAnnual(
      fromYear: int.parse('1980'),
      toYear: int.parse('1999'),
      rainOrTemp: 'pr',
      countryISOs: countryISOhardcode.sublist(0)
    );
    setState(() {
      _averageVal1 = value1;
       /*Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) {
                  return WorldMapPage(averageFromAPI: value);
                }));*/
    });

    // USA
    var value2 = await _climateApi.getAverageAnnual(
      fromYear: int.parse('1980'),
      toYear: int.parse('1999'),
      rainOrTemp: 'pr',
      countryISOs: countryISOhardcode.sublist(1)
    );
    setState(() {
      _averageVal2 = value2;
       /*Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) {
                  return WorldMapPage(averageFromAPI: value);
                }));*/
    });

    // Brazil
    var value3 = await _climateApi.getAverageAnnual(
      fromYear: int.parse('1980'),
      toYear: int.parse('1999'),
      rainOrTemp: 'pr',
      countryISOs: countryISOhardcode.sublist(2)
    );
    setState(() {
      _averageVal3 = value3;
      _averageValList = [_averageVal1, _averageVal2, _averageVal3];

       Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
                  return Dashboard(averageFromAPI: _averageValList);
                  //WorldMapPage(averageFromAPI: _averageValList);
                }));
    });
  }

}


