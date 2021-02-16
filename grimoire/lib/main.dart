import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:grimoire/searchCardDatabase.dart';
import './searchCardDatabase.dart';
import './retrieveCardDatabase.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(GrimoireApp());
}

class GrimoireApp extends StatefulWidget {
  GrimoireApp({Key key}) : super(key: key);

  @override
  _GrimoireAppState createState() => _GrimoireAppState();
}

class _GrimoireAppState extends State<GrimoireApp> {
  final databaseReference = FirebaseDatabase.instance.reference();

  void createFirebaseData() {
    databaseReference
        .child("UserName")
        .set({'name': 'Nathaniel Dwyer', 'description': 'Author'});
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
              OutlineButton(
                onPressed: () => createFirebaseData(),
                child: Text('Write to FirebaseDB!'),
                splashColor: Colors.purple,
              ),
            ],
          )),
      theme: ThemeData(primaryColor: Colors.purple),
    );
  }
}
