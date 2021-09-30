import 'package:android_window/android_window.dart';
import 'package:flutter/material.dart';

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
    // mainApi.openFloatingWindow(400, 600, 200, 200);
    return Scaffold(
      body: SafeArea(
        child: ListView(padding: const EdgeInsets.all(16), children: [
          ElevatedButton(
            onPressed: () async {
              snackBar(
                context: context,
                title: '${await mainApi.canDrawOverlays()}',
              );
            },
            child: const Text('Check can draw overlays'),
          ),
          ElevatedButton(
            onPressed: mainApi.requestOverlayDisplayPermission,
            child: const Text('Request overlay display permission'),
          ),
          ElevatedButton(
            onPressed: () => mainApi.openFloatingWindow(400, 600, 200, 200),
            child: const Text('Open floating window'),
          ),
          ElevatedButton(
            onPressed: mainApi.closeFloatingWindow,
            child: const Text('Close floating window'),
          ),
          ElevatedButton(
            onPressed: () =>
                mainApi.send('layout', {'width': 600, 'height': 400}),
            child: const Text('setLayout(600, 400)'),
          ),
          ElevatedButton(
            onPressed: () =>
                mainApi.send('layout', {'width': 400, 'height': 600}),
            child: const Text('setLayout(400, 600)'),
          ),
          ElevatedButton(
            onPressed: () => mainApi.send('position', {'x': 0, 'y': 0}),
            child: const Text('setPosition(0, 0)'),
          ),
          ElevatedButton(
            onPressed: () => mainApi.send('position', {'x': 200, 'y': 200}),
            child: const Text('setPosition(100, 100)'),
          ),
        ]),
      ),
    );
  }

  snackBar({required BuildContext context, required String title}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(title)));
  }
}
