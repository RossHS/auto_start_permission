package ru.khapilov.auto_start_permission

import android.content.Context
import android.util.Log
import com.judemanutd.autostarter.AutoStartPermissionHelper
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import xyz.kumaraswamy.autostart.Autostart
import xyz.kumaraswamy.autostart.Utils

/** AutoStartPermissionPlugin */
class AutoStartPermissionPlugin : FlutterPlugin, MethodCallHandler, FlutterActivity() {
    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private lateinit var channel: MethodChannel
    private lateinit var context: Context

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "auto_start_permission_plugin")
        channel.setMethodCallHandler(this)
        context = flutterPluginBinding.applicationContext
    }

    override fun onMethodCall(call: MethodCall, result: Result) {
        val method = call.method
        val args = call.arguments
        try {
            when (method) {
                "isOnMiui" -> {
                    result.success(Utils.isOnMiui())
                }

                "isAutoStartPermissionAvailable" -> {
                    val autoStartAvailable = AutoStartPermissionHelper.getInstance()
                        .isAutoStartPermissionAvailable(context)
                    result.success(autoStartAvailable)
                }

                "checkAutoStartPermissionState" -> {
                    result.success(Autostart.getAutoStartState(context).name)
                }

                "requestAutoStartPermission" -> {
                    val arguments = call.arguments!! as Map<*, *>
                    val open: Boolean = arguments["open"] as Boolean
                    val newTask: Boolean = arguments["newTask"] as Boolean
                    val per = AutoStartPermissionHelper.getInstance()
                        .getAutoStartPermission(context, open = open, newTask = newTask)
                    result.success(per)
                }
                else -> result.notImplemented()
            }
        } catch (e: Exception) {
            handleMethodCallError(result, e)
        }
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    companion object {
        private const val TAG = "AutoStartPermissionPlugin"

        /** Handles errors that occur in MethodChannel. */
        fun handleMethodCallError(result: MethodChannel.Result, exception: Exception) {
            Log.e(TAG, "unknown Method call")
            val name = exception.javaClass.simpleName
            val message = exception.message
            result.error(name, message, null)
        }
    }
}
