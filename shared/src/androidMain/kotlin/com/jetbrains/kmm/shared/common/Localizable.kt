package com.jetbrains.kmm.shared.common

import android.annotation.SuppressLint
import android.content.Context

actual fun localized(key: String): String {
    val context = ContextHelper.context
    val resId = context.resources.getIdentifier(key, "string", context.packageName)
    return context.getString(resId)
}

actual fun localized(key: String, vararg arguments: Any?): String {
    val context = ContextHelper.context
    val resId = context.resources.getIdentifier(key, "string", context.packageName)
    return context.getString(resId, *arguments)
}

@SuppressLint("StaticFieldLeak")
object ContextHelper {
    lateinit var context: Context
}
