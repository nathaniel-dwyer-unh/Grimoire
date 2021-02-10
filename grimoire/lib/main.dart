import 'package:flutter/material.dart';
import 'package:grimoire/searchMtgjson.dart';
import './searchMtgjson.dart';
import './retrieveMtgjson.dart';

void main() {
  runApp(GrimoireApp());
}

class GrimoireApp extends StatefulWidget {
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
            children: [SearchMtgjson(), RetrieveMtgjson()],
          )),
      theme: ThemeData(primaryColor: Colors.purple),
    );
  }
}
