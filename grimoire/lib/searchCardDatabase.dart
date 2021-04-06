import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import './displayCardData.dart';
// import './searchCardByImage.dart';

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
  final picker = ImagePicker();

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

  // Select an image we want to use
  Future<File> getImage() async {
    final imageFile = await picker.getImage(
        // ImageSource.camera for phone camera and ImageSource.gallery for photo gallery
        source: ImageSource.camera);
    if (imageFile != null) {
      print('Image Path: ' + imageFile.path.toString());
      return File(imageFile.path);
    } else {
      print('No image selected.');
      return null;
    }
  }

  Future<String> retrieveTextFromImage(File imageFile) async {
    // first, store the imageFile in a format that FirebaseML can use for text recognition
    final visionImage = FirebaseVisionImage.fromFile(imageFile);
    // initialize a textRecognizer
    final textRecognizer = FirebaseVision.instance.textRecognizer();
    // now we have FirebaseVision detect the text in our image
    final VisionText visionText =
        await textRecognizer.processImage(visionImage);

    String alltext = visionText.text;
    for (TextBlock block in visionText.blocks) {
      final Rect boundingBox = block.boundingBox;
      final List<Offset> cornerPoints = block.cornerPoints;
      final String text = block.text;
      final List<RecognizedLanguage> languages = block.recognizedLanguages;

      // print('Bounding Box: ' + boundingBox.toString());
      // print('Corner Points: ' + cornerPoints.toString());
      // print('Text: ' + text.toString());
      // print('Recognized Language: ' + languages.toString());

      for (TextLine line in block.lines) {
        // Same getters as TextBlock
        for (TextElement element in line.elements) {
          // Same getters as TextBlock
        }
      }
    }
    print('Look Here!: ' + alltext.substring(0, alltext.indexOf('\n')));
    return alltext.substring(0, alltext.indexOf('\n'));
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
              /* might want to merge the contents of searchCardByImage.dart into this dart file, 
              that we we can use the TextFieldController and the imagePicker/camera/photo gallery
              /w text recognition as two different ways in which we can set the value of cardSearch 
              using setState(() {}), allowing our FutureBuilder for retriveCardData(cardSearch) to 
              just render the results once. We might also be able to drop cameraSceen.dart completely
              for the time being */
              // SearchCardByImage(),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(3),
                  child: OutlinedButton(
                    onPressed: () async {
                      cardSearch = await getImage().then(retrieveTextFromImage);
                      setState(() {
                        cardSearch = cardSearch;
                      });
                      // FutureBuilder<File>(
                      //   future: getImage(),
                      //   builder: (context, snapshot) {
                      //     if (snapshot.hasError) {
                      //       print("${snapshot.error}");
                      //       return Text("${snapshot.error}");
                      //     } else if (snapshot.hasData) {
                      //       print('Executing Callback....');
                      //       print("${snapshot.data}");
                      //       retrieveTextFromImage(snapshot.data);
                      //       return Text(snapshot.data.toString());
                      //     } else {
                      //       // By default, show a loading spinner.
                      //       print('error?');
                      //       return CircularProgressIndicator();
                      //     }
                      //   },
                      // );
                    },
                    child: Text('Search by Image'),
                  ),
                ),
              ),
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
