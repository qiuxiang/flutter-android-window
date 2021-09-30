import 'package:pigeon/pigeon.dart';

@HostApi()
abstract class MainApi {
  void openFloatingWindow(int width, int height, int x, int y);

  void closeFloatingWindow();

  @async
  bool canDrawOverlays();

  @async
  void requestOverlayDisplayPermission();

  @async
  void send(String name, Map data);
}

@HostApi()
abstract class FloatingApi {
  void setLayout(int width, int height);

  void setPosition(int x, int y);

  void dragStart();

  void dragEnd();

  void close();
}

@FlutterApi()
abstract class FloatingHandler {
  void handler(String name, Map data);
}

@FlutterApi()
abstract class MainHandler {
  void handler(String name, Map data);
}
