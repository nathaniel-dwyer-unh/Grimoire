import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import './displayCardData.dart';
import './searchCardByImage.dart';

// Code Inspiration taken from https://flutter.dev/docs/cookbook/forms/retrieve-input

class SearchCardDatabase extends StatefulWidget {
  @override
  _SearchCardDatabaseState createState() => _SearchCardDatabaseState();
}

class _SearchCardDatabaseState extends State<SearchCardDatabase> {
  /* TextEditingController() allows us to obtain the string value entered into the textField, 
  allowing us to use that string as a query on our FirebaseDB */
  final cardNameSearchController = TextEditingController();
  final databaseReference = FirebaseDatabase.instance.reference();
  String cardSearch;

  @override
  void dispose() {
    // clean up the cardNameSearchController when the widget is disposed
    cardNameSearchController.dispose();
    super.dispose();
  }

  /* retrieveCardData() is the logic that allows the user to enter a string value into our textField
  and submit that string value as a query on our FirebaseDB (basically, it allows the user to 
  search for cardData from FirebaseDB using a textField) */
  Future<Map<String, dynamic>> retrieveCardData(String searchQuery) async {
    String cleanedSearchQuery;
    Map<String, dynamic> cardDataResponse = {};
    /* in order to keep consistent with the keys generated from our fetchCard() method,
    if that card name contains any special characters ('[', ']', '/', '\', '#', '$', and '.',
    the kind that FirebaseDB doesn't play nice with) */
    if (searchQuery.contains(new RegExp(r'([\/.#$\[\]])'))) {
      // then we clean-up the card name by replacing all instances of those special characters with the dash character '-'
      cleanedSearchQuery =
          searchQuery.replaceAll(RegExp(r'([\/.#$\[\]])'), '-');
    } else {
      // if that card name does not contain any special characters, leave it be
      cleanedSearchQuery = searchQuery;
    }
    // query FirebaseDB using the user's searchQuery string
    final response = await databaseReference
        .child('CardDatabase')
        .child('data')
        .child(cleanedSearchQuery)
        .once();
    // to make sure our Map object is typed correctly, we are going to re-construct a new map using our response
    for (var key in response.value.keys) {
      cardDataResponse[key.toString()] = response.value[key];
    }
    // return the info of the card the user searched
    return cardDataResponse;
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
        Padding(
          padding: EdgeInsets.all(3),
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(3),
                  child: OutlinedButton(
                    onPressed: () {
                      /* we use setState() so that when this button is pressed,
            the app takes the current value in the textField and saves it
            under the variable 'cardSearch', then rebuilds the app,
            triggering our retrieveCardData() method and passing the new cardSearch value to it. */
                      setState(() {
                        cardSearch = cardNameSearchController.text;
                      });
                    },
                    child: Text('Search for Card'),
                  ),
                ),
              ),
              SearchCardByImage(),
            ],
          ),
        ),
        ConstrainedBox(
          constraints: BoxConstraints(maxHeight: double.infinity),
          child: FutureBuilder<Map<String, dynamic>>(
            future: retrieveCardData(cardSearch),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text("${snapshot.error}");
              } else if (snapshot.hasData) {
                return DisplayCardData(
                  cardDataResponse: snapshot.data,
                ); // used to be just Text(snapshot.data.toString())
              } else {
                // By default, show a loading spinner.
                return CircularProgressIndicator();
              }
            },
          ),
        )
      ],
    );
  }
}
