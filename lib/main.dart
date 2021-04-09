import 'package:corona_stats_app/app/repositories/data_repositories.dart';
import 'package:corona_stats_app/app/services/api.dart';
import 'package:corona_stats_app/app/services/api_service.dart';
import 'package:corona_stats_app/app/services/data_cache_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app/components/maps.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Intl.defaultLocale = 'en_GB';
  await initializeDateFormatting();
  // To get value asynchronously in void main() (Since getInstance() returns Final, and we're in build.)
  final sharedPreferences = await SharedPreferences.getInstance();
  runApp(MyApp(sharedPreferences: sharedPreferences));
} 

class MyApp extends StatelessWidget {
  const MyApp({Key key, @required this.sharedPreferences}) : super(key: key);
  final SharedPreferences sharedPreferences;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Provider<DataRepository>(
      create: (_) => DataRepository(
        apiService: APIService(API.sandbox()),
        dataCacheService: DataCacheService(
          sharedPreferences: sharedPreferences,
        ),
      ),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Statistics Visualizer',
          theme: ThemeData.dark().copyWith(
            scaffoldBackgroundColor: Color(0xFF101010),
            cardColor: Color(0xFF222222),
          ),
          // go back to: home: Dashboard(),
          home: MapsPage(),
      ),
    );
  }
}

