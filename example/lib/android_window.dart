import 'package:android_window/android_window.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class AndroidWindowApp extends StatelessWidget {
  const AndroidWindowApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
      home: HomePage(),
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
    });
    return AndroidWindow(
      child: ClipRRect(
        clipBehavior: Clip.hardEdge,
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        child: Scaffold(
          backgroundColor: Colors.grey.withOpacity(0.8),
          body: Stack(children: [
            ListView(children: [
              Ink(
                height: 400 / 3,
                color: Colors.lightGreen,
                child: InkWell(onTap: () async {
                  final response = await AndroidWindow.post(
                    'hello',
                    'hello main app',
                  );
                  showSnackBar(
                    context,
                    'response from main app: $response',
                  );
                }),
              ),
              Container(height: 400 / 3, color: Colors.blueGrey),
              Container(height: 400 / 3, color: Colors.lightGreen),
              Container(height: 400 / 3, color: Colors.blueGrey),
            ]),
            const Positioned(
              right: 0,
              child: Material(
                color: Colors.transparent,
                borderRadius: BorderRadius.all(Radius.circular(24)),
                clipBehavior: Clip.hardEdge,
                child: IconButton(
                  onPressed: AndroidWindow.close,
                  icon: Icon(Icons.close, color: Colors.white),
                ),
              ),
            ),
          ]),
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
