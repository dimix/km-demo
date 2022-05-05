package com.jetbrains.kmm.androidApp.model

import com.jetbrains.kmm.androidApp.utilities.formatted
import com.jetbrains.kmm.shared.model.Job
import kotlinx.datetime.*

val Job.startDateFormatted: String get() {
    return startDate?.formatted(TimeZone.currentSystemDefault()) ?: ""
}

val Job.endDateFormatted: String get() {
    return endDate?.formatted(TimeZone.currentSystemDefault()) ?: ""
}
