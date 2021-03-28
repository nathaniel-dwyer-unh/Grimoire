import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

/* 
  Inspiration taken from https://blog.codemagic.io/text-recognition-using-firebase-ml-kit-flutter/
*/

class CameraScreen extends StatefulWidget {
  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  CameraController _controller;

  Future<CameraDescription> getBackCamera() async {
    List<CameraDescription> cameras = await availableCameras();
    return cameras[0];
  }

  Future<CameraDescription> getFrontCamera() async {
    List<CameraDescription> cameras = await availableCameras();
    return cameras[1];
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder<CameraDescription>(
        future: getBackCamera(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text("${snapshot.error}");
          } else if (snapshot.hasData) {
            _controller =
                CameraController(snapshot.data, ResolutionPreset.medium);
            _controller.initialize().then((_) {
              if (!mounted) {
                return;
              }
              setState(() {});
            });
          } else {
            // By default, show a loading spinner.
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
