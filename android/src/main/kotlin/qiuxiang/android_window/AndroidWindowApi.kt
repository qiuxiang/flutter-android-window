package qiuxiang.android_window

import android.content.Intent

class AndroidWindowApi(private val window: AndroidWindow) : Pigeon.AndroidWindowApi {
  override fun resize(width: Long, height: Long) {
    window.setLayout(width.toInt(), height.toInt())
  }

  override fun setPosition(x: Long, y: Long) {
    window.setPosition(x.toInt(), y.toInt())
  }

  override fun post(message: MutableMap<Any, Any>, result: Pigeon.Result<MutableMap<Any, Any>>) {
    AndroidWindowPlugin.messenger?.let {
      Pigeon.MainHandler(it).handler(message, result)
    }
  }

  override fun dragStart() {
    window.dragStart()
  }

  override fun dragEnd() {
    window.dragEnd()
  }

  override fun close() {
    window.service.stopSelf()
  }

  override fun launchApp() {
    val intent = Intent(window.service, AndroidWindowPlugin.activityClass)
    intent.flags = Intent.FLAG_ACTIVITY_NEW_TASK
    window.service.startActivity(intent)
  }
}