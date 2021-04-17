
import 'package:corona_stats_app/app/components/maps.dart';
import 'package:corona_stats_app/app/components/world_map.dart';
import 'package:corona_stats_app/app/services/climateAPI/api_service.dart';
import 'package:flutter/material.dart';
import 'package:corona_stats_app/app/services/climateAPI/api_service.dart';
import 'package:corona_stats_app/app/services/climateAPI/data_repositories.dart';
import 'package:syncfusion_flutter_maps/maps.dart';


class ClimatePage extends StatefulWidget {
  static const String routeName = '/climate';

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
  double _averageVal;

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
            Text(
              '${_averageVal ?? ''}',
              key: ValueKey('average'),
              style: Theme.of(context).textTheme.display1,
            )
            /*
            Text(
              '${_average ?? ''}',
              key: ValueKey('average'),
              style: Theme.of(context).textTheme.display1,
            ),*/
          
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
    var value = await _climateApi.getAverageAnnual(
      fromYear: int.parse('1920'),
      toYear: int.parse('1939'),
      rainOrTemp: 'pr',
      countryISOs: ['SWE'],
    );
    setState(() {
      _averageVal = value; //value for SWE
      Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => WorldMapPage(averageVal: value),
                ),);
    });
    return value;
  }

}


class WorldMapPage extends StatefulWidget {
  WorldMapPage({Key key, this.title, this.url, this.averageVal}) : super(key: key);

  final String title;
  static const String routeName = '/climate';
  final String url;
  final double averageVal;

  @override
  _WorldMapPageState createState() => _WorldMapPageState();
}

class _WorldMapPageState extends State<WorldMapPage> {

  List<_CountryDensityModel> _worldPopulationDensityDetails;

  MapShapeSource _mapShapeSource;
  ClimateApi _climateApi;

  @override
  void initState() {
     super.initState();
      if (widget.url != null)
        _climateApi = ClimateApi(apiUrl: widget.url);
      else
        _climateApi = ClimateApi();

  _worldPopulationDensityDetails = <_CountryDensityModel>[
      _CountryDensityModel('Sweden', widget.averageVal ),
      _CountryDensityModel('United States of America', widget.averageVal)
    ];


    _mapShapeSource = MapShapeSource.asset(
      'assets/world_map.json',
      shapeDataField: 'name',
      dataCount: _worldPopulationDensityDetails.length,
      primaryValueMapper: (int index) =>
          _worldPopulationDensityDetails[index].countryName,
      shapeColorValueMapper: (int index) =>
          _worldPopulationDensityDetails[index].density,
      shapeColorMappers: const [
        MapColorMapper(
            from: 0,
            to: 25,
            color: Color.fromRGBO(223, 169, 254, 1),
            text: '{0},{25}'),
        MapColorMapper(
            from: 25,
            to: 75,
            color: Color.fromRGBO(190, 78, 253, 1),
            text: '75'),
        MapColorMapper(
            from: 75,
            to: 150,
            color: Color.fromRGBO(167, 17, 252, 1),
            text: '150'),
        MapColorMapper(
            from: 150,
            to: 400,
            color: Color.fromRGBO(152, 3, 236, 1),
            text: '400'),
        MapColorMapper(
            from: 400,
            to: 50000,
            color: Color.fromRGBO(113, 2, 176, 1),
            text: '>500'),
      ],
    );
    super.initState();

  }

  // @override
  // void dispose() {
  //   _worldPopulationDensityDetails?.clear();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text('World Annual Rainfall per Country'),
        ),
        SfMaps(
          layers: [
            MapShapeLayer(
                source: _mapShapeSource,
                strokeColor: Colors.white30,
                legend: MapLegend.bar(MapElement.shape,
                    position: MapLegendPosition.bottom,
                    segmentSize: Size(55.0, 9.0))),
          ],
        ),
      ],
    );
  }
  /*
  Future<double> getAverageForMap(String code) async {
    var value = await _climateApi.getAverageAnnual(
      fromYear: int.parse('1980'),
      toYear: int.parse('1999'),
      rainOrTemp: 'pr',
      countryISOs: [code],
    );
    setState(() {
      _average = value;
    });
    return value;
  }*/
}

class _CountryDensityModel {
  _CountryDensityModel(this.countryName, this.density);

  final String countryName;
  final double density;
}