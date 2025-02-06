// package com.ib.secure

// import android.content.ComponentName
// import android.content.Context
// import android.content.pm.PackageManager

// object LauncherUtils {
//     fun toggleLauncherIcon(context: Context, show: Boolean) {
//         val packageManager: PackageManager = context.packageManager
//         val componentName = ComponentName(context, "${context.packageName}.LauncherActivity")
        
//         val newState = if (show) {
//             PackageManager.COMPONENT_ENABLED_STATE_ENABLED
//         } else {
//             PackageManager.COMPONENT_ENABLED_STATE_DISABLED
//         }
        
//         packageManager.setComponentEnabledSetting(
//             componentName,
//             newState,
//             PackageManager.DONT_KILL_APP
//         )
//     }
// }