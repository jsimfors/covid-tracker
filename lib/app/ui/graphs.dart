import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class SalesData {
  SalesData(this.year, this.sales);
  final String year;
  final double sales;
}

class LineGraph extends StatelessWidget {
    const LineGraph({Key key, this.value}) : super(key: key);
    final int value;

  Widget build(BuildContext context) {
    return SfCartesianChart(
            primaryXAxis: CategoryAxis(),
            title: ChartTitle(text: 'Confirmed cases over time'), //Chart title.
            legend: Legend(isVisible: false), // Enables the legend.
            tooltipBehavior: TooltipBehavior(enable: true), // Enables the tooltip.
            series: <LineSeries<SalesData, String>>[
              LineSeries<SalesData, String>(
                dataSource: [
                  SalesData('March 2020', 509164),
                  SalesData('May 2020', 5934936),
                  SalesData('July 2020', 12552765),
                  SalesData('November 2020', 53700000),
                  SalesData('March 2021', 116736437),
                  SalesData('Today', value.toDouble())
                ],
                xValueMapper: (SalesData sales, _) => sales.year,
                yValueMapper: (SalesData sales, _) => sales.sales,
                dataLabelSettings: DataLabelSettings(isVisible: true) // Enables the data label.
              )
            ],
    );
  }
}

class ChartData {
    ChartData(this.x, this.y, [this.color]);
    final String x;
    final double y;
    final Color color;
}

class PieChart extends StatelessWidget {
    const PieChart ({Key key, this.value}) : super(key: key);
    final int value;

  Widget build(BuildContext context) { final List<ChartData> chartData = [
            ChartData('David', value.toDouble()*0.8),
            ChartData('Steve', value.toDouble()*1.8),
            ChartData('Jack', value.toDouble()),
            ChartData('Others', value.toDouble()*1.2)
        ];
        return SfCircularChart(series: <CircularSeries>[
                        // Render pie chart
                        PieSeries<ChartData, String>(
                            dataSource: chartData,
                            pointColorMapper:(ChartData data,  _) => data.color,
                            xValueMapper: (ChartData data, _) => data.x,
                            yValueMapper: (ChartData data, _) => data.y
                        )
                    ]
                );
  }
}