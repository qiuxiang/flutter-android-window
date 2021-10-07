# android_window [![pub-badge]][pub]

A flutter plugin allows you to create native android floating window.

[](https://user-images.githubusercontent.com/1709072/136388895-4b576f60-f00e-4188-ae74-dd4a3da9beca.mp4)

- [Full example](https://github.com/qiuxiang/flutter-android-window/tree/main/example)
- [example.apk](https://github.com/qiuxiang/flutter-android-window/releases/download/latest/example.apk)


## Usage

main.dart:

```dart
import 'package:android_window/main.dart' as window;
import 'android_window.dart';

@pragma('vm:entry-point')
void androidWindow() {
  runApp(const AndroidWindowApp());
}

// run in main app
window.open(
  entryPoint: 'androidWindow',
  size: const Size(600, 800),
  position: const Offset(200, 200),
);
```

android_window.dart:

```dart
class AndroidWindowApp extends StatelessWidget {
  const AndroidWindowApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AndroidWindow(
      child: Scaffold(
        backgroundColor: Colors.grey.withOpacity(0.8),
        body: const Center(child: Text('Hello android window')),
      ),
    );
  }
}
```

MainActivity.kt:

```kotlin
import qiuxiang.android_window.AndroidWindowActivity
class MainActivity : AndroidWindowActivity()
```

Create MainApplication.kt:

```kotlin
import qiuxiang.android_window.AndroidWindowApplication
class MainApplication : AndroidWindowApplication()
```

Add `android:name=".MainApplication"` to AndroidManifest.xml:

```xml
<application android:name=".MainApplication">
```

[pub]: https://pub.dartlang.org/packages/android_window
[pub-badge]: https://img.shields.io/pub/v/android_window.svg
