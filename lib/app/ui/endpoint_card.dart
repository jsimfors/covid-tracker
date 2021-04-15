import 'package:corona_stats_app/app/services/api.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'colors.dart';

class EndpointCardData {
  EndpointCardData(this.title, this.assetName, this.color);
  final String title;
  final String assetName;
  final Color color;

}

class EndpointCard extends StatelessWidget {
  const EndpointCard({Key key, this.endpoint, this.value}) : super(key: key);
  final Endpoint endpoint;
  final int value;



  static Map<Endpoint, EndpointCardData> _cardsData = {
    
    // Change from type String to type EndpointCardData, to include also icon and color in object.
    Endpoint.cases: EndpointCardData('Cases', 'assets/count.png', getCustomColors()['Light Salmon']),
    Endpoint.casesConfirmed: EndpointCardData('Confirmed Cases', 'assets/fever.png',  getCustomColors()['Salmon']),
    Endpoint.casesSuspected:  EndpointCardData('Suspected Cases', 'assets/suspect.png',  getCustomColors()['Dark Blue']),
    Endpoint.deaths:  EndpointCardData('Deaths', 'assets/death.png',  getCustomColors()['Dark Salmon']),
    Endpoint.recovered:  EndpointCardData('Recovered', 'assets/patient.png',  getCustomColors()['Blue']),
  };

  String get formattedValue{
    if (value == null) {
      return '';
    }
    // Uses intl to add separator for large numbers
    return NumberFormat('#,###,###,###').format(value);
  }

  @override
  Widget build(BuildContext context) {
    final cardData = _cardsData[endpoint];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[                                
              // First row in child will contain just the text, ex "Cases"
              Text(
                cardData.title,
                style: Theme.of(context)
                .textTheme
                .headline6
                .copyWith(color: cardData.color),
              ),
              SizedBox(height: 4), // to add space between rows
              SizedBox( // Added to make sure same height for all widgets
                height: 52,
                child: Row(
                  // Second row in child, icon from cardData.assetName and endpoint value to the right.
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  // To center vertically:
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(cardData.assetName, color: cardData.color),
                    Text(
                      formattedValue,
                      style: Theme.of(context)
                      .textTheme
                      .headline5
                      .copyWith(color: cardData.color, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )

      ),
    );
  }
}