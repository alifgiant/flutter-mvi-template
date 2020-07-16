package com.luxinfity.asetku.executor

import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Job

interface BaseExecutor<T> : CoroutineScope {
    fun execute(call: MethodCall, result: MethodChannel.Result)
    suspend fun deliverResult(result: MethodChannel.Result, data: T?)
}

fun Job.unit() = Unit