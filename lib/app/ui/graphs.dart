import 'package:corona_stats_app/app/repositories/data.dart';
import 'package:corona_stats_app/app/repositories/endpoints_data.dart';
import 'package:corona_stats_app/app/services/api.dart';
import 'package:corona_stats_app/app/services/endpoint_data.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:corona_stats_app/app/ui/dashboard.dart';

class LineGraph extends StatelessWidget {
    const LineGraph({Key key, this.value}) : super(key: key);
    final int value;

  Widget build(BuildContext context) {
    return SfCartesianChart(
            primaryXAxis: CategoryAxis(),
            title: ChartTitle(text: 'Confirmed cases over time'), //Chart title.
            legend: Legend(isVisible: false), // Enables the legend.
            tooltipBehavior: TooltipBehavior(enable: true), // Enables the tooltip.
            series: <LineSeries<PreviousCovid, String>>[
              LineSeries<PreviousCovid, String>(
                dataSource: previousCovidData(value),
                xValueMapper: (PreviousCovid prevData, _) => prevData.monthYear,
                yValueMapper: (PreviousCovid prevData, _) => prevData.casesMY,
                dataLabelSettings: DataLabelSettings(isVisible: true) // Enables the data label.
              )
            ],
    );
  }
}

class PieChart extends StatelessWidget {
    const PieChart({Key key, this.valueR, this.valueD}) : super(key: key);
    final int valueR;
    final int valueD;

  Widget build(BuildContext context) {
        return SfCircularChart(
          title: ChartTitle(text: 'Proportion Recovered & Deaths'),
          series: <CircularSeries>[
                        // Render pie chart
                        PieSeries<CasesSuspRecov, String>(
                            dataSource: [
                              CasesSuspRecov('Recovered', valueR.toDouble()),
                              CasesSuspRecov('Deaths', valueD.toDouble()),
                            ],
                            pointColorMapper:(CasesSuspRecov data,  _) => data.color,
                            xValueMapper: (CasesSuspRecov data, _) => data.x,
                            yValueMapper: (CasesSuspRecov data, _) => data.y,
                            dataLabelMapper: (CasesSuspRecov data, _) => data.x,
                            dataLabelSettings: DataLabelSettings(
                                    // Renders the data label
                                    isVisible: true
                                    
                                )
                        )
                    ]
                );
  }
}


class BubbleChart extends StatelessWidget {
    const BubbleChart({Key key, this.valueList, this.endpoints}) : super(key: key);

    final List<Endpoint> valueList;
    final Map<Endpoint, EndpointData> endpoints;


  Widget build(BuildContext context) { 
        return  SfCartesianChart(
                      primaryXAxis: CategoryAxis(),
                      title: ChartTitle(text: 'Size comparison'), //Chart title.
                        series:  <ChartSeries<CasesCathegorized, String>>[
                            // Renders bubble chart
                            BubbleSeries<CasesCathegorized, String>(
                                dataSource: [
                                  CasesCathegorized('Cases', endpoints[valueList[0]].value.toDouble(), endpoints[valueList[0]].value.toDouble(), const Color.fromRGBO(255, 0, 255, 0.5)),
                                  CasesCathegorized('Suspected Cases',  endpoints[valueList[1]].value.toDouble(), endpoints[valueList[1]].value.toDouble(), const Color.fromRGBO(0, 0, 255, 0.7)),
                                  CasesCathegorized('Confirmed Cases', endpoints[valueList[2]].value.toDouble(), endpoints[valueList[2]].value.toDouble(), const Color.fromRGBO(0, 255, 255, 0.7)),
                                  CasesCathegorized('Deaths',  endpoints[valueList[3]].value.toDouble(), endpoints[valueList[3]].value.toDouble(), const Color.fromRGBO(255, 255, 25, 0.7)),
                                  CasesCathegorized('Recovered',  endpoints[valueList[4]].value.toDouble(), endpoints[valueList[4]].value.toDouble(), const Color.fromRGBO(255, 0, 255, 0.7))
                                ],
                                sizeValueMapper: (CasesCathegorized sales, _) => sales.size,
                                pointColorMapper:(CasesCathegorized sales, _) => sales.pointColor,
                                minimumRadius:9, // Minimum radius of bubble
                                maximumRadius: 30, // Maximum radius of bubble
                                xValueMapper: (CasesCathegorized sales, _) => sales.x,
                                yValueMapper: (CasesCathegorized sales, _) => sales.y,
                                dataLabelMapper:(CasesCathegorized data, _) => data.x,
                                 dataLabelSettings: DataLabelSettings( isVisible: true )
                            )
                        ]
                    );
  }
}
