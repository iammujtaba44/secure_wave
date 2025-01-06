package com.infinite_binary.secure_wave
import io.flutter.embedding.android.FlutterActivity

class MainActivity: FlutterActivity()



// package com.infinite_binary.secure_wave

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
