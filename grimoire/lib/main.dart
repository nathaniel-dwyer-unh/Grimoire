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
            ],
          )),
      theme: ThemeData(primaryColor: Colors.purple),
    );
  }
}
