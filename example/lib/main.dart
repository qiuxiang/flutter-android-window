import 'package:flutter/material.dart';

import 'app.dart';
import 'android_window.dart';

void main() {
  runApp(const App());
}

@pragma('vm:entry-point')
void androidWindow() {
  runApp(const AndroidWindowApp());
}
