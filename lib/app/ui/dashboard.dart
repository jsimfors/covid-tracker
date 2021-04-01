import 'package:corona_stats_app/app/repositories/data_repositories.dart';
import 'package:corona_stats_app/app/services/api.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'endpoint_card.dart';


class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _cases;

  @override
  void initState() {
    super.initState();
    _updateData();
  }
  Future<void> _updateData() async {
    final dataRepository = Provider.of<DataRepository>(context, listen: false);
    final cases = await dataRepository.getEndpointData(Endpoint.cases);
    setState(() => _cases = cases);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Coronavirus tracker'),
      ),
      body: ListView(
        children: <Widget>[
          EndpointCard(
            endpoint: Endpoint.cases,
            value: _cases,
          ),
        ],
      ),
    );
  }
}