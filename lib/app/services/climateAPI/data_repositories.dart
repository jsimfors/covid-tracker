
import 'package:corona_stats_app/app/services/climateAPI/api_service.dart';
import 'package:flutter/material.dart';

class ClimatePage extends StatefulWidget {
  final String url;

  const ClimatePage({Key key, this.url}) : super(key: key);

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
        child: ListView(
          //mainAxisAlignment: MainAxisAlignment.center,
          shrinkWrap: true,
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
              onPressed: getAverage,
            ),
            Text(
              '${_average ?? ''}',
              key: ValueKey('average'),
              style: Theme.of(context).textTheme.display1,
            ),
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
}