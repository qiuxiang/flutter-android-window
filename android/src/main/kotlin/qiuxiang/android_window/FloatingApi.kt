package qiuxiang.android_window

class FloatingApi(private val window: FloatingWindow) : Pigeon.FloatingApi {
  override fun setLayout(width: Long, height: Long) {
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
}