package com.jetbrains.kmm.shared.model

import io.github.aakira.napier.Napier
import kotlinx.datetime.Instant
import kotlinx.datetime.toInstant
import kotlinx.serialization.SerialName
import kotlinx.serialization.Serializable
import kotlin.math.ceil

@Serializable
enum class TaskStatus {
    @SerialName("0") NONE,
    @SerialName("1") WORKING,
    @SerialName("2") COMPLETED;
}

@Serializable
class Task(
    val id: String,
    val name: String,
    val start_date: String,
    val end_date: String,
    val time_per_day: Int,
    val status: TaskStatus
) {
    val startDate: Instant?
        get() {
            try {
                return start_date.toInstant()
            } catch(e: Exception) {
                Napier.w("Date conversion error: $e")
            }
            return null
        }

    val endDate: Instant?
        get() {
            try {
                return end_date.toInstant()
            } catch(e: Exception) {
                Napier.w("Date conversion error: $e")
            }
            return null
        }

    val timePerDayFormatted: String get() {
        val hours = ceil((time_per_day / 3600).toDouble()).toInt()
        return "$hours ore al giorno"
    }
}