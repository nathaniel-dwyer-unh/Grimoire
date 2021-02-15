import 'package:flutter/material.dart';

// Code Inspiration taken from https://flutter.dev/docs/cookbook/forms/retrieve-input

class SearchCardDatabase extends StatefulWidget {
  @override
  _SearchCardDatabaseState createState() => _SearchCardDatabaseState();
}

class _SearchCardDatabaseState extends State<SearchCardDatabase> {
  final cardNameSearchController = TextEditingController();

  @override
  void dispose() {
    // clean up the cardNameSearchController when the widget is disposed
    cardNameSearchController.dispose();
    super.dispose();
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
            return showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  // Retrieve the text the user has entered by using the
                  // TextEditingController.
                  content: Text(cardNameSearchController.text),
                );
              },
            );
          },
          child: Text('Search MTGJSON!'),
          splashColor: Colors.purple,
        ),
      ],
    );
  }
}
