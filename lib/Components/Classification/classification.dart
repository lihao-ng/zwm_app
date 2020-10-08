import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tflite/tflite.dart';
import 'package:zwm_app/Components/Widgets/AppBar.dart';
import 'package:zwm_app/Models/Classify.dart';
import 'package:zwm_app/Utils/keys.dart';
import 'package:zwm_app/constants.dart';
import 'package:zwm_app/screens.dart';
import 'package:zwm_app/utils.dart';

class Classification extends StatefulWidget {
  Classification({Key key}) : super(key: key);

  @override
  _ClassificationState createState() => _ClassificationState();
}

class _ClassificationState extends State<Classification> {
  List<Classify> _classifications = new List<Classify>();

  CameraController _controller;
  Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    _setDefault();
  }

  @override
  void dispose() {
    Tflite.close();
    super.dispose();
  }

  _setDefault() async {
    bool granted;

    granted = await _checkPermission();

    if (!granted) {
      Keys.navKey.currentState.pop();

      errorAlert(
        Keys.navKey.currentContext,
        title: "An error has occured!",
        body: 'Permission not granted',
      );

      return;
    }

    await _initializeCamera();
    await loadModel();
  }

  _checkPermission() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.camera,
      Permission.storage,
      Permission.microphone,
    ].request();

    if (statuses[Permission.camera] == PermissionStatus.granted &&
        statuses[Permission.storage] == PermissionStatus.granted &&
        statuses[Permission.microphone] == PermissionStatus.granted) {
      return true;
    }

    return false;
  }

  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();
    final firstCamera = cameras.first;

    setState(() {
      _controller = CameraController(firstCamera, ResolutionPreset.veryHigh);
      _initializeControllerFuture = _controller.initialize();
    });
  }

  loadModel() async {
    await Tflite.loadModel(
      model: "assets/classifications/model_updated_v14.tflite",
      labels: "assets/classifications/labels_updated_v14.txt",
    );
  }

  _takePicture() async {
    try {
      await _initializeControllerFuture;

      final path = join(
        (await getTemporaryDirectory()).path,
        '${DateTime.now()}.png',
      );

      await _controller.takePicture(path);
      await _classifyImage(File(path));
    } catch (e) {
      print(e);
    }
  }

  _pickImage() async {
    final _picker = ImagePicker();

    var image = await _picker.getImage(source: ImageSource.gallery);

    if (image == null) {
      return null;
    }

    File file = File(image.path);
    await _classifyImage(file);
  }

  _classifyImage(File image) async {
    var classifications = await Tflite.runModelOnImage(
      path: image.path,
      numResults: 4,
      threshold: 0.2,
      imageMean: 127.5,
      imageStd: 127.5,
    );

    setState(() {
      for (var classify in classifications) {
        _classifications.add(
          Classify(
            index: classify['index'],
            label: classify['label'],
            confidence: classify['confidence'],
          ),
        );
      }
    });
    print('result');

    for (var classify in classifications) {
      print(classify);
    }

    Keys.navKey.currentState.pushReplacementNamed(
      '/classification-result',
      arguments: ClassificationResult(
        classifications: _classifications,
        imagePath: image.path,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: appBar(),
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Stack(
              children: [
                CameraPreview(_controller),
                Positioned(
                  bottom: 0,
                  child: Container(
                    height: 80,
                    width: _size.width,
                    color: accentColor,
                    child: Stack(
                      children: [
                        Center(
                          child: RawMaterialButton(
                            onPressed: () => _takePicture(),
                            elevation: 5.0,
                            fillColor: primaryColor,
                            child: Icon(
                              Icons.camera,
                              size: 45.0,
                              color: accentColor,
                            ),
                            padding: EdgeInsets.all(paddingMid),
                            shape: CircleBorder(),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: spacingSmall),
                          alignment: Alignment.centerRight,
                          child: OutlineButton(
                            onPressed: () => _pickImage(),
                            borderSide: BorderSide(color: primaryColor),
                            child: Icon(
                              Entypo.images,
                              size: 27.0,
                              color: primaryColor,
                            ),
                            padding: EdgeInsets.all(10.0),
                            shape: CircleBorder(),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
