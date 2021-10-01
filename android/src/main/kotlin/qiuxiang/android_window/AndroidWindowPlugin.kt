package qiuxiang.android_window

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.FlutterPlugin.FlutterPluginBinding
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding

class AndroidWindowPlugin : FlutterPlugin, ActivityAware {
  private lateinit var pluginBinding: FlutterPluginBinding

  override fun onDetachedFromEngine(binding: FlutterPluginBinding) {}
  override fun onDetachedFromActivityForConfigChanges() {}
  override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {}
  override fun onDetachedFromActivity() {}

  override fun onAttachedToEngine(binding: FlutterPluginBinding) {
    pluginBinding = binding
  }

  override fun onAttachedToActivity(binding: ActivityPluginBinding) {
    val mainApi = MainApi(binding.activity)
    Pigeon.MainApi.setup(pluginBinding.binaryMessenger, mainApi)
    binding.activity.app?.let {
      it.mainApi = mainApi
      it.mainBinaryMessenger = pluginBinding.binaryMessenger
    }
  }
}
