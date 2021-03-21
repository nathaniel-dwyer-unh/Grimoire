import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_database/firebase_database.dart';
import 'dart:convert';

/* 
References:
  - Fetching data via http: https://flutter.dev/docs/cookbook/networking/fetch-data 
*/

// THIS CLASS IS CURRENTLY UNUSED!
/*
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
 */

class RetrieveCardDatabase extends StatefulWidget {
  @override
  _RetrieveCardDatabaseState createState() => _RetrieveCardDatabaseState();
}

class _RetrieveCardDatabaseState extends State<RetrieveCardDatabase> {
  final databaseReference = FirebaseDatabase.instance.reference();

  // fetchCards() is the logic that loads card data from the MTGJSON online API to our FirebaseDB Realtime Database backend
  Future<int> fetchCards() async {
    FirebaseDatabase.instance.goOnline(); // connect to the FirebaseDB
    final response = await http.get(Uri.https('mtgjson.com',
        'api/v5/AtomicCards.json')); // grabs the data from the MTGJSON online API
    if (response.statusCode == 200) {
      // 200 is a successful response status code
      // we take the MTGJSON response data and convert it into a Map object
      final cardDatabase = jsonDecode(response.body) as Map;
      // then we iterate through the map to import it into the FirebaseDB
      int i = 0;
      String cleanedCardName;
      // for each card in MTGJSON's AtomicCards.json
      for (String cardName in cardDatabase['data'].keys) {
        /* if that card name contains any special characters ('[', ']', '/', '\', '#', '$', and '.', in this case;
        the kind that FirebaseDB doesn't play nice with) */
        if (cardName.contains(new RegExp(r'([\/.#$\[\]])'))) {
          // then we clean-up the card name by replacing all instances of those special characters with the dash character '-'
          cleanedCardName = cardName.replaceAll(RegExp(r'([\/.#$\[\]])'), '-');
        } else {
          // if that card name does not contain any special characters, leave it be
          cleanedCardName = cardName;
        }
        // for debug purposes, we will print each of the card name keys we will use in the FirebaseDB
        print(i.toString() + ': ' + cleanedCardName);
        /* in preperation for updating our FirebaseDB with each card's data, 
        we create a new Map object for each card to store that card's attributes that we care about */
        Map<String, dynamic> cardAttributes = {
          cleanedCardName: {
            'name': cardDatabase['data'][cardName][0]['name'],
            'layout': cardDatabase['data'][cardName][0]['layout'],
            'convertedManaCost': cardDatabase['data'][cardName][0]
                ['convertedManaCost'],
            'colorIdentity': cardDatabase['data'][cardName][0]['colorIdentity'],
            'type': cardDatabase['data'][cardName][0]['type'],
            'types': cardDatabase['data'][cardName][0]['types'],
            'supertypes': cardDatabase['data'][cardName][0]['supertypes'],
            'subtypes': cardDatabase['data'][cardName][0]['subtypes'],
            'rulings': cardDatabase['data'][cardName][0]['rulings']
          }
        };
        /* now that we have all the data we care about for each card stored in a single Map object
        we can update our FirebaseDB with that Map object */
        databaseReference
            .child('CardDatabase')
            .child('data')
            .update(cardAttributes);
        /* since card rulestext isn't an attibute that all cards have, we will test if each card has rulestext
        if it does, we add it to the FirebaseDB
        if it doesn't, we add a placeholder value (an empty string in this case) */
        if (cardDatabase['data'][cardName][0].containsKey('text')) {
          databaseReference
              .child('CardDatabase')
              .child('data')
              .child(cleanedCardName)
              .update({'text': cardDatabase['data'][cardName][0]['text']});
        } else {
          databaseReference
              .child('CardDatabase')
              .child('data')
              .child(cleanedCardName)
              .update({'text': ''});
        }
        i++;
      }
      FirebaseDatabase.instance.goOffline(); // disconnect to the FirebaseDB
      return cardDatabase['data']
          .length; // return the number of cards in the AtomicCards.json file that we loaded
    } else {
      // If the server did not return a 200 OK response, then throw an exception
      throw Exception('Failed to load card database');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      OutlinedButton(
        onPressed: null,
        child: Text('Load Card Data to FirebaseDB!'),
      ),
      FutureBuilder<int>(
        future: fetchCards(), // takes a few minutes to actually take effect
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Text('FirebaseDB Successfully Updated ' +
                snapshot.data.toString() +
                ' Values!');
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
