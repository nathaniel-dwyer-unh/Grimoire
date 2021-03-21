import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:grimoire/searchCardDatabase.dart';
import './searchCardDatabase.dart';
// import './retrieveCardDatabase.dart';

/*
  Firebase Setup Resources:
      Initial Setup: https://firebase.google.com/docs/flutter/setup
      CRUD Operation Implementation: https://medium.com/flutterdevs/explore-realtime-database-in-flutter-c5870c2b231f
      Firebase Database Documentation: https://pub.dev/documentation/firebase_database/latest/firebase_database/firebase_database-library.html
*/

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase
      .initializeApp(); // start the app by initializing our connection to the FirebaseDB
  runApp(GrimoireApp());
}

class GrimoireApp extends StatefulWidget {
  GrimoireApp({Key key}) : super(key: key);

  @override
  _GrimoireAppState createState() => _GrimoireAppState();
}

class _GrimoireAppState extends State<GrimoireApp> {
  final DatabaseReference databaseReference =
      FirebaseDatabase.instance.reference();

  // does deleteFirebaseData() need to be in a FutureBuilder?
  // this might be able to be placed outside the Stateful class to avoid extra caching
  void deleteCardDatabase() {
    databaseReference
        .child('CardDatabase')
        .remove(); // deletes the data under the 'cardDatabase' key in FirebaseDB
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        // AppBar is the banner displayed across the top of the phone screen
        appBar: AppBar(
          title: Text('Grimoire App'),
          centerTitle: true,
        ),
        body: Container(
          child: SingleChildScrollView(
            child:
                SearchCardDatabase(), // inculdes textField, 'Search FirebaseDB!' button, and database searchQuery logic
            //RetrieveCardDatabase(), // includes 'Load Card Data to FirebaseDB1' button and fetchCards() logic for loading data from MTGJSON to FirebaseDB
            // OutlineButton(
            //   onPressed: () => deleteCardDatabase(),
            //   /* takes a few minutes to actually take effect,
            //   though actually full-rebooting the debugger seems to allow it to trigger MUCH faster... */
            //   child: Text('Delete Data From FirebaseDB!'),
            //   splashColor: Colors.red,
            // ),
          ),
        ),
      ),
      theme: ThemeData(primaryColor: Colors.purple),
    );
  }
}
