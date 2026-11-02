package com.example.personal_spending_app

import android.content.ContentValues
import android.os.Build
import android.os.Environment
import android.provider.MediaStore
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.android.FlutterActivity
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
            .setMethodCallHandler { call, result ->
                when (call.method) {
                    "updateBudgetWidget" -> {
                        val budget = call.argument<Int>("budget") ?: 0
                        val spent = call.argument<Int>("spent") ?: 0
                        val creditBalance = call.argument<Int>("creditBalance") ?: 0
                        val dailyCredit = call.argument<Int>("dailyCredit") ?: 0
                        val monthlyAvailable = call.argument<Int>("monthlyAvailable") ?: 0
                        val style = call.argument<String>("style")
                        getSharedPreferences(PREFS_NAME, MODE_PRIVATE)
                            .edit()
                            .putInt(KEY_BUDGET, budget)
                            .putInt(KEY_SPENT, spent)
                            .putInt(KEY_CREDIT_BALANCE, creditBalance)
                            .putInt(KEY_DAILY_CREDIT, dailyCredit)
                            .putInt(KEY_MONTHLY_AVAILABLE, monthlyAvailable)
                            .apply {
                                if (style != null) {
                                    putString(KEY_STYLE, style)
                                }
                            }
                            .apply()
                        BudgetWidgetProvider.updateAll(this)
                        result.success(null)
                    }
                    "setBudgetWidgetStyle" -> {
                        val style = call.argument<String>("style") ?: DEFAULT_STYLE
                        getSharedPreferences(PREFS_NAME, MODE_PRIVATE)
                            .edit()
                            .putString(KEY_STYLE, style)
                            .apply()
                        BudgetWidgetProvider.updateAll(this)
                        result.success(null)
                    }
                    else -> {
                        result.notImplemented()
                    }
                }
            }

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, FILE_CHANNEL)
            .setMethodCallHandler { call, result ->
                when (call.method) {
                    "saveJsonToDownloads" -> saveJsonToDownloads(call, result)
                    else -> result.notImplemented()
                }
            }
    }

    private fun saveJsonToDownloads(call: io.flutter.plugin.common.MethodCall, result: MethodChannel.Result) {
        if (Build.VERSION.SDK_INT < Build.VERSION_CODES.Q) {
            result.error("unsupported_android_version", "Android 10 or newer is required.", null)
            return
        }
        val fileName = call.argument<String>("fileName")
        val content = call.argument<String>("content")
        if (fileName.isNullOrBlank() || content == null) {
            result.error("invalid_export", "File name and content are required.", null)
            return
        }

        val values = ContentValues().apply {
            put(MediaStore.Downloads.DISPLAY_NAME, fileName)
            put(MediaStore.Downloads.MIME_TYPE, "application/json")
            put(MediaStore.Downloads.RELATIVE_PATH, Environment.DIRECTORY_DOWNLOADS)
            put(MediaStore.Downloads.IS_PENDING, 1)
        }
        val uri = contentResolver.insert(MediaStore.Downloads.EXTERNAL_CONTENT_URI, values)
        if (uri == null) {
            result.error("export_failed", "Download file could not be created.", null)
            return
        }

        try {
            contentResolver.openOutputStream(uri)?.bufferedWriter().use { writer ->
                if (writer == null) {
                    throw IllegalStateException("Download output stream could not be opened.")
                }
                writer.write(content)
            }
            contentResolver.update(
                uri,
                ContentValues().apply { put(MediaStore.Downloads.IS_PENDING, 0) },
                null,
                null,
            )
            result.success(uri.toString())
        } catch (error: Exception) {
            contentResolver.delete(uri, null, null)
            result.error("export_failed", error.message, null)
        }
    }

    companion object {
        const val PREFS_NAME = "budget_widget"
        const val KEY_BUDGET = "monthly_budget"
        const val KEY_SPENT = "spent_this_month"
        const val KEY_CREDIT_BALANCE = "credit_balance"
        const val KEY_DAILY_CREDIT = "daily_credit"
        const val KEY_MONTHLY_AVAILABLE = "monthly_available"
        const val KEY_STYLE = "widget_style"
        const val CHANNEL = "personal_spending/widget"
        const val FILE_CHANNEL = "personal_spending/file"
        const val DEFAULT_STYLE = "wave"
    }
}
