import 'package:flutter/material.dart';
import 'package:grimoire/searchCardDatabase.dart';
import './searchCardDatabase.dart';
import './retrieveCardDatabase.dart';

void main() {
  runApp(GrimoireApp());
}

class GrimoireApp extends StatefulWidget {
  GrimoireApp({Key key}) : super(key: key);

  @override
  _GrimoireAppState createState() => _GrimoireAppState();
}

class _GrimoireAppState extends State<GrimoireApp> {
  Future<Cards> futureCards;

  @override
  void initState() {
    super.initState();
    futureCards = fetchCards();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Text('Grimoire App'),
            centerTitle: true,
          ),
          body: Column(
            children: [
              SearchCardDatabase(),
              RetrieveCardDatabase(),
              FutureBuilder<Cards>(
                // should refactor this into a seperate dart file
                future: futureCards,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Text(snapshot.data.title);
                  } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }

                  // By default, show a loading spinner.
                  return CircularProgressIndicator();
                },
              )
            ],
          )),
      theme: ThemeData(primaryColor: Colors.purple),
    );
  }
}
