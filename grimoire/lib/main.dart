import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:grimoire/searchCardDatabase.dart';
import './searchCardDatabase.dart';
import './retrieveCardDatabase.dart';

/*
  Firebase Setup Resources:
      Initial Setup: https://firebase.google.com/docs/flutter/setup
      CRUD Operation Implementation: https://medium.com/flutterdevs/explore-realtime-database-in-flutter-c5870c2b231f
      Firebase Database Documentation: https://pub.dev/documentation/firebase_database/latest/firebase_database/firebase_database-library.html
*/

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

  void readFirebaseData() {
    databaseReference.once().then((DataSnapshot snapshot) {
      print('Data : ${snapshot.value}'); // prints to console
    });
  }

  void updateFirebaseData() {
    databaseReference
        .child('UserName')
        .child('sub')
        .update({'description': 'User'});
  }

  void deleteFirebaseData() {
    databaseReference.child('CardDatabase').remove();
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
              OutlineButton(
                onPressed: () => readFirebaseData(),
                child: Text('Read From FirebaseDB!'),
                splashColor: Colors.purple,
              ),
              OutlineButton(
                onPressed: () => updateFirebaseData(),
                child: Text('Update FirebaseDB!'),
                splashColor: Colors.purple,
              ),
              OutlineButton(
                onPressed: () => deleteFirebaseData(),
                child: Text('Delete Data From FirebaseDB!'),
                splashColor: Colors.purple,
              ),
            ],
          )),
      theme: ThemeData(primaryColor: Colors.purple),
    );
  }
}
