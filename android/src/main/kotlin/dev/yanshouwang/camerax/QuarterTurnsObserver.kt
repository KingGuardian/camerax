package dev.yanshouwang.camerax

import android.app.Activity
import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.content.IntentFilter
import android.content.res.Configuration
import android.view.Display
import android.view.Surface
import android.view.WindowManager
import io.flutter.embedding.engine.systemchannels.PlatformChannel.DeviceOrientation

/**
 * 屏幕旋转方向服务，还需要测试，功能和API都还不完善
 */
class QuarterTurnsObserver(
    private val activity: Activity,
    private val isFrontFacing: Boolean,
    private val defaultOrientation: Int,
    private val onChanged: (quarterTurns: Int) -> Unit) {

    //屏幕方向filter
    private val orientationIntentFilter = IntentFilter(Intent.ACTION_CONFIGURATION_CHANGED)
    private var broadCastReceiver: BroadcastReceiver? = null

    var deviceOrientation = 0

    //开始通过广播进行监听
    fun start() {
        if (broadCastReceiver != null) {
            //不再重复监听
            return
        }
        broadCastReceiver = object : BroadcastReceiver() {
            override fun onReceive(context: Context?, intent: Intent?) {
                handleOrientationChanged()
            }
        }

        activity.registerReceiver(broadCastReceiver, orientationIntentFilter)
        //注册后发起一次空的请求，直接拿第一次的数据？需要debug验证
        broadCastReceiver?.onReceive(activity, null)
    }

    //停止监听
    fun stop() {
        if (broadCastReceiver == null) {
            return
        }
        activity.unregisterReceiver(broadCastReceiver)
        broadCastReceiver = null
    }

    fun handleOrientationChanged() {
        //获取当前设备旋转角度
        deviceOrientation = when (getUIOrientation()) {
            DeviceOrientation.PORTRAIT_UP -> 0
            DeviceOrientation.LANDSCAPE_LEFT -> 3
            DeviceOrientation.LANDSCAPE_RIGHT -> 1
            DeviceOrientation.PORTRAIT_DOWN -> 2
        }
        onChanged(deviceOrientation)
    }

    private fun getUIOrientation(): DeviceOrientation {
        val rotation: Int = getDisplay()?.rotation ?: 0
        return when (activity.resources.configuration.orientation) {
            Configuration.ORIENTATION_PORTRAIT -> if (rotation == Surface.ROTATION_0 || rotation == Surface.ROTATION_90) {
                DeviceOrientation.PORTRAIT_UP
            } else {
                DeviceOrientation.PORTRAIT_DOWN
            }
            Configuration.ORIENTATION_LANDSCAPE -> if (rotation == Surface.ROTATION_0 || rotation == Surface.ROTATION_90) {
                DeviceOrientation.LANDSCAPE_LEFT
            } else {
                DeviceOrientation.LANDSCAPE_RIGHT
            }
            else -> DeviceOrientation.PORTRAIT_UP
        }
    }

    private fun getDisplay(): Display? {
        return (activity.getSystemService(Context.WINDOW_SERVICE) as WindowManager).defaultDisplay
    }
}
