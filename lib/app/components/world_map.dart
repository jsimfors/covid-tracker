import 'package:corona_stats_app/app/services/climateAPI/api_service.dart';
import 'package:corona_stats_app/app/services/climateAPI/data_repositories.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_maps/maps.dart';

class WorldMapPage extends StatefulWidget {
  WorldMapPage({Key key, this.title, this.url, this.averageFromAPI}) : super(key: key);

  final String title;
  static const String routeName = '/climate';
  final String url;
  final double averageFromAPI;

  @override
  _WorldMapPageState createState() => _WorldMapPageState();
}

class _WorldMapPageState extends State<WorldMapPage> {

  List<_CountryDensityModel> _worldPopulationDensityDetails;
  List<_CountryDensityModel> _worldPopulationDensityDetails2;

  MapShapeSource _mapShapeSource;
  ClimateApi _climateApi;
  double _average = 404;

  @override
  void initState() {
     super.initState();
      if (widget.url != null)
        _climateApi = ClimateApi(apiUrl: widget.url);
      else
        _climateApi = ClimateApi();

  _worldPopulationDensityDetails = <_CountryDensityModel>[
      _CountryDensityModel('Germany', widget.averageFromAPI!=null?widget.averageFromAPI:100 ),
      _CountryDensityModel('United States of America', 20)
    ];



    _worldPopulationDensityDetails2 = <_CountryDensityModel>[
      _CountryDensityModel('Monaco', 26337),
      _CountryDensityModel('Macao', 21717),
      _CountryDensityModel('Singapore', 8358),
      _CountryDensityModel('Hong kong', 7140),
      _CountryDensityModel('Gibraltar', 3369),
      _CountryDensityModel('Bahrain', 2239),
      _CountryDensityModel('Holy See', 1820),
      _CountryDensityModel('Maldives', 1802),
      _CountryDensityModel('Malta', 1380),
      _CountryDensityModel('Bangladesh', 1265),
      _CountryDensityModel('Sint Maarten', 1261),
      _CountryDensityModel('Bermuda', 1246),
      _CountryDensityModel('Channel Islands', 915),
      _CountryDensityModel('State of Palestine', 847),
      _CountryDensityModel('Saint-Martin', 729),
      _CountryDensityModel('Mayotte', 727),
      _CountryDensityModel('Taiwan', 672),
      _CountryDensityModel('Barbados', 668),
      _CountryDensityModel('Lebanon', 667),
      _CountryDensityModel('Mauritius', 626),
      _CountryDensityModel('Aruba', 593),
      _CountryDensityModel('San Marino', 565),
      _CountryDensityModel('Nauru', 541),
      _CountryDensityModel('Korea', 527),
      _CountryDensityModel('Rwanda', 525),
      _CountryDensityModel('Netherlands', 508),
      _CountryDensityModel('Comoros', 467),
      _CountryDensityModel('India', 464),
      _CountryDensityModel('Burundi', 463),
      _CountryDensityModel('Saint-Barthélemy', 449),
      _CountryDensityModel('Haiti', 413),
      _CountryDensityModel('Israel', 400),
      _CountryDensityModel('Tuvalu', 393),
      _CountryDensityModel('Belgium', 382),
      _CountryDensityModel('Curacao', 369),
      _CountryDensityModel('Philippines', 367),
      _CountryDensityModel('Reunion', 358),
      _CountryDensityModel('Martinique', 354),
      _CountryDensityModel('Japan', 346),
      _CountryDensityModel('Sri Lanka', 341),
      _CountryDensityModel('Grenada', 331),
      _CountryDensityModel('Marshall Islands', 328),
      _CountryDensityModel('Puerto Rico', 322),
      _CountryDensityModel('Vietnam', 313),
      _CountryDensityModel('El Salvador', 313),
      _CountryDensityModel('Guam', 312),
      _CountryDensityModel('Saint Lucia', 301),
      _CountryDensityModel('United States Virgin Islands', 298),
      _CountryDensityModel('Pakistan', 286),
      _CountryDensityModel('Saint Vincent and the Grenadines', 284),
      _CountryDensityModel('United Kingdom', 280),
      _CountryDensityModel('American Samoa', 276),
      _CountryDensityModel('Cayman Islands', 273),
      _CountryDensityModel('Jamaica', 273),
      _CountryDensityModel('Trinidad and Tobago', 272),
      _CountryDensityModel('Qatar', 248),
      _CountryDensityModel('Guadeloupe', 245),
      _CountryDensityModel('Luxembourg', 241),
      _CountryDensityModel('Germany', 240),
      _CountryDensityModel('Kuwait', 239),
      _CountryDensityModel('Gambia', 238),
      _CountryDensityModel('Liechtenstein', 238),
      _CountryDensityModel('Uganda', 228),
      _CountryDensityModel('Sao Tome and Principe', 228),
      _CountryDensityModel('Nigeria', 226),
      _CountryDensityModel('Dominican Rep.', 224),
      _CountryDensityModel('Antigua and Barbuda', 222),
      _CountryDensityModel('Switzerland', 219),
      _CountryDensityModel('Dem. Rep. Korea', 214),
      _CountryDensityModel('Seychelles', 213),
      _CountryDensityModel('Italy', 205),
      _CountryDensityModel('Saint Kitts and Nevis', 204),
      _CountryDensityModel('Nepal', 203),
      _CountryDensityModel('Malawi', 202),
      _CountryDensityModel('British Virgin Islands', 201),
      _CountryDensityModel('Guatemala', 167),
      _CountryDensityModel('Anguilla', 166),
      _CountryDensityModel('Andorra', 164),
      _CountryDensityModel('Micronesia', 164),
      _CountryDensityModel('China', 153),
      _CountryDensityModel('Togo', 152),
      _CountryDensityModel('Indonesia', 151),
      _CountryDensityModel('Isle of Man', 149),
      _CountryDensityModel('Kiribati', 147),
      _CountryDensityModel('Tonga', 146),
      _CountryDensityModel('Czech Rep.', 138),
      _CountryDensityModel('Cabo Verde', 138),
      _CountryDensityModel('Thailand', 136),
      _CountryDensityModel('Ghana', 136),
      _CountryDensityModel('Denmark', 136),
      _CountryDensityModel('Tokelau', 135),
      _CountryDensityModel('Cyprus', 130),
      _CountryDensityModel('Northern Mariana Islands', 125),
      _CountryDensityModel('Poland', 123),
      _CountryDensityModel('Moldova', 122),
      _CountryDensityModel('Azerbaijan', 122),
      _CountryDensityModel('France', 119),
      _CountryDensityModel('United Arab Emirates', 118),
      _CountryDensityModel('Ethiopia', 115),
      _CountryDensityModel('Jordan', 114),
      _CountryDensityModel('Slovakia', 113),
      _CountryDensityModel('Portugal', 111),
      _CountryDensityModel('Sierra Leone', 110),
      _CountryDensityModel('Turkey', 109),
      _CountryDensityModel('Austria', 109),
      _CountryDensityModel('Benin', 107),
      _CountryDensityModel('Hungary', 106),
      _CountryDensityModel('Cuba', 106),
      _CountryDensityModel('Albania', 105),
      _CountryDensityModel('Armenia', 104),
      _CountryDensityModel('Slovenia', 103),
      _CountryDensityModel('Egypt', 102),
      _CountryDensityModel('Serbia', 99),
      _CountryDensityModel('Costa Rica', 99),
      _CountryDensityModel('Malaysia', 98),
      _CountryDensityModel('Dominica', 95),
      _CountryDensityModel('Syria', 95),
      _CountryDensityModel('Cambodia', 94),
      _CountryDensityModel('Kenya', 94),
      _CountryDensityModel('Spain', 93),
      _CountryDensityModel('Iraq', 92),
      _CountryDensityModel('Timor-Leste', 88),
      _CountryDensityModel('Honduras', 88),
      _CountryDensityModel('Senegal', 86),
      _CountryDensityModel('Romania', 83),
      _CountryDensityModel('Myanmar', 83),
      _CountryDensityModel('Brunei Darussalam', 83),
      _CountryDensityModel("Côte d'Ivoire", 82),
      _CountryDensityModel('Morocco', 82),
      _CountryDensityModel('Macedonia', 82),
      _CountryDensityModel('Greece', 80),
      _CountryDensityModel('Wallis and Futuna Islands', 80),
      _CountryDensityModel('Bonaire, Sint Eustatius and Saba', 79),
      _CountryDensityModel('Uzbekistan', 78),
      _CountryDensityModel('French Polynesia', 76),
      _CountryDensityModel('Burkina Faso', 76),
      _CountryDensityModel('Tunisia', 76),
      _CountryDensityModel('Ukraine', 75),
      _CountryDensityModel('Croatia', 73),
      _CountryDensityModel('Cook Islands', 73),
      _CountryDensityModel('Ireland', 71),
      _CountryDensityModel('Ecuador', 71),
      _CountryDensityModel('Lesotho', 70),
      _CountryDensityModel('Samoa', 70),
      _CountryDensityModel('Guinea-Bissau', 69),
      _CountryDensityModel('Tajikistan', 68),
      _CountryDensityModel('Eswatini', 67),
      _CountryDensityModel('Tanzania', 67),
      _CountryDensityModel('Mexico', 66),
      _CountryDensityModel('Bosnia and Herz.', 64),
      _CountryDensityModel('Bulgaria', 64),
      _CountryDensityModel('Afghanistan', 59),
      _CountryDensityModel('Panama', 58),
      _CountryDensityModel('Georgia', 57),
      _CountryDensityModel('Yemen', 56),
      _CountryDensityModel('Cameroon', 56),
      _CountryDensityModel('Nicaragua', 55),
      _CountryDensityModel('Guinea', 53),
      _CountryDensityModel('Liberia', 52),
      _CountryDensityModel('Iran', 51),
      _CountryDensityModel('Eq. Guinea', 50),
      _CountryDensityModel('Montserrat', 49),
      _CountryDensityModel('Fiji', 49),
      _CountryDensityModel('South Africa', 48),
      _CountryDensityModel('Madagascar', 47),
      _CountryDensityModel('Montenegro', 46),
      _CountryDensityModel('Belarus', 46),
      _CountryDensityModel('Colombia', 45),
      _CountryDensityModel('Lithuania', 43),
      _CountryDensityModel('Djibouti', 42),
      _CountryDensityModel('Turks and Caicos Islands', 40),
      _CountryDensityModel('Mozambique', 39),
      _CountryDensityModel('Dem. Rep. Congo', 39),
      _CountryDensityModel('Palau', 39),
      _CountryDensityModel('Bahamas', 39),
      _CountryDensityModel('Zimbabwe', 38),
      _CountryDensityModel('United States of America', 36),
      _CountryDensityModel('Eritrea', 35),
      _CountryDensityModel('Faroe Islands', 35),
      _CountryDensityModel('Kyrgyzstan', 34),
      _CountryDensityModel('Venezuela', 32),
      _CountryDensityModel('Lao PDR', 31),
      _CountryDensityModel('Estonia', 31),
      _CountryDensityModel('Latvia', 30),
      _CountryDensityModel('Angola', 26),
      _CountryDensityModel('Peru', 25),
      _CountryDensityModel('Chile', 25),
      _CountryDensityModel('Brazil', 25),
      _CountryDensityModel('Somalia', 25),
      _CountryDensityModel('Vanuatu', 25),
      _CountryDensityModel('Saint Pierre and Miquelon', 25),
      _CountryDensityModel('Sudan', 24),
      _CountryDensityModel('Zambia', 24),
      _CountryDensityModel('Sweden', 24),
      _CountryDensityModel('Solomon Islands', 24),
      _CountryDensityModel('Bhutan', 20),
      _CountryDensityModel('Uruguay', 19),
      _CountryDensityModel('Papua New Guinea', 19),
      _CountryDensityModel('Niger', 19),
      _CountryDensityModel('Algeria', 18),
      _CountryDensityModel('S. Sudan', 18),
      _CountryDensityModel('New Zealand', 18),
      _CountryDensityModel('Finland', 18),
      _CountryDensityModel('Paraguay', 17),
      _CountryDensityModel('Belize', 17),
      _CountryDensityModel('Mali', 16),
      _CountryDensityModel('Argentina', 16),
      _CountryDensityModel('Oman', 16),
      _CountryDensityModel('Saudi Arabia', 16),
      _CountryDensityModel('Congo', 16),
      _CountryDensityModel('New Caledonia', 15),
      _CountryDensityModel('Saint Helena', 15),
      _CountryDensityModel('Norway', 14),
      _CountryDensityModel('Chad', 13),
      _CountryDensityModel('Turkmenistan', 12),
      _CountryDensityModel('Bolivia', 10),
      _CountryDensityModel('Russia', 8),
      _CountryDensityModel('Gabon', 8),
      _CountryDensityModel('Central African Rep.', 7),
      _CountryDensityModel('Kazakhstan', 6),
      _CountryDensityModel('Niue', 6),
      _CountryDensityModel('Mauritania', 4),
      _CountryDensityModel('Canada', 4),
      _CountryDensityModel('Botswana', 4),
      _CountryDensityModel('Guyana', 3),
      _CountryDensityModel('Libya', 3),
      _CountryDensityModel('Suriname', 3),
      _CountryDensityModel('French Guiana', 3),
      _CountryDensityModel('Iceland', 3),
      _CountryDensityModel('Australia', 3),
      _CountryDensityModel('Namibia', 3),
      _CountryDensityModel('W. Sahara', 2),
      _CountryDensityModel('Mongolia', 2),
      _CountryDensityModel('Falkland Is.', 0.2),
      _CountryDensityModel('Greenland', 0.1),
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
        //Text(widget.averageFromAPI.toString()),
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