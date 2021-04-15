import 'package:corona_stats_app/app/repositories/data.dart';
import 'package:corona_stats_app/app/repositories/endpoints_data.dart';
import 'package:corona_stats_app/app/services/api.dart';
import 'package:corona_stats_app/app/services/endpoint_data.dart';
import 'package:corona_stats_app/app/ui/colors.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

 Map customColor = getCustomColors();
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
                dataLabelSettings: DataLabelSettings(isVisible: true),
                color: customColor['Salmon'] // Enables the data label.
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
                              CasesSuspRecov('Recovered', valueR.toDouble(), customColor['Blue']),
                              CasesSuspRecov('Deaths', valueD.toDouble(),  customColor['Dark Salmon']),
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
          plotAreaBorderWidth: 0,
            primaryXAxis: CategoryAxis(
                        majorGridLines: MajorGridLines(width: 0),
                        axisLine: AxisLine(width: 0),
                        minimum: -2,
                        maximum: 5,
                        isVisible: false,
                      ),
                      primaryYAxis: NumericAxis(
                        majorGridLines: MajorGridLines(width: 0),
                        axisLine: AxisLine(width: 0),
                        minimum: -40000000,
                        maximum: 300000000,
                        isVisible: false
                      ),
                      title: ChartTitle(text: 'Size comparison'), //Chart title.
                        series:  <ChartSeries<CasesCathegorized, String>>[
                            // Renders bubble chart
                            BubbleSeries<CasesCathegorized, String>(
                                dataSource: [
                                  CasesCathegorized('Cases', endpoints[valueList[0]].value.toDouble(), endpoints[valueList[0]].value.toDouble(), customColor['Light Salmon']),
                                  CasesCathegorized('Suspected Cases',  endpoints[valueList[1]].value.toDouble(), endpoints[valueList[1]].value.toDouble(),  customColor['Dark Blue']),
                                  CasesCathegorized('Confirmed Cases', endpoints[valueList[2]].value.toDouble(), endpoints[valueList[2]].value.toDouble(),  customColor['Salmon']),
                                  CasesCathegorized('Deaths',  endpoints[valueList[3]].value.toDouble(), endpoints[valueList[3]].value.toDouble(),  customColor['Dark Salmon']),
                                  CasesCathegorized('Recovered',  endpoints[valueList[4]].value.toDouble(), endpoints[valueList[4]].value.toDouble(), customColor['Blue'])
                                ],
                                sizeValueMapper: (CasesCathegorized sales, _) => sales.size,
                                pointColorMapper:(CasesCathegorized sales, _) => sales.pointColor,
                                minimumRadius:9, // Minimum radius of bubble
                                maximumRadius: 30, // Maximum radius of bubble
                                xValueMapper: (CasesCathegorized sales, _) => sales.x,
                                yValueMapper: (CasesCathegorized sales, _) => sales.y,
                                dataLabelMapper:(CasesCathegorized data, _) => data.x,
                                dataLabelSettings: DataLabelSettings( isVisible: true, 
                                  useSeriesColor: true,
                                  offset: Offset(0, 20),
                                  /*color: customColor['White'],*/
                                  textStyle: TextStyle(fontWeight: FontWeight.w500),
                                  labelAlignment: ChartDataLabelAlignment.top
                                  //
                                )

                                  //color: customColor['Light Salmon']),
                            )
                        ]
                    );
  }
}
