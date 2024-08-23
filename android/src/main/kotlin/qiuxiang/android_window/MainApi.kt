package qiuxiang.android_window

import android.app.Activity
import android.content.Intent
import android.net.Uri
import android.os.Build
import android.provider.Settings
import io.flutter.embedding.engine.FlutterEngineCache

class MainApi(private val activity: Activity) : Pigeon.MainApi {
  private var onActivityResultCallback: (() -> Unit)? = null

  override fun open(entry: String, width: Long, height: Long, x: Long, y: Long, focusable: Boolean) {
    val intent = Intent(activity, WindowService::class.java)
    intent.putExtra("entry", entry)
    intent.putExtra("width", width.toInt())
    intent.putExtra("height", height.toInt())
    intent.putExtra("x", x.toInt())
    intent.putExtra("y", y.toInt())
    intent.putExtra("focusable", focusable)
    if (canDrawOverlays()) {
      activity.startService(intent)
    } else {
      requestPermission {
        if (canDrawOverlays()) {
          activity.startService(intent)
        }
      }
    }
  }

  override fun close() {
    activity.stopService(Intent(activity, WindowService::class.java))
  }

  override fun canDrawOverlays(result: Pigeon.Result<Boolean>) {
    result.success(canDrawOverlays())
  }

  override fun requestPermission(result: Pigeon.VoidResult) {
    requestPermission { result.success() }
  }

  override fun isRunning(result: Pigeon.Result<Boolean>) {
    result.success(FlutterEngineCache.getInstance().get(engineId) != null)
  }

  override fun post(message: MutableMap<Any, Any>, result: Pigeon.Result<MutableMap<Any, Any>>) {
    FlutterEngineCache.getInstance().get(engineId)?.dartExecutor?.binaryMessenger?.let {
      Pigeon.AndroidWindowHandler(it).handler(message,result)
    }
  }

  private fun canDrawOverlays(): Boolean {
    return if (Build.VERSION.SDK_INT > Build.VERSION_CODES.M) {
      Settings.canDrawOverlays(activity)
    } else {
      true
    }
  }

  private fun requestPermission(callback: () -> Unit) {
    onActivityResultCallback = callback
    if (Build.VERSION.SDK_INT > Build.VERSION_CODES.M) {
      val intent = Intent(
        Settings.ACTION_MANAGE_OVERLAY_PERMISSION, Uri.parse("package:${activity.packageName}")
      )
      activity.startActivityForResult(intent, Activity.RESULT_FIRST_USER)
    }
  }

  fun onActivityResult() {
    onActivityResultCallback?.invoke()
  }
}
