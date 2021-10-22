package qiuxiang.android_window

import android.content.Intent
import io.flutter.embedding.android.FlutterActivity

open class AndroidWindowActivity : FlutterActivity() {
  override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
    super.onActivityResult(requestCode, resultCode, data)
    app?.mainApi?.onActivityResult()
  }

  override fun onStart() {
    super.onStart()
    app?.activity = this
  }
}
