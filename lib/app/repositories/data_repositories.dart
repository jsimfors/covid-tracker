import 'package:corona_stats_app/app/repositories/endpoints_data.dart';
import 'package:corona_stats_app/app/services/api.dart';
import 'package:corona_stats_app/app/services/api_service.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

class DataRepository{
  DataRepository({ @required this.apiService});
  final APIService apiService;

  String _accessToken;
  Future<int> getEndpointData(Endpoint endpoint) async {
  try {
    if (_accessToken == null){
      _accessToken = await apiService.getAccessToken();
    }
      return await apiService.getEndpointData(
        accessToken: _accessToken, endpoint: endpoint
      );
    } on Response catch (response) {
      if (response.statusCode == 401){
        // If the accesstoken has expired
          _accessToken = await apiService.getAccessToken();
          return await apiService.getEndpointData(
            accessToken: _accessToken, endpoint: endpoint
          );
      } rethrow; // if we get neither code 200 or 401.
    }
  }
  Future<EndpointsData> _getAllEndpointsData() async {
    // To make all API-calls at once (instead of one after another)
    
    final values = await Future.wait([
      // All different futures are exectued parallell.
      apiService.getEndpointData(
        accessToken: _accessToken, endpoint: Endpoint.cases),
      apiService.getEndpointData(
        accessToken: _accessToken, endpoint: Endpoint.casesSuspected),
      apiService.getEndpointData(
        accessToken: _accessToken, endpoint: Endpoint.casesConfirmed),
      apiService.getEndpointData(
        accessToken: _accessToken, endpoint: Endpoint.deaths),
      apiService.getEndpointData(
        accessToken: _accessToken, endpoint: Endpoint.recovered)
    ]);
    return EndpointsData(
      // values: a list of ints.
      values: {
        Endpoint.cases: values[0],
        Endpoint.casesSuspected: values[1],
        Endpoint.casesConfirmed: values[2],
        Endpoint.deaths: values[3],
        Endpoint.recovered: values[4],
      },
    );  
  }
} 