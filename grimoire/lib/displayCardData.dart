import 'package:flutter/material.dart';

class DisplayCardData extends StatefulWidget {
  final Map<String, dynamic> cardDataResponse;

  DisplayCardData({this.cardDataResponse}); // Class Constructor

  @override
  _DisplayCardDataState createState() => _DisplayCardDataState();
}

Widget getCardRulings(Map<String, dynamic> cardDataResponse) {
  List<Widget> listOfRulings = new List<Widget>();
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

Widget getCardColorIdentity(Map<String, dynamic> cardDataResponse) {
  var cardColorIdentity = StringBuffer();
  if (cardDataResponse['colorIdentity'] == null) {
    return new Padding(
      padding: EdgeInsets.all(3),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.all(3),
            child: Text(
              'Color Identity: ',
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
                'Colorless',
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
    for (var color in cardDataResponse['colorIdentity']) {
      cardColorIdentity.write(color + ', ');
    }
    return new Padding(
      padding: EdgeInsets.all(3),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.all(3),
            child: Text(
              'Color Identity: ',
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
                cardColorIdentity.toString(),
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

Widget getCardTypes(Map<String, dynamic> cardDataResponse) {
  var cardTypes = StringBuffer();
  if (cardDataResponse['types'] == null) {
    return new Padding(
      padding: EdgeInsets.all(3),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.all(3),
            child: Text(
              'Types: ',
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
  } else {
    for (var type in cardDataResponse['types']) {
      cardTypes.write(type + ', ');
    }
    return new Padding(
      padding: EdgeInsets.all(3),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.all(3),
            child: Text(
              'Types: ',
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
                cardTypes.toString(),
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

Widget getCardSupertypes(Map<String, dynamic> cardDataResponse) {
  var cardSupertypes = StringBuffer();
  if (cardDataResponse['supertypes'] == null) {
    return new Padding(
      padding: EdgeInsets.all(3),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.all(3),
            child: Text(
              'Supertypes: ',
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
  } else {
    for (var supertype in cardDataResponse['supertypes']) {
      cardSupertypes.write(supertype + ', ');
    }
    return new Padding(
      padding: EdgeInsets.all(3),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.all(3),
            child: Text(
              'Supertypes: ',
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
                cardSupertypes.toString(),
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

Widget getCardSubtypes(Map<String, dynamic> cardDataResponse) {
  var cardSubtypes = StringBuffer();
  if (cardDataResponse['subtypes'] == null) {
    return new Padding(
      padding: EdgeInsets.all(3),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.all(3),
            child: Text(
              'Subtypes: ',
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
  } else {
    for (var subtype in cardDataResponse['subtypes']) {
      cardSubtypes.write(subtype + ', ');
    }
    return new Padding(
      padding: EdgeInsets.all(3),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.all(3),
            child: Text(
              'Subtypes: ',
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
                cardSubtypes.toString(),
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

Widget getCardText(Map<String, dynamic> cardDataResponse) {
  if (cardDataResponse['text'] == '') {
    return new Padding(
      padding: EdgeInsets.all(3),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.all(3),
            child: Text(
              'Text: ',
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
  } else {
    return new Padding(
      padding: EdgeInsets.only(top: 20),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.all(3),
            child: Text(
              'Text: ',
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
                cardDataResponse['text'].toString(),
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

class _DisplayCardDataState extends State<DisplayCardData> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(3),
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.all(3),
                  child: Text(
                    'Name: ',
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
                      widget.cardDataResponse['name'].toString(),
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
          ),
          Padding(
            padding: EdgeInsets.all(3),
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.all(3),
                  child: Text(
                    'Layout: ',
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
                      widget.cardDataResponse['layout'].toString(),
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
          ),
          Padding(
            padding: EdgeInsets.all(3),
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.all(3),
                  child: Text(
                    'Converted Mana Cost: ',
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
                      widget.cardDataResponse['convertedManaCost'].toString(),
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
          ),
          getCardColorIdentity(widget.cardDataResponse),
          Padding(
            padding: EdgeInsets.all(3),
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.all(3),
                  child: Text(
                    'Type: ',
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
                      widget.cardDataResponse['type'].toString(),
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
          ),
          getCardTypes(widget.cardDataResponse),
          getCardSupertypes(widget.cardDataResponse),
          getCardSubtypes(widget.cardDataResponse),
          getCardText(widget.cardDataResponse),
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
