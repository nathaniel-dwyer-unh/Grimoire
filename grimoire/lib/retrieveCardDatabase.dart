import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

/* 
References:
  - Fetching data via http: https://flutter.dev/docs/cookbook/networking/fetch-data 
*/

Future<Cards> fetchCards() async {
  final response =
      await http.get(Uri.https('mtgjson.com', 'api/v5/AtomicCards.json'));

  if (response.statusCode == 200) {
    // 200 is a successful status code
    // if the server did return a 200 OK response
    // then parse the JSON
    return Cards.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response
    // then throw an exception
    throw Exception('Failed to load card database');
  }
}

class Cards {
  final String cardName;
  final String layout;
  final double convertedManaCost;
  final List<dynamic> colorIdentity;
  final String type;
  final List<dynamic> types;
  final List<dynamic> supertypes;
  final List<dynamic> subtypes;
  final String rulesText;
  final List<dynamic> rulings;

  Cards(
      {this.cardName,
      this.layout,
      this.convertedManaCost,
      this.colorIdentity,
      this.type,
      this.types,
      this.supertypes,
      this.subtypes,
      this.rulesText,
      this.rulings});

  factory Cards.fromJson(Map<String, dynamic> json) {
    // this creates a json object that we can fill with card info
    return Cards(
      cardName: json['data']['Deadeye Navigator'][0]['name'],
      layout: json['data']['Deadeye Navigator'][0]['layout'],
      convertedManaCost: json['data']['Deadeye Navigator'][0]
          ['convertedManaCost'],
      colorIdentity: json['data']['Deadeye Navigator'][0]['colorIdentity'],
      type: json['data']['Deadeye Navigator'][0]['type'],
      types: json['data']['Deadeye Navigator'][0]['types'],
      supertypes: json['data']['Deadeye Navigator'][0]['supertypes'],
      subtypes: json['data']['Deadeye Navigator'][0]['subtypes'],
      rulesText: json['data']['Deadeye Navigator'][0]['text'],
      rulings: json['data']['Deadeye Navigator'][0]['rulings'],
    );
  }
}

class RetrieveCardDatabase extends StatefulWidget {
  @override
  _RetrieveCardDatabaseState createState() => _RetrieveCardDatabaseState();
}

class _RetrieveCardDatabaseState extends State<RetrieveCardDatabase> {
  Future<Cards> futureCards;

  @override
  void initState() {
    super.initState();
    futureCards = fetchCards();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      OutlineButton(
        onPressed: null,
        child: Text('Retrieve/Load MTGJSON!'),
        splashColor: Colors.purple,
      ),
      FutureBuilder<Cards>(
        // should refactor this into a seperate dart file
        future: futureCards,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Text(
                snapshot.data.rulesText); // displays the chosen card attribute
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          // By default, show a loading spinner.
          return CircularProgressIndicator();
        },
      )
    ]);
  }
}
