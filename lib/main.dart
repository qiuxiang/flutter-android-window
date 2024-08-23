import 'dart:ui';

import 'pigeon.g.dart';

final _api = MainApi();

/// Open an android window that over top of other apps.
///
/// The [entryPoint] is the name of function that annotated with `@pragma('vm:entry-point')`.
///
/// For example:
///
/// ```dart
/// @pragma('vm:entry-point')
/// void androidWindow() {
///   runApp(const AndroidWindowApp());
/// }
/// ```
void open({
  String entryPoint = 'androidWindow',
  Size size = const Size(400, 600),
  Offset position = const Offset(0, 0),
  bool focusable = false,
}) {
  _api.open(
    entryPoint,
    size.width.toInt(),
    size.height.toInt(),
    position.dx.toInt(),
    position.dy.toInt(),
    focusable,
  );
}

/// Close android window.
void close() {
  _api.close();
}

/// Checks if this app can draw on top of other apps.
Future<bool> canDrawOverlays() {
  return _api.canDrawOverlays();
}

/// Checks if the window is running.
Future<bool> isRunning() {
  return _api.isRunning();
}

/// Request overlay permission.
///
/// Show screen for controlling which apps can draw on top of other apps.
Future<void> requestPermission() {
  return _api.requestPermission();
}

/// Send message to window.
Future<Object?> post(String name, [Object? data]) async {
  final response = await _api.post({'name': name, 'data': data});
  if (response.isEmpty) return null;
  return response['data'];
}

/// Resize window.
Future<void> resize(int width, int height) {
  return post('resize', {'width': width, 'height': height});
}

/// Set position of window.
Future<void> setPosition(int x, int y) {
  return post('setPosition', {'x': x, 'y': y});
}

/// Set message handler.
///
/// Receive message from android window.
void setHandler(Future<Object?> Function(String name, Object? data) handler) {
  MainHandler.setUp(_Handler(handler));
}

class _Handler extends MainHandler {
  final Future<Object?> Function(String name, Object? data) _handler;

  _Handler(this._handler);

  @override
  Future<Map> handler(Map message) async {
    return {'data': await _handler(message['name'], message['data'])};
  }
}
