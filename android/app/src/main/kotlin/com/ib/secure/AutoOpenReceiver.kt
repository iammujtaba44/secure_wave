package com.ib.secure

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.util.Log

class AutoOpenReceiver : BroadcastReceiver() {
    override fun onReceive(context: Context, intent: Intent) {
        Log.d("AutoOpenReceiver", "Received a message, opening the app...")

        try {
            // Get the package name from the intent extras if available
            val packageName = intent.getStringExtra("package") ?: context.packageName

            // Create an intent to launch the app
            val launchIntent = context.packageManager.getLaunchIntentForPackage(packageName)?.apply {
                addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
                addFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP)
                addFlags(Intent.FLAG_ACTIVITY_SINGLE_TOP)
                action = "com.ib.secure.OPEN_APP"
                
                // Forward any extras
                intent.extras?.let { putExtras(it) }
            }

            if (launchIntent != null) {
                context.startActivity(launchIntent)
                Log.d("AutoOpenReceiver", "Successfully launched activity")
            } else {
                Log.e("AutoOpenReceiver", "Could not create launch intent for package: $packageName")
            }
        } catch (e: Exception) {
            Log.e("AutoOpenReceiver", "Failed to start activity", e)
        }
    }
}