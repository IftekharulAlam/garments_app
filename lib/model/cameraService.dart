// ignore_for_file: camel_case_types, unused_local_variable

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class myCamera {
  Future<void> initCamera() async {
    WidgetsFlutterBinding.ensureInitialized();

// Obtain a list of the available cameras on the device.
    final cameras = await availableCameras();

// Get a specific camera from the list of available cameras.
    late final firstCamera = cameras.first;
  }

}
