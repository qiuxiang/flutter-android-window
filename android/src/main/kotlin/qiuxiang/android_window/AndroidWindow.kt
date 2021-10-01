package qiuxiang.android_window

import android.annotation.SuppressLint
import android.app.Service
import android.graphics.PixelFormat
import android.view.*
import android.widget.LinearLayout
import io.flutter.embedding.android.FlutterSurfaceView
import io.flutter.embedding.android.FlutterView
import io.flutter.embedding.engine.FlutterEngine
import kotlin.math.roundToInt

class AndroidWindow(
  val service: Service,
  width: Int,
  height: Int,
  private val x: Int,
  private val y: Int,
  private val engine: FlutterEngine
) {
  private var startX = 0f
  private var startY = 0f
  private var initialX = 0
  private var initialY = 0
  private var dragging = false
  private lateinit var flutterView: FlutterView
  private var windowManager = service.getSystemService(Service.WINDOW_SERVICE) as WindowManager
  private val inflater = service.getSystemService(Service.LAYOUT_INFLATER_SERVICE) as LayoutInflater

  @SuppressLint("InflateParams")
  private var rootView = inflater.inflate(R.layout.floating, null) as ViewGroup
  private val layoutParams = WindowManager.LayoutParams(
    width,
    height,
    if (android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.O) {
      WindowManager.LayoutParams.TYPE_APPLICATION_OVERLAY
    } else {
      @Suppress("Deprecation")
      WindowManager.LayoutParams.TYPE_TOAST
    },
    WindowManager.LayoutParams.FLAG_NOT_FOCUSABLE,
    PixelFormat.TRANSLUCENT
  )

  fun open() {
    val floatingApi = AndroidWindowApi(this)
    Pigeon.AndroidWindowApi.setup(engine.dartExecutor.binaryMessenger, floatingApi)
    layoutParams.gravity = Gravity.START or Gravity.TOP
    layoutParams.x = x
    layoutParams.y = y
    windowManager.addView(rootView, layoutParams)
    flutterView = FlutterView(inflater.context, FlutterSurfaceView(inflater.context, true))
    flutterView.attachToFlutterEngine(engine)
    @Suppress("ClickableViewAccessibility")
    flutterView.setOnTouchListener { _, event ->
      when (event.action) {
        MotionEvent.ACTION_MOVE -> {
          if (dragging) {
            layoutParams.x = initialX + (event.rawX - startX).roundToInt()
            layoutParams.y = initialY + (event.rawY - startY).roundToInt()
            windowManager.updateViewLayout(rootView, layoutParams)
          } else {
            startX = event.rawX
            startY = event.rawY
            initialX = layoutParams.x
            initialY = layoutParams.y
          }
          false
        }
        else -> false
      }
    }
    engine.lifecycleChannel.appIsResumed()
    rootView.findViewById<LinearLayout>(R.id.floating_window)
      .addView(
        flutterView,
        ViewGroup.LayoutParams(
          ViewGroup.LayoutParams.MATCH_PARENT,
          ViewGroup.LayoutParams.MATCH_PARENT
        )
      )
  }

  fun dragStart() {
    dragging = true
  }

  fun dragEnd() {
    dragging = false
  }

  fun close() {
    flutterView.detachFromFlutterEngine()
    windowManager.removeView(rootView)
  }

  fun setLayout(width: Int, height: Int) {
    layoutParams.width = width
    layoutParams.height = height
    windowManager.updateViewLayout(rootView, layoutParams)
  }

  fun setPosition(x: Int, y: Int) {
    layoutParams.x = x
    layoutParams.y = y
    windowManager.updateViewLayout(rootView, layoutParams)
  }
}

val AndroidWindow.app: AndroidWindowApplication?
  get() {
    return service.application as? AndroidWindowApplication
  }
