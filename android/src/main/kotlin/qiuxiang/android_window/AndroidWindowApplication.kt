package qiuxiang.android_window

import io.flutter.app.FlutterApplication
import io.flutter.plugin.common.BinaryMessenger

open class AndroidWindowApplication : FlutterApplication() {
  var mainMessenger: BinaryMessenger? = null
  var androidWindowMessenger: BinaryMessenger? = null
  var mainApi: MainApi? = null
}

