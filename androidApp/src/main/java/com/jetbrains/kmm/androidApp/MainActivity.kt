package com.jetbrains.kmm.androidApp

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle

import androidx.fragment.app.Fragment
import com.jetbrains.androidApp.R
import com.jetbrains.kmm.androidApp.fragments.JobsFragments
import com.jetbrains.kmm.shared.common.ContextHelper

class MainActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        setContentView(R.layout.activity_main)

        ContextHelper.context = this

        supportFragmentManager
            .beginTransaction()
            .add(R.id.fragmentContainer, JobsFragments())
            .commit()
    }

    override fun onBackPressed() {
        supportFragmentManager.popBackStack()
    }

    fun pushFragment(fragment: Fragment) {
        supportFragmentManager
            .beginTransaction()
            .addToBackStack("tag")
            .replace(R.id.fragmentContainer, fragment)
            .commit()
    }
}