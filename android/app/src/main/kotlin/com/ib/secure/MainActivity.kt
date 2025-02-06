package com.ib.secure

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import android.content.Intent
import android.os.Bundle
import android.app.PendingIntent

class MainActivity: FlutterActivity() {
    private val CHANNEL = "secure_wave/app_control"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                "launchApp" -> {
                    try {
                        forceLaunchApp()
                        result.success(true)
                    } catch (e: Exception) {
                        result.error("LAUNCH_ERROR", e.message, null)
                    }
                }
                else -> {
                    result.notImplemented()
                }
            }
        }
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        
        if (intent?.action == "com.ib.secure.LAUNCH_APP") {
            forceLaunchApp()
        }
    }
    
    private fun forceLaunchApp() {
        try {
            // Try to bring existing task to front
            val am = getSystemService(ACTIVITY_SERVICE) as android.app.ActivityManager
            am.moveTaskToFront(taskId, android.app.ActivityManager.MOVE_TASK_WITH_HOME)
            
            // Also try launching through package manager
            val launchIntent = packageManager.getLaunchIntentForPackage(packageName)?.apply {
                addFlags(Intent.FLAG_ACTIVITY_NEW_TASK or
                        Intent.FLAG_ACTIVITY_RESET_TASK_IF_NEEDED or
                        Intent.FLAG_ACTIVITY_SINGLE_TOP or
                        Intent.FLAG_ACTIVITY_CLEAR_TOP)
            }
            if (launchIntent != null) {
                startActivity(launchIntent)
            } else {
                // Direct launch as fallback
                val intent = Intent(this, MainActivity::class.java).apply {
                    action = "com.ib.secure.LAUNCH_APP"
                    addCategory(Intent.CATEGORY_LAUNCHER)
                    addFlags(Intent.FLAG_ACTIVITY_NEW_TASK or
                            Intent.FLAG_ACTIVITY_RESET_TASK_IF_NEEDED or
                            Intent.FLAG_ACTIVITY_SINGLE_TOP or
                            Intent.FLAG_ACTIVITY_CLEAR_TOP)
                }
                startActivity(intent)
            }
        } catch (e: Exception) {
            e.printStackTrace()
        }
    }
    
    override fun onNewIntent(intent: Intent) {
        super.onNewIntent(intent)
        if (intent.action == "com.ib.secure.LAUNCH_APP") {
            forceLaunchApp()
        }
    }
} 