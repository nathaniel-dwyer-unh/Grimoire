import 'package:flutter/material.dart';

class DisplayCardData extends StatefulWidget {
  final Map<String, dynamic> cardDataResponse;

  DisplayCardData({this.cardDataResponse}); // Class Constructor

  @override
  _DisplayCardDataState createState() => _DisplayCardDataState();
}

Widget getCardRulings(Map<String, dynamic> cardDataResponse) {
  List<Widget> listOfRulings = new List<Widget>();
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
  return new Column(children: listOfRulings);
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
          Padding(
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
                      widget.cardDataResponse['colorIdentity'].toString(),
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
          Padding(
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
                      widget.cardDataResponse['types'].toString(),
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
                      widget.cardDataResponse['supertypes'].toString(),
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
                      widget.cardDataResponse['subtypes'].toString(),
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
