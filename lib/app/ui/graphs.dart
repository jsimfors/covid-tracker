import 'package:corona_stats_app/app/repositories/data.dart';
import 'package:corona_stats_app/app/repositories/endpoints_data.dart';
import 'package:corona_stats_app/app/services/api.dart';
import 'package:corona_stats_app/app/services/endpoint_data.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

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
    const BubbleChart ({Key key, this.value}) : super(key: key);
    final int value;

  Widget build(BuildContext context) { 
        return  SfCartesianChart(
                        series: <ChartSeries>[
                            // Renders bubble chart
                            BubbleSeries<CasesCathegorized, double>(
                                dataSource: bubbleChartData(value),
                                sizeValueMapper: (CasesCathegorized sales, _) => sales.size,
                                pointColorMapper:(CasesCathegorized sales, _) => sales.pointColor,
                                minimumRadius:9, // Minimum radius of bubble
                                maximumRadius: 30, // Maximum radius of bubble
                                xValueMapper: (CasesCathegorized sales, _) => sales.x,
                                yValueMapper: (CasesCathegorized sales, _) => sales.y
                            )
                        ]
                    );
  }
}
