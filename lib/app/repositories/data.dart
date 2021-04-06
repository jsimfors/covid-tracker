import 'package:corona_stats_app/app/ui/graphs.dart';
import 'package:flutter/material.dart';

class PreviousCovid {
  final String monthYear;
  final double casesMY;
  PreviousCovid (this.monthYear, this.casesMY);
}

class CasesSuspRecov {
    CasesSuspRecov(this.x, this.y, [this.color]);
    final String x;
    final double y;
    final Color color;
}

class CasesCathegorized {
    CasesCathegorized(this.x, this.y, this.size, this.pointColor);
        final double x;
        final double y;
        final double size;
        final Color pointColor;
}

List<PreviousCovid> previousCovidData(valueToday) {
  final previousCovidData  = [
              PreviousCovid('March 2020', 509164),
              PreviousCovid('May 2020', 5934936),
              PreviousCovid('July 2020', 12552765),
              PreviousCovid('November 2020', 53700000),
              PreviousCovid('March 2021', 116736437),
              PreviousCovid('Today', valueToday.toDouble())
              ];
  return previousCovidData;
}

// List<CasesSuspRecov> pieChartData(valueList) {
//   final pieChartData  = [
//             CasesSuspRecov('David', value.toDouble()*0.8),
//             CasesSuspRecov('Steve', value.toDouble()*1.8),
//             CasesSuspRecov('Jack', value.toDouble()),
//             CasesSuspRecov('Others', value.toDouble()*1.2)
//         ];
//   return pieChartData;
// }

List<CasesCathegorized> bubbleChartData(value) {
  final bubbleChartData = [
            CasesCathegorized(2010, 65, 1.32, const Color.fromRGBO(255, 0, 255, 0.5)),
            CasesCathegorized(2011, 38, 4.21, const Color.fromRGBO(0, 0, 255, 0.7)),
            CasesCathegorized(2012, 34, 0.38, const Color.fromRGBO(0, 255, 255, 0.7)),
            CasesCathegorized(2013, 52, 9.29, const Color.fromRGBO(255, 255, 25, 0.7)),
            CasesCathegorized(2014, 40, 7.34, const Color.fromRGBO(255, 0, 255, 0.7))
        ];
    return bubbleChartData;
}