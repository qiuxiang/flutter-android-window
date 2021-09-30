package qiuxiang.android_window

import android.app.Activity
import android.content.Intent
import android.net.Uri
import android.os.Build
import android.provider.Settings

class MainApi(private val activity: Activity) : Pigeon.MainApi {
  private var onActivityResultCallback: (() -> Unit)? = null

  override fun openFloatingWindow(width: Long?, height: Long?, x: Long?, y: Long?) {
    val intent = Intent(activity, FloatingService::class.java)
    intent.putExtra("width", width?.toInt())
    intent.putExtra("height", height?.toInt())
    intent.putExtra("x", x?.toInt())
    intent.putExtra("y", y?.toInt())
    if (canDrawOverlays()) {
      activity.startService(intent)
    } else {
      requestOverlayDisplayPermission {
        if (canDrawOverlays()) {
          activity.startService(intent)
        }
      }
    }
  }

  override fun closeFloatingWindow() {
    activity.stopService(Intent(activity, FloatingService::class.java))
  }

  override fun canDrawOverlays(result: Pigeon.Result<Boolean>) {
    result.success(canDrawOverlays())
  }

  override fun requestOverlayDisplayPermission(result: Pigeon.Result<Void>) {
    requestOverlayDisplayPermission { result.success(null) }
  }

  override fun send(name: String?, data: MutableMap<Any, Any>?, result: Pigeon.Result<Void>?) {
    (activity.application as? AndroidWindowApplication)?.floatingEngine?.dartExecutor?.binaryMessenger?.let {
      Pigeon.FloatingHandler(it).handler(name, data) { result?.success(null) }
    }
  }

  private fun canDrawOverlays(): Boolean {
    return if (Build.VERSION.SDK_INT > Build.VERSION_CODES.M) {
      Settings.canDrawOverlays(activity)
    } else {
      true
    }
  }

  private fun requestOverlayDisplayPermission(callback: () -> Unit) {
    onActivityResultCallback = callback
    if (Build.VERSION.SDK_INT > Build.VERSION_CODES.M) {
      val intent = Intent(
        Settings.ACTION_MANAGE_OVERLAY_PERMISSION,
        Uri.parse("package:${activity.packageName}")
      )
      activity.startActivityForResult(intent, Activity.RESULT_FIRST_USER)
    }
  }

  fun onActivityResult() {
    onActivityResultCallback?.invoke()
  }
}
