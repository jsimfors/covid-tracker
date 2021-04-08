
import 'package:corona_stats_app/app/services/climateAPI/api_service.dart';
import 'package:flutter/material.dart';

class AverageRainfallPage extends StatefulWidget {
  final String url;

  const AverageRainfallPage({Key key, this.url}) : super(key: key);

  @override
  _AverageRainfallPageState createState() => _AverageRainfallPageState();
}

class _AverageRainfallPageState extends State<AverageRainfallPage> {
  final TextEditingController _fromYearController = TextEditingController();
  final TextEditingController _toYearController = TextEditingController();
  final TextEditingController _countryISOsController = TextEditingController();
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Servertium Demo'),
      ),
      body: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
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
            RaisedButton(
              key: ValueKey('getAverageRainfall'),
              child: Text('Get Average Annual Rainfall'),
              onPressed: getAverageRainfall,
            ),
            Text(
              '${_average ?? ''}',
              key: ValueKey('average'),
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> getAverageRainfall() async {
    var value = await _climateApi.getAverageAnnualRainfall(
      fromYear: int.parse(_fromYearController.text),
      toYear: int.parse(_toYearController.text),
      countryISOs: _countryISOsController.text.split(' '),
    );
    setState(() {
      _average = value;
    });
  }
}