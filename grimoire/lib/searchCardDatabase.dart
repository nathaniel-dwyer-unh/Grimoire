import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

// Code Inspiration taken from https://flutter.dev/docs/cookbook/forms/retrieve-input

class SearchCardDatabase extends StatefulWidget {
  @override
  _SearchCardDatabaseState createState() => _SearchCardDatabaseState();
}

class _SearchCardDatabaseState extends State<SearchCardDatabase> {
  final cardNameSearchController = TextEditingController();
  final databaseReference = FirebaseDatabase.instance.reference();
  String cardSearch;

  @override
  void dispose() {
    // clean up the cardNameSearchController when the widget is disposed
    cardNameSearchController.dispose();
    super.dispose();
  }

  // retrieveCardData() might need to be an await / async / Future method, since it is obtaining data from the FirebaseDB
  // Widget retrieveCardData(String searchQuery) {
  //   Map<dynamic, dynamic> cardData;
  //   String cleanedSearchQuery;
  //   if (searchQuery.contains(new RegExp(r'([\/.#$\[\]])'))) {
  //     cleanedSearchQuery = searchQuery.replaceAll(RegExp(r'([\/.#$\[\]])'),
  //         '-'); // the replaceAll() method here is so that we can match the same key pattern as the one we used when updating the FirebaseDB
  //   } else {
  //     cleanedSearchQuery = searchQuery;
  //   }
  //   databaseReference
  //       .child('CardDatabase')
  //       .child('data')
  //       .child(cleanedSearchQuery)
  //       .once()
  //       .then((DataSnapshot snapshot) {
  //     cardData = snapshot.value;
  //     for (var key in cardData.keys) {
  //       // print(key.toString() + ': ' + cardData[key].toString()); // returns card data to debug console...
  //     }
  //   });
  //   print(cardData
  //       .toString()); // cardData is null????? Might need to change this retrieveCardData() function to an await of Future due to our use of .then()
  //   // could also consult this for direction: https://stackoverflow.com/questions/53916529/how-do-i-get-the-value-of-this-variable-outside-the-then-statement-in-fl
  //   return Text(cardData.toString());
  // }

  Future<String> retrieveCardData(String searchQuery) async {
    String cleanedSearchQuery;
    if (searchQuery.contains(new RegExp(r'([\/.#$\[\]])'))) {
      cleanedSearchQuery = searchQuery.replaceAll(RegExp(r'([\/.#$\[\]])'),
          '-'); // the replaceAll() method here is so that we can match the same key pattern as the one we used when updating the FirebaseDB
    } else {
      cleanedSearchQuery = searchQuery;
    }
    final response = await databaseReference
        .child('CardDatabase')
        .child('data')
        .child(cleanedSearchQuery)
        .once();
    // .then((DataSnapshot snapshot) {
    //       for (var key in snapshot.value.keys) {
    //         print(key.toString() +
    //             ': ' +
    //             snapshot.value[key]
    //                 .toString()); // returns card data to debug console...
    //       }
    //     });
    return response.value.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller:
              cardNameSearchController, // we can grab the contents of the TextField later using Text(cardNameSearchController.text)
          decoration:
              InputDecoration(hintText: 'Enter a MTG Card Name to Search'),
        ),
        OutlineButton(
          onPressed: () {
            setState(() {
              cardSearch = cardNameSearchController.text;
            });
          },
          child: Text('Search FirebaseDB!'),
          splashColor: Colors.purple,
        ),
        FutureBuilder<String>(
          future: retrieveCardData(cardSearch),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text('There was an error with retrieving card data');
            } else if (snapshot.hasData) {
              return Text(snapshot.data);
            } else {
              return CircularProgressIndicator();
            }
          },
        ),
      ],
    );
  }
}
