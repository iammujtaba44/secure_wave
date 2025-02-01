package com.ib.secure
import android.content.Intent
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
    private val CHANNEL = "secure_wave/app_control"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                "launchApp" -> {
                    try {
                        val intent = context.packageManager.getLaunchIntentForPackage(context.packageName)
                        intent?.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK or Intent.FLAG_ACTIVITY_CLEAR_TOP)
                        context.startActivity(intent)
                        result.success(true)
                    } catch (e: Exception) {
                        result.error("LAUNCH_ERROR", "Failed to launch app", e.toString())
                    }
                }
                else -> result.notImplemented()
            }
        }
    }
}

// package com.ib.secure

// import io.flutter.embedding.android.FlutterActivity
// import android.app.admin.DevicePolicyManager
// import android.content.ComponentName
// import android.content.Context
// import android.os.Bundle
// import io.flutter.plugin.common.MethodChannel

// class MainActivity : FlutterActivity() {
//     private val CHANNEL = "dpc_app_channel"
//     private lateinit var devicePolicyManager: DevicePolicyManager
//     private lateinit var adminComponent: ComponentName

//     override fun onCreate(savedInstanceState: Bundle?) {
//         super.onCreate(savedInstanceState)

//         devicePolicyManager = getSystemService(Context.DEVICE_POLICY_SERVICE) as DevicePolicyManager
//         adminComponent = ComponentName(this, MyDeviceAdminReceiver::class.java)

//         MethodChannel(flutterEngine?.dartExecutor!!.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
//             when (call.method) {
//                 "startKioskMode" -> {
//                     startKioskMode()
//                     result.success("Kiosk Mode Started")
//                 }
//                 "showLockScreen" -> {
//                     val message = call.argument<String>("message") ?: "Contact emergency support"
//                     showLockScreen(message)
//                     result.success("Emergency Screen Displayed")
//                 }
//                 else -> result.notImplemented()
//             }
//         }
//     }

//     private fun startKioskMode() {
//         if (devicePolicyManager.isDeviceOwnerApp(packageName)) {
//             devicePolicyManager.setLockTaskPackages(adminComponent, arrayOf(packageName))
//             startLockTask()
//         }
//     }

//     private fun showLockScreen(message: String) {
//         // Navigate to a custom lock screen in Flutter with emergency information
//         runOnUiThread {
//             flutterEngine?.navigationChannel?.pushRoute("/lock?message=$message")
//         }
//     }
// }
