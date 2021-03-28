import 'package:flutter/material.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

/*
References:
  - Computer Vision with ML Kit - https://www.youtube.com/watch?v=ymyYUCrJnxU
*/

class SearchCardByImage extends StatefulWidget {
  @override
  _SearchCardByImageState createState() => _SearchCardByImageState();
}

class _SearchCardByImageState extends State<SearchCardByImage> {
  final picker = ImagePicker();

  // Select an image we want to use
  Future<File> getImage() async {
    final pickedFile = await picker.getImage(
        source: ImageSource.camera /* might need a CameraController here */);
    if (pickedFile != null) {
      return File(pickedFile.path);
    } else {
      print('No image selected.');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Expanded(
        child: Padding(
          padding: EdgeInsets.all(3),
          child: OutlinedButton(
            onPressed: () {
              getImage();
            },
            child: Text('Search by Image'),
          ),
        ),
      ),
      // child: FutureBuilder<File>(
      //   future: getImage(),
      //   builder: (context, snapshot) {
      //     if (snapshot.hasError) {
      //       return Text("${snapshot.error}");
      //     } else if (snapshot.hasData) {
      //       return Text(snapshot.data.toString());
      //     } else {
      //       // By default, show a loading spinner.
      //       return CircularProgressIndicator();
      //     }
      //   },
      // ),
    );
  }
}
