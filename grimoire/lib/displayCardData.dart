import 'package:flutter/material.dart';

class DisplayCardData extends StatefulWidget {
  final Map<String, dynamic> cardDataResponse;

  DisplayCardData({this.cardDataResponse}); // Class Constructor

  @override
  _DisplayCardDataState createState() => _DisplayCardDataState();
}

class _DisplayCardDataState extends State<DisplayCardData> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              Text(
                'Name: ',
                style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 20,
                    color: Colors.black.withOpacity(0.6)),
              ),
              Expanded(
                child: Text(
                  widget.cardDataResponse['name'].toString(),
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 20,
                      color: Colors.black.withOpacity(0.6)),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                'Layout: ',
                style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 20,
                    color: Colors.black.withOpacity(0.6)),
              ),
              Expanded(
                child: Text(
                  widget.cardDataResponse['layout'].toString(),
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 20,
                      color: Colors.black.withOpacity(0.6)),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                'Converted Mana Cost: ',
                style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 20,
                    color: Colors.black.withOpacity(0.6)),
              ),
              Expanded(
                child: Text(
                  widget.cardDataResponse['convertedManaCost'].toString(),
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 20,
                      color: Colors.black.withOpacity(0.6)),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                'Color Identity: ',
                style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 20,
                    color: Colors.black.withOpacity(0.6)),
              ),
              Expanded(
                child: Text(
                  widget.cardDataResponse['colorIdentity'].toString(),
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 20,
                      color: Colors.black.withOpacity(0.6)),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                'Type: ',
                style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 20,
                    color: Colors.black.withOpacity(0.6)),
              ),
              Expanded(
                child: Text(
                  widget.cardDataResponse['type'].toString(),
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 20,
                      color: Colors.black.withOpacity(0.6)),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                'Types: ',
                style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 20,
                    color: Colors.black.withOpacity(0.6)),
              ),
              Expanded(
                child: Text(
                  widget.cardDataResponse['types'].toString(),
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 20,
                      color: Colors.black.withOpacity(0.6)),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                'Supertypes: ',
                style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 20,
                    color: Colors.black.withOpacity(0.6)),
              ),
              Expanded(
                child: Text(
                  widget.cardDataResponse['supertypes'].toString(),
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 20,
                      color: Colors.black.withOpacity(0.6)),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                'Subtypes: ',
                style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 20,
                    color: Colors.black.withOpacity(0.6)),
              ),
              Expanded(
                child: Text(
                  widget.cardDataResponse['subtypes'].toString(),
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 20,
                      color: Colors.black.withOpacity(0.6)),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                'Rulings: ',
                style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 20,
                    color: Colors.black.withOpacity(0.6)),
              ),
              Expanded(
                child: Text(
                  widget.cardDataResponse['rulings'].toString(),
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 20,
                      color: Colors.black.withOpacity(0.6)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
