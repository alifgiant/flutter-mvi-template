package com.luxinfity.asetku

import androidx.annotation.NonNull
import com.luxinfity.asetku.executor.BaseExecutor
import com.luxinfity.asetku.executor.unit
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.Job
import kotlinx.coroutines.SupervisorJob
import kotlinx.coroutines.launch
import kotlinx.coroutines.withContext
import kotlin.coroutines.CoroutineContext

class MainActivity : FlutterActivity() {
    private val executors = mapOf<String, BaseExecutor<*>>(
        "AvailableExecutor" to AvailableExecutor { this }
    )

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        val appName = applicationInfo.packageName
        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            appName
        ).setMethodCallHandler { call, result ->
            try {
                if (executors.containsKey(call.method)) {
                    executors[call.method]?.execute(call, result)
                } else {
                    result.notImplemented()
                }
            } catch (e: Exception) {
                result.error("exception-thrown", e.message, e.cause)
            }
        }
    }

    // example
    class AvailableExecutor(val act: () -> MainActivity) : BaseExecutor<List<String>> {
        private val job: Job = SupervisorJob()

        override val coroutineContext: CoroutineContext
            get() = job + Dispatchers.Main

        override fun execute(call: MethodCall, result: MethodChannel.Result) = launch {
            deliverResult(result, act().executors.keys.toList())
        }.unit()

        override suspend fun deliverResult(
            result: MethodChannel.Result,
            data: List<String>?
        ) = withContext(Dispatchers.Main) {
            result.success(data)
        }
    }
}
