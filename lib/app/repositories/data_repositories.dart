import 'package:corona_stats_app/app/repositories/endpoints_data.dart';
import 'package:corona_stats_app/app/services/api.dart';
import 'package:corona_stats_app/app/services/api_service.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

class DataRepository{
  DataRepository({ @required this.apiService});
  final APIService apiService;

  String _accessToken;

  Future<int> getEndpointData(Endpoint endpoint) async => 
  // wec call _getDataRefreshingToken to make the API call, getData is the argument function for this API-call.
    await _getDataRefreshingToken<int>(
    onGetData: () => apiService.getEndpointData(
      accessToken: _accessToken, endpoint: endpoint),
  );

  Future<EndpointsData> getAllEndpointsData() async => 
  // wec call _getDataRefreshingToken to make the API call, getData is the argument function for this API-call.
    await _getDataRefreshingToken<EndpointsData>(
    onGetData: _getAllEndpointsData,
  );


  Future<T> _getDataRefreshingToken<T>({Future<T> Function() onGetData}) async {
  // Generic method to handle try and catch for both get endpointData and getAllEndpointsData.
  // With this method we have only a single call in getEndpointData and _getAllEndpointsData.
  // {Future<T> Function() onGetData} means we have a function as an argument, since we need different
  // functios, for the different calls EndpointsData and allEndpointsData.
  try {
    if (_accessToken == null){
      _accessToken = await apiService.getAccessToken();
    }
      return await onGetData();
    } on Response catch (response) {
      if (response.statusCode == 401){
        // If the accesstoken has expired
          _accessToken = await apiService.getAccessToken();
          return await onGetData();
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