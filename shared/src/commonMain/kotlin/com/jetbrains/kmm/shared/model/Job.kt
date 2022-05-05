package com.jetbrains.kmm.shared.model

import com.jetbrains.kmm.shared.common.localized
import io.github.aakira.napier.Napier
import kotlinx.datetime.*
import kotlinx.serialization.SerialName
import kotlinx.serialization.Serializable

@Serializable
enum class JobType {
    @SerialName("0") IOSAPP,
    @SerialName("1") UIUX;

    val title: String get() {
        return when (this) {
            IOSAPP -> "iOS"
            UIUX -> "UI/UX"
        }
    }
}

@Serializable
data class Job(
    val id: String,
    val name: String,
    val body: String,
    val start_date: String,
    val end_date: String,
    val type: JobType,
    val tasks: List<Task>
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

    val completedTasksCount: Int get() {
        return tasks.filter { it.status == TaskStatus.COMPLETED }.count()
    }

    val tasksStatusFormatted: String get() {
        if (completedTasksCount == tasks.count()) {
            return localized("task_completed")
        }
        return localized("task_status_completed", completedTasksCount.toString(), tasks.count().toString())
    }

    val taskStatusPercentage: Float get() {
        val tasksCount = tasks.count()
        if (completedTasksCount == tasksCount) {
            return 1f
        }
        return completedTasksCount.toFloat() / tasksCount.toFloat()
    }
}