import 'dart:convert';
//import 'package:corona_stats_app/app/services/endpoint_data.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
//import 'package:corona_stats_app/app/services/api.dart';

class APIServiceClimate {
    static Future<String> getData() async {
      // Actual type: (instead of var) http.Response response = await...
    var response = await http.get(
      Uri.encodeFull("https://jsonplaceholder.typicode.com/posts"),
      headers: {
        "Accept": "application/json"
      }
      // If it's not an open API:
      // headers: {
      //   "key" : "key3452"
      // }
    );
    print(response.body);
  }
}
