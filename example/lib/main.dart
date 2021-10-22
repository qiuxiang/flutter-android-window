import 'package:android_window/main.dart' as android_window;
import 'package:flutter/material.dart';

import 'android_window.dart';

@pragma('vm:entry-point')
void androidWindow() {
  runApp(const AndroidWindowApp());
}

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(title: 'Flutter Demo', home: HomePage());
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    android_window.setHandler((name, data) async {
      switch (name) {
        case 'hello':
          showSnackBar(context, 'message from android window: $data');
          return 'hello android window';
      }
    });
    return Scaffold(
      body: SafeArea(
        child: ListView(padding: const EdgeInsets.all(16), children: [
          ElevatedButton(
            onPressed: () async {
              showSnackBar(
                  context, '${await android_window.canDrawOverlays()}');
            },
            child: const Text('Check can draw overlays'),
          ),
          const ElevatedButton(
            onPressed: android_window.requestPermission,
            child: Text('Request overlay display permission'),
          ),
          ElevatedButton(
            onPressed: () => android_window.open(
              size: const Size(600, 600),
              position: const Offset(200, 200),
            ),
            child: const Text('Open android window'),
          ),
          const ElevatedButton(
            onPressed: android_window.close,
            child: Text('Close android window'),
          ),
          ElevatedButton(
            onPressed: () => android_window.resize(600, 400),
            child: const Text('resize(600, 400)'),
          ),
          ElevatedButton(
            onPressed: () => android_window.resize(400, 600),
            child: const Text('resize(400, 600)'),
          ),
          ElevatedButton(
            onPressed: () => android_window.setPosition(0, 0),
            child: const Text('setPosition(0, 0)'),
          ),
          ElevatedButton(
            onPressed: () => android_window.setPosition(300, 300),
            child: const Text('setPosition(300, 300)'),
          ),
          ElevatedButton(
            onPressed: () async {
              final response = await android_window.post(
                'hello',
                'hello android window',
              );
              showSnackBar(context, 'response from android window: $response');
            },
            child: const Text('Send message to android window'),
          ),
        ]),
      ),
    );
  }

  showSnackBar(BuildContext context, String title) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(title)));
  }
}
