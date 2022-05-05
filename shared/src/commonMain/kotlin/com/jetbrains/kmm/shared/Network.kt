package com.jetbrains.kmm.shared

import com.jetbrains.kmm.shared.model.ArrayResponse
import com.jetbrains.kmm.shared.model.Job
import io.github.aakira.napier.Napier
import io.ktor.client.HttpClient
import io.ktor.client.features.json.JsonFeature
import io.ktor.client.features.json.serializer.KotlinxSerializer
import io.ktor.client.request.*
import kotlinx.serialization.json.Json

object Network {
    const val baseURL = "https://www.dimitrigiani.it/codermine/km"

    private val httpClient = HttpClient {
        install(JsonFeature) {
            val json = Json {
                prettyPrint = true
                isLenient = true
                ignoreUnknownKeys = true
            }
            serializer = KotlinxSerializer(json)
        }
    }

    suspend fun getJobs(): List<Job> {
        return try {
            val response: ArrayResponse<Job> = httpClient.get("$baseURL/jobs.json")
            response.result
        } catch (e: Exception) {
            Napier.w("Error: $e")
            return listOf()
        }
    }
}