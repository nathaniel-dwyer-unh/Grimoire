import 'package:flutter/material.dart';
import './navigation.dart';

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
        body: Navigation(),
      ),
      theme: ThemeData(primaryColor: Colors.purple),
    );
  }
}
