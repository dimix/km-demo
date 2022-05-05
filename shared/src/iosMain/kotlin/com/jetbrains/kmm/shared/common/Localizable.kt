package com.jetbrains.kmm.shared.common

import platform.Foundation.NSBundle
import platform.Foundation.NSString
import platform.Foundation.NSURL
import platform.Foundation.stringWithFormat

actual fun localized(key: String): String {
    return key.localized()
}

actual fun localized(key: String, vararg arguments: Any?): String {
    return key.localized(arguments)
}

fun String.localized(): String {
    val localizedString = NSBundle.mainBundle.localizedStringForKey(this, this, null)
    if (localizedString != this) return localizedString

    val baseResourcePath = NSBundle.mainBundle.pathForResource("Base", "lproj")
        ?.let { NSURL(fileURLWithPath = it) }
    val baseBundle = baseResourcePath?.let { NSBundle(it) }

    if (baseBundle != null) {
        val baseString = baseBundle.localizedStringForKey(this, this, null)
        if (baseString != this) return baseString
    }

    return this
}

fun String.localized(vararg arguments: Any?): String {
    val format = localized()
    if (arguments.isNotEmpty()) {
        val first = arguments[0] as? Array<*>
        if (first != null) {
            // Shorten the variable name
            val a = first
            // Kotlin does not support passing variadic parameters to Objective-C
            // We implement calling the method with up to 9 arguments which is enough in practice
            return when (first.size) {
                0 -> NSString.stringWithFormat(format)
                1 -> NSString.stringWithFormat(format, a[0])
                2 -> NSString.stringWithFormat(format, a[0], a[1])
                3 -> NSString.stringWithFormat(format, a[0], a[1], a[2])
                4 -> NSString.stringWithFormat(format, a[0], a[1], a[2], a[3])
                5 -> NSString.stringWithFormat(format, a[0], a[1], a[2], a[3], a[4])
                6 -> NSString.stringWithFormat(format, a[0], a[1], a[2], a[3], a[4], a[5])
                7 -> NSString.stringWithFormat(format, a[0], a[1], a[2], a[3], a[4], a[5], a[6])
                8 -> NSString.stringWithFormat(format, a[0], a[1], a[2], a[3], a[4], a[5], a[6], a[7])
                9 -> NSString.stringWithFormat(format, a[0], a[1], a[2], a[3], a[4], a[5], a[6], a[7], a[8])
                else -> error("Too many arguments.")
            }
        }
    }

    return format
}