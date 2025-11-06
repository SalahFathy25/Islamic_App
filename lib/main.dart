import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:islamic_app/app_services.dart';

import 'app.dart';

void main() async {
  appServices();
  // runApp(const IslamicApp());
  runApp(
    DevicePreview(enabled: false, builder: (context) => const IslamicApp()),
  );
}
