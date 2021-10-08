# android_window [![pub-badge]][pub]

A flutter plugin allows you to create native android floating window.

## Install

```
flutter pub add android_window
```

MainActivity.kt:

```kotlin
class MainActivity : qiuxiang.android_window.AndroidWindowActivity()
```

Create MainApplication.kt:

```kotlin
package your_package // same as MainActivity.kt

class MainApplication : qiuxiang.android_window.AndroidWindowApplication()
```

Add `android:name=".MainApplication"` to AndroidManifest.xml `<application>`:

```xml
<application
  android:name=".MainApplication"
  ...
>
```

## Example

main.dart:

```dart
import 'package:android_window/main.dart' as android_window;
import 'package:flutter/material.dart';

import 'android_window.dart';

@pragma('vm:entry-point')
void androidWindow() {
  runApp(const AndroidWindowApp());
}

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(title: 'Flutter Demo', home: HomePage());
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => android_window.open(size: const Size(300, 200)),
        child: const Icon(Icons.add),
      ),
    );
  }
}
```

android_window.dart:

```dart
import 'package:android_window/android_window.dart';
import 'package:flutter/material.dart';

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
        backgroundColor: Colors.lightGreen.withOpacity(0.9),
        body: const Padding(
          padding: EdgeInsets.all(8),
          child: Text('Hello android window'),
        ),
      ),
    );
  }
}
```

Screenshot:

<img  width=320 src=https://user-images.githubusercontent.com/1709072/136494923-fd9f10bb-aa1e-4365-bece-f595bc913ebf.png>

### More examples

- [Full example](https://github.com/qiuxiang/flutter-android-window/tree/main/example)
- [example.apk](https://github.com/qiuxiang/flutter-android-window/releases/download/latest/example.apk)

[](https://user-images.githubusercontent.com/1709072/136388895-4b576f60-f00e-4188-ae74-dd4a3da9beca.mp4)

[pub]: https://pub.dartlang.org/packages/android_window
[pub-badge]: https://img.shields.io/pub/v/android_window.svg
