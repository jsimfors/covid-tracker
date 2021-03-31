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
} 