import 'package:corona_stats_app/app/repositories/data_repositories.dart';
import 'package:corona_stats_app/app/services/api.dart';
import 'package:corona_stats_app/app/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'app/ui/dashboard.dart';

void main() async {
  Intl.defaultLocale = 'en_GB';
  await initializeDateFormatting();
  runApp(MyApp());
} 

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Provider<DataRepository>(
      create: (_) => DataRepository(
        apiService: APIService(API.sandbox()),),
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Coronavirus Tracker',
            theme: ThemeData.dark().copyWith(
              scaffoldBackgroundColor: Color(0xFF101010),
              cardColor: Color(0xFF222222),
            ),
            home: Dashboard(),
      ),
    );
  }
}

