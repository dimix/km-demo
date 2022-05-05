package com.jetbrains.kmm.androidApp.utilities

import kotlinx.datetime.Instant
import kotlinx.datetime.TimeZone
import kotlinx.datetime.toJavaInstant
import kotlinx.datetime.toJavaZoneId
import java.time.format.DateTimeFormatter
import java.time.format.FormatStyle

fun Instant.formatted(timezone: TimeZone): String {
    return DateTimeFormatter.ofLocalizedDate(FormatStyle.MEDIUM).format(this.toJavaInstant().atZone(timezone.toJavaZoneId()))
}