import 'package:corona_stats_app/app/repositories/data.dart';
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
    const PieChart ({Key key, this.value}) : super(key: key);
    final int value;

  Widget build(BuildContext context) {
        return SfCircularChart(series: <CircularSeries>[
                        // Render pie chart
                        PieSeries<ChartData, String>(
                            dataSource: pieChartData(value),
                            pointColorMapper:(ChartData data,  _) => data.color,
                            xValueMapper: (ChartData data, _) => data.x,
                            yValueMapper: (ChartData data, _) => data.y
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
                            BubbleSeries<BubbleChartData, double>(
                                dataSource: bubbleChartData(value),
                                sizeValueMapper: (BubbleChartData sales, _) => sales.size,
                                pointColorMapper:(BubbleChartData sales, _) => sales.pointColor,
                                minimumRadius:9, // Minimum radius of bubble
                                maximumRadius: 30, // Maximum radius of bubble
                                xValueMapper: (BubbleChartData sales, _) => sales.x,
                                yValueMapper: (BubbleChartData sales, _) => sales.y
                            )
                        ]
                    );
  }
}
