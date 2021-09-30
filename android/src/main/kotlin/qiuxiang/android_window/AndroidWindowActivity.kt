package qiuxiang.android_window

import android.content.Intent
import io.flutter.embedding.android.FlutterActivity

open class AndroidWindowActivity : FlutterActivity() {
  override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
    app?.mainApi?.onActivityResult()
  }
}
