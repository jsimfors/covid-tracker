
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;

class ClimateApi {
  static const climateApiUrl = 'http://climatedataapi.worldbank.org';

  final String apiUrl;

  ClimateApi({this.apiUrl = climateApiUrl});

  Future<double> getAverageAnnual({
    int fromYear,
    int toYear,
    String rainOrTemp,
    List<String> countryISOs,
  }) async {
    double sum = 0;

    for (String countryISO in countryISOs) {
      String url =
          '$apiUrl/climateweb/rest/v1/country/annualavg/$rainOrTemp/$fromYear/$toYear/$countryISO.xml';

      try {
        var response = await http.get(url);
        if (response.body
            .contains('Invalid country code. Three letters are required')) {
          throw ArgumentError(
              'Country code $countryISO not recognized by climateweb');
        }

        var root = xml.parse(response.body);
        var doubles = root.findAllElements('double').map(
              (d) => double.parse(d.text),
            );

        if (doubles.length == 0) {
          throw ArgumentError('Date range $fromYear - $toYear not supported');
        }

        double total = doubles.fold(0, (prev, d) => prev += d);
        sum += total / doubles.length;
      } on SocketException {
        throw Exception('Error occured while trying to send request to API');
      }
    }

    return sum / countryISOs.length;
  }
}