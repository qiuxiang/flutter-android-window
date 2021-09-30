import 'package:pigeon/pigeon.dart';

@HostApi()
abstract class MainApi {
  @async
  bool canDrawOverlays();
  @async
  void requestOverlayDisplayPermission();
  @async
  void send(String name, Map data);
  void openAndroidWindow(int width, int height, int x, int y);
  void closeAndroidWindow();
}

@HostApi()
abstract class AndroidWindowApi {
  void setLayout(int width, int height);
  void setPosition(int x, int y);
  void dragStart();
  void dragEnd();
  void close();
}

@FlutterApi()
abstract class AndroidWindowHandler {
  void handler(String name, Map data);
}

@FlutterApi()
abstract class MainHandler {
  void handler(String name, Map data);
}
