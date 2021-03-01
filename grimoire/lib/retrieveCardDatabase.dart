import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'dart:convert';

/* 
References:
  - Fetching data via http: https://flutter.dev/docs/cookbook/networking/fetch-data 
*/

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
      this.rulesText, // keep in mind that this is still technically an optional property...
      this.rulings});

  factory Cards.fromJson(Map<String, dynamic> json, String cardName) {
    // this creates a json object that we can fill with card info
    return Cards(
      cardName: json['data'][cardName][0]['name'],
      layout: json['data'][cardName][0]['layout'],
      convertedManaCost: json['data'][cardName][0]['convertedManaCost'],
      colorIdentity: json['data'][cardName][0]['colorIdentity'],
      type: json['data'][cardName][0]['type'],
      types: json['data'][cardName][0]['types'],
      supertypes: json['data'][cardName][0]['supertypes'],
      subtypes: json['data'][cardName][0]['subtypes'],
      rulesText: json['data'][cardName][0]['text'],
      rulings: json['data'][cardName][0]['rulings'],
    );
  }
}

class RetrieveCardDatabase extends StatefulWidget {
  @override
  _RetrieveCardDatabaseState createState() => _RetrieveCardDatabaseState();
}

class _RetrieveCardDatabaseState extends State<RetrieveCardDatabase> {
  Future<Cards> futureCards;
  final databaseReference = FirebaseDatabase.instance.reference();

  Future<Cards> fetchCards() async {
    final response =
        await http.get(Uri.https('mtgjson.com', 'api/v5/AtomicCards.json'));

    if (response.statusCode == 200) {
      // 200 is a successful status code
      // if the server did return a 200 OK response
      // we take the response and convert it into a Map object
      final cardDatabase = jsonDecode(response.body) as Map;
      // then we iterate through the map to import it into the FirebaseDB
      for (final name in cardDatabase['data'].keys) {
        final cardName = cardDatabase['data'][name][0]['name'];
        print(cardName);
        Map<String, dynamic> cardAttributes = {
          name: {
            'name': cardDatabase['data'][name][0]['name'],
            'layout': cardDatabase['data'][name][0]['layout'],
            'convertedManaCost': cardDatabase['data'][name][0]
                ['convertedManaCost'],
            'colorIdentity': cardDatabase['data'][name][0]['colorIdentity'],
            'type': cardDatabase['data'][name][0]['type'],
            'types': cardDatabase['data'][name][0]['types'],
            'supertypes': cardDatabase['data'][name][0]['supertypes'],
            'subtypes': cardDatabase['data'][name][0]['subtypes'],
            'rulings': cardDatabase['data'][name][0]['rulings']
          }
        };
        databaseReference
            .child('CardDatabase')
            .child('data')
            .update(cardAttributes);
      }
      return Cards.fromJson(
          jsonDecode(response.body), 'Derevi, Empyrial Tactician');
    } else {
      // If the server did not return a 200 OK response
      // then throw an exception
      throw Exception('Failed to load card database');
    }
  }

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
