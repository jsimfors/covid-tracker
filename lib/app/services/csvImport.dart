import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

import 'package:csv/csv.dart';
/*
For future extensions - to choose exactly what contries to visualize yourself! :)
Future<List> _loadCSV() async {
    final _rawData = await rootBundle.loadString("assets/iso-country-codes.csv");
    List<List<dynamic>> _listData = CsvToListConverter().convert(_rawData);
    setState(() {
      _data = _listData;
      //print("the data: " + _data.toString());
      // Vill: matcha widget.countryISO[0] med _data[i][kolumn 2]. 
      // är de matchar vill jag returnera _data[i][kolumn 0]
      if(widget.countryISO!=null){
        for(int i = 7; i<30; i=i+5){
          print("The country ISO to match: " + widget.countryISO[0]);
          print("trying to match with: " +  _data[0][i]);
          if(widget.countryISO[0]== _data[0][i]){
            print("Match! " + widget.countryISO[0] + " is " + _data[0][i-2]);
            countryNames.add(_data[0][i-2]);
            break;
          }
        }
        /*
        print("The country ISO: " + widget.countryISO[0]);
        print("The matching on line 1: (AFG?) " + _data[0][7]);
        print("Matching country name: " +  _data[0][5]);
        print("The matching on line 2: (ALA?) " + _data[0][7+5]);
        print("Matching country name: " +  _data[0][10]);
        */

  //_loadCSV();
*/