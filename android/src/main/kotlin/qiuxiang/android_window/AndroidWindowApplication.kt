package qiuxiang.android_window

import android.app.Activity
import io.flutter.app.FlutterApplication
import io.flutter.plugin.common.BinaryMessenger

open class AndroidWindowApplication : FlutterApplication() {
  var mainMessenger: BinaryMessenger? = null
  var androidWindowMessenger: BinaryMessenger? = null
  var mainApi: MainApi? = null
  var activity: Activity? = null
  var running = false
}

