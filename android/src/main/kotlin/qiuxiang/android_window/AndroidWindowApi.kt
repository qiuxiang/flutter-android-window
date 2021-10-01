package qiuxiang.android_window

class AndroidWindowApi(private val window: AndroidWindow) : Pigeon.AndroidWindowApi {
  override fun resize(width: Long, height: Long) {
    window.setLayout(width.toInt(), height.toInt())
  }

  override fun setPosition(x: Long, y: Long) {
    window.setPosition(x.toInt(), y.toInt())
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

  override fun post(data: MutableMap<Any, Any>?, result: Pigeon.Result<MutableMap<Any, Any>>?) {
    window.app?.mainBinaryMessenger?.let {
      Pigeon.MainHandler(it).handler(data) { response -> result?.success(response) }
    }
  }
}