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
        final String x;
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
