import 'package:pigeon/pigeon.dart';

@ConfigurePigeon(
  PigeonOptions(
    dartOut: 'lib/pigeon.g.dart',
    javaOut: 'android/src/main/java/qiuxiang/android_window/Pigeon.java',
    javaOptions: JavaOptions(package: 'qiuxiang.android_window'),
  ),
)
@HostApi()
abstract class MainApi {
  @async
  bool canDrawOverlays();
  @async
  void requestPermission();
  @async
  Map post(Map message);
  void open(String entry, int width, int height, int x, int y, bool focusable);
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
  void launchApp();
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
