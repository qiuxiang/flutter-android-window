import 'package:android_window/android_window.dart';
import 'package:flutter/material.dart';

class AndroidWindowApp extends StatelessWidget {
  const AndroidWindowApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: const HomePage(),
      theme: ThemeData.dark(useMaterial3: true),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AndroidWindow.setHandler((name, data) async {
      switch (name) {
        case 'hello':
          showSnackBar(context, 'message from main app: $data');
          return 'hello main app';
      }
      return null;
    });
    return AndroidWindow(
      child: ClipRRect(
        clipBehavior: Clip.hardEdge,
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        child: Scaffold(
          backgroundColor:
              Theme.of(context).scaffoldBackgroundColor.withOpacity(0.8),
          body: ListView(
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.all(8),
            children: [
              const ElevatedButton(
                onPressed: AndroidWindow.close,
                child: Text('Close'),
              ),
              ElevatedButton(
                onPressed: () async {
                  final response = await AndroidWindow.post(
                    'hello',
                    'hello main app',
                  );
                  showSnackBar(
                    context,
                    'response from main app: $response',
                  );
                },
                child: const Text('Send message'),
              ),
              const ElevatedButton(
                onPressed: AndroidWindow.launchApp,
                child: Text('Launch app'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  showSnackBar(BuildContext context, String title) {
    final snackBar =
        SnackBar(content: Text(title), padding: const EdgeInsets.all(8));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
