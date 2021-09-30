import 'package:flutter/material.dart';

import 'app.dart';
import 'floating_app.dart';

void main() {
  runApp(const App());
}

@pragma('vm:entry-point')
void floating() {
  runApp(const FloatingApp());
}
