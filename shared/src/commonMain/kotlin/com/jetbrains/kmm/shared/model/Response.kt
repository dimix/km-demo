package com.jetbrains.kmm.shared.model

import kotlinx.serialization.Serializable

@Serializable
class Response<T>(val result: T) {}

@Serializable
class ArrayResponse<T>(val result: List<T>) {}