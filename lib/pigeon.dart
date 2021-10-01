import 'package:pigeon/pigeon.dart';

@HostApi()
abstract class MainApi {
  @async
  bool canDrawOverlays();
  @async
  void requestPermission();
  @async
  Map post(Map message);
  void open(String entry, int width, int height, int x, int y);
  void close();
}

@HostApi()
abstract class AndroidWindowApi {
  @async
  Map post(Map message);
  void resize(int width, int height);
  void setPosition(int x, int y);
  void dragStart();
  void dragEnd();
  void close();
}

@FlutterApi()
abstract class AndroidWindowHandler {
  @async
  Map handler(Map message);
}

@FlutterApi()
abstract class MainHandler {
  @async
  Map handler(Map message);
}
