import 'package:flutter/material.dart';

import 'pigeon.g.dart';

export 'pigeon.g.dart' show AndroidWindowHandler;

final _api = AndroidWindowApi();

/// Android window widget.
class AndroidWindow extends StatefulWidget {
  final Widget child;
  const AndroidWindow({required this.child, Key? key}) : super(key: key);

  @override
  State<AndroidWindow> createState() => _AndroidWindowState();

  /// Resize android window.
  static void resize(int width, int height) {
    _api.resize(width, height);
  }

  /// Set position of window.
  static void setPosition(int x, int y) {
    _api.setPosition(x, y);
  }

  /// Send message to window.
  static Future<Object?> post(String name, [Object? data]) async {
    final response = await _api.post({'name': name, 'data': data});
    if (response.isNotEmpty) return response['data'];
  }

  /// Close android window.
  static void close() {
    _api.close();
  }

  /// Set message handler.
  ///
  /// Receive message from main app.
  static void setHandler(
    Future<Object?> Function(String name, Object? data) handler,
  ) {
    AndroidWindowHandler.setup(_Handler(handler));
  }
}

class _AndroidWindowState extends State<AndroidWindow> {
  bool start = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanStart: (event) => start = true,
      onPanUpdate: (event) {
        if (start) {
          _api.dragStart();
          start = false;
        }
      },
      onPanEnd: (event) => _api.dragEnd(),
      child: widget.child,
    );
  }
}

class _Handler extends AndroidWindowHandler {
  final Future<Object?> Function(String name, Object? data) _handler;

  _Handler(this._handler);

  @override
  Future<Map> handler(Map message) async {
    final name = message['name'];
    final data = message['data'];
    switch (message['name']) {
      case 'resize':
        AndroidWindow.resize(data['width'], data['height']);
        return {};
      case 'setPosition':
        AndroidWindow.setPosition(data['x'], data['y']);
        return {};
      default:
        return {'data': await _handler(name, data)};
    }
  }
}
