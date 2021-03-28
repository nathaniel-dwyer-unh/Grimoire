import 'package:flutter/material.dart';

class DisplayCardData extends StatefulWidget {
  final Map<String, dynamic> cardDataResponse;

  DisplayCardData({this.cardDataResponse}); // Class Constructor

  @override
  _DisplayCardDataState createState() => _DisplayCardDataState();
}

Widget getCardAttribute(
    Map<String, dynamic> cardDataResponse, String cardAttribute) {
  var stringBuffer = StringBuffer();
  if (cardDataResponse[cardAttribute] == '' ||
      cardDataResponse[cardAttribute] == null) {
    return new Padding(
      padding: EdgeInsets.all(3),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.all(3),
            child: Text(
              cardAttribute[0].toUpperCase() +
                  cardAttribute.substring(1) +
                  ': ',
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 20,
                color: Colors.black.withOpacity(0.6),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(3),
              child: Text(
                'None',
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 20,
                  color: Colors.black.withOpacity(0.6),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  } else if (cardDataResponse[cardAttribute] is List) {
    for (var label in cardDataResponse[cardAttribute]) {
      stringBuffer.write(label + ', ');
    }
    return new Padding(
      padding: EdgeInsets.all(3),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.all(3),
            child: Text(
              cardAttribute[0].toUpperCase() +
                  cardAttribute.substring(1) +
                  ': ',
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 20,
                color: Colors.black.withOpacity(0.6),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(3),
              child: Text(
                stringBuffer.toString(),
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 20,
                  color: Colors.black.withOpacity(0.6),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  } else {
    return new Padding(
      padding: EdgeInsets.all(3),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.all(3),
            child: Text(
              cardAttribute[0].toUpperCase() +
                  cardAttribute.substring(1) +
                  ': ',
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 20,
                color: Colors.black.withOpacity(0.6),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(3),
              child: Text(
                cardDataResponse[cardAttribute].toString(),
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 20,
                  color: Colors.black.withOpacity(0.6),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget getCardRulings(Map<String, dynamic> cardDataResponse) {
  List<Widget> listOfRulings = [];
  if (cardDataResponse['rulings'] == null) {
    return new Padding(
      padding: EdgeInsets.all(5),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(3),
              child: Text(
                'N/A',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 20,
                  color: Colors.black.withOpacity(0.6),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  } else {
    for (var rule in cardDataResponse['rulings']) {
      listOfRulings.add(
        new Padding(
          padding: EdgeInsets.all(5),
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.all(3),
                child: Text(
                  rule['date'],
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 13,
                    color: Colors.black.withOpacity(0.6),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: Text(
                    rule['text'],
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 13,
                      color: Colors.black.withOpacity(0.6),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
  }
  return new Column(children: listOfRulings);
}

class _DisplayCardDataState extends State<DisplayCardData> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          getCardAttribute(widget.cardDataResponse, 'name'),
          getCardAttribute(widget.cardDataResponse, 'layout'),
          getCardAttribute(widget.cardDataResponse, 'convertedManaCost'),
          getCardAttribute(widget.cardDataResponse, 'colorIdentity'),
          getCardAttribute(widget.cardDataResponse, 'type'),
          getCardAttribute(widget.cardDataResponse, 'types'),
          getCardAttribute(widget.cardDataResponse, 'supertypes'),
          getCardAttribute(widget.cardDataResponse, 'subtypes'),
          getCardAttribute(widget.cardDataResponse, 'text'),
          Padding(
            padding: EdgeInsets.only(top: 20),
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(3),
                    child: Text(
                      'Rulings',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        decoration: TextDecoration.underline,
                        decorationThickness: 1.5,
                        fontSize: 30,
                        color: Colors.black.withOpacity(0.6),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          getCardRulings(widget.cardDataResponse),
        ],
      ),
    );
  }
}
