package qiuxiang.android_window

import android.app.Activity
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.FlutterPlugin.FlutterPluginBinding
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.BinaryMessenger

class AndroidWindowPlugin : FlutterPlugin, ActivityAware {
  private lateinit var pluginBinding: FlutterPluginBinding

  companion object {
    var messenger: BinaryMessenger? = null
    var activityClass: Class<Activity>? = null
  }

  override fun onDetachedFromEngine(binding: FlutterPluginBinding) {}
  override fun onDetachedFromActivityForConfigChanges() {}
  override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {}
  override fun onDetachedFromActivity() {}

  override fun onAttachedToEngine(binding: FlutterPluginBinding) {
    pluginBinding = binding
  }

  override fun onAttachedToActivity(binding: ActivityPluginBinding) {
    val mainApi = MainApi(binding.activity)
    Pigeon.MainApi.setUp(pluginBinding.binaryMessenger, mainApi)
    messenger = pluginBinding.binaryMessenger
    activityClass = binding.activity.javaClass
  }
}
