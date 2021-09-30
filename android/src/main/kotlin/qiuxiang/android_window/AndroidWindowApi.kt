package qiuxiang.android_window

class AndroidWindowApi(private val androidWindow: AndroidWindow) : Pigeon.AndroidWindowApi {
  override fun setLayout(width: Long, height: Long) {
    androidWindow.setLayout(width.toInt(), height.toInt())
  }

  override fun setPosition(x: Long, y: Long) {
    androidWindow.setPosition(x.toInt(), y.toInt())
  }

  override fun dragStart() {
    androidWindow.dragStart()
  }

  override fun dragEnd() {
    androidWindow.dragEnd()
  }

  override fun close() {
    androidWindow.service.stopSelf()
  }
}