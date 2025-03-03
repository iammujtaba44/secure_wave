package com.ib.secure

import android.app.Activity
import android.os.Bundle

class AdminPolicyComplianceActivity : Activity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_policy_compliance)

        val intent = intent
        setResult(RESULT_OK, intent)
        finish()
    }
}
