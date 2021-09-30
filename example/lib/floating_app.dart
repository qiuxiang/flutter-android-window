import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:android_window/android_window.dart';

class FloatingApp extends StatelessWidget {
  const FloatingApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FloatingHandler.setup(_FloatingHandler());
    return const MaterialApp(
      title: 'Flutter Demo',
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class _FloatingHandler extends FloatingHandler {
  @override
  void handler(String name, Map data) {
    switch (name) {
      case 'layout':
        floatingApi.setLayout(data['width'], data['height']);
        break;
      case 'position':
        floatingApi.setPosition(data['x'], data['y']);
        break;
    }
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Size size = const Size(0, 0);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanStart: (event) => floatingApi.dragStart(),
      onPanEnd: (event) => floatingApi.dragEnd(),
      child: ClipRRect(
        clipBehavior: Clip.hardEdge,
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        child: Scaffold(
          backgroundColor: Colors.grey.withOpacity(0.8),
          body: Stack(children: [
            ListView(children: [
              Container(height: 100, color: Colors.lightGreen),
              Container(height: 100, color: Colors.blueGrey),
              Container(height: 100, color: Colors.lightGreen),
              Container(height: 100, color: Colors.blueGrey),
            ]),
            Positioned(
              right: 0,
              child: Material(
                color: Colors.transparent,
                borderRadius: const BorderRadius.all(Radius.circular(24)),
                clipBehavior: Clip.hardEdge,
                child: IconButton(
                  onPressed: floatingApi.close,
                  icon: const Icon(Icons.close, color: Colors.white),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
