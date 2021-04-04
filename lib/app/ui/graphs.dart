import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'dart:async';
import 'dart:math';


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


class BubbleChart extends StatelessWidget {
    const BubbleChart ({Key key, this.value}) : super(key: key);
    final int value;

  Widget build(BuildContext context) { 
    final List<BubbleChartData> bubbleChartData = [
            BubbleChartData(2010, 65, 1.32, const Color.fromRGBO(255, 0, 255, 0.5)),
            BubbleChartData(2011, 38, 4.21, const Color.fromRGBO(0, 0, 255, 0.7)),
            BubbleChartData(2012, 34, 0.38, const Color.fromRGBO(0, 255, 255, 0.7)),
            BubbleChartData(2013, 52, 9.29, const Color.fromRGBO(255, 255, 25, 0.7)),
            BubbleChartData(2014, 40, 7.34, const Color.fromRGBO(255, 0, 255, 0.7))
        ];
        return  SfCartesianChart(
                        series: <ChartSeries>[
                            // Renders bubble chart
                            BubbleSeries<BubbleChartData, double>(
                                dataSource: bubbleChartData,
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
    class BubbleChartData {
        BubbleChartData(this.x, this.y, this.size, this.pointColor);
            final double x;
            final double y;
            final double size;
            final Color pointColor;
    }