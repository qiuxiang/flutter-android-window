package qiuxiang.android_window

import android.content.Intent
import android.os.IBinder
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.dart.DartExecutor

class WindowService : android.app.Service() {
  private lateinit var engine: FlutterEngine
  private lateinit var androidWindow: AndroidWindow
  private var running = false

  override fun onBind(intent: Intent): IBinder? {
    return null
  }

  override fun onStartCommand(intent: Intent, flags: Int, startId: Int): Int {
    if (!running) {
      engine = FlutterEngine(application)
      engine.dartExecutor.executeDartEntrypoint(
        DartExecutor.DartEntrypoint(
          findAppBundlePath(),
          "floating"
        )
      )
      (application as AndroidWindowApplication).engine = engine

      val width = intent.getIntExtra("width", 400)
      val height = intent.getIntExtra("height", 600)
      val x = intent.getIntExtra("x", 0)
      val y = intent.getIntExtra("y", 0)
      androidWindow = AndroidWindow(this, width, height, x, y, engine)
      androidWindow.open()
      running = true
    }
    return super.onStartCommand(intent, flags, startId)
  }

  override fun onDestroy() {
    androidWindow.close()
    engine.destroy()
  }
}
