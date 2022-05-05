package com.jetbrains.kmm.androidApp.model

import com.jetbrains.kmm.androidApp.utilities.formatted
import com.jetbrains.kmm.shared.model.Task
import kotlinx.datetime.TimeZone

val Task.startDateFormatted: String get() {
    return startDate?.formatted(TimeZone.currentSystemDefault()) ?: ""
}

val Task.endDateFormatted: String get() {
    return endDate?.formatted(TimeZone.currentSystemDefault()) ?: ""
}
