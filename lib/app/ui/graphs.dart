import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class SalesData {
  SalesData(this.year, this.sales);
  final String year;
  final double sales;
}

  class GraphsCard extends StatelessWidget {
    const GraphsCard({Key key, this.value}) : super(key: key);
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