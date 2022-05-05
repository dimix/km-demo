package com.jetbrains.kmm.shared.common

expect fun localized(key: String): String
expect fun localized(key: String, vararg arguments: Any?): String
