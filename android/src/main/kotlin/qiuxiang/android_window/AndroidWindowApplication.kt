package qiuxiang.android_window

import io.flutter.app.FlutterApplication
import io.flutter.plugin.common.BinaryMessenger

open class AndroidWindowApplication : FlutterApplication() {
  var mainBinaryMessenger: BinaryMessenger? = null
  var androidWindowBinaryMessenger: BinaryMessenger? = null
  var mainApi: MainApi? = null
}

