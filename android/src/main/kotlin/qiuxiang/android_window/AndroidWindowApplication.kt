package qiuxiang.android_window

import io.flutter.app.FlutterApplication
import io.flutter.embedding.engine.FlutterEngine

open class AndroidWindowApplication : FlutterApplication() {
  var floatingEngine: FlutterEngine? = null
  var mainApi: MainApi? = null
}

