package com.example.personal_spending_app

import android.app.PendingIntent
import android.appwidget.AppWidgetManager
import android.appwidget.AppWidgetProvider
import android.content.ComponentName
import android.content.Context
import android.content.Intent
import android.graphics.Color
import android.view.View
import android.widget.RemoteViews
import com.example.personal_spending_app.R
import java.text.SimpleDateFormat
import java.util.Calendar
import java.util.Date
import java.util.Locale
import kotlin.math.abs

open class BudgetWidgetProvider : AppWidgetProvider() {
    override fun onUpdate(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray,
    ) {
        appWidgetIds.forEach { update(context, appWidgetManager, it) }
    }

    private fun update(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetId: Int,
    ) {
        val preferences = context.getSharedPreferences(MainActivity.PREFS_NAME, Context.MODE_PRIVATE)
        val budget = preferences.getInt(MainActivity.KEY_BUDGET, 0)
        val spent = preferences.getInt(MainActivity.KEY_SPENT, 0)
        val creditBalance = preferences.getInt(MainActivity.KEY_CREDIT_BALANCE, budget - spent)
        val dailyCredit = preferences.getInt(MainActivity.KEY_DAILY_CREDIT, 0)
        val monthlyAvailable = preferences.getInt(MainActivity.KEY_MONTHLY_AVAILABLE, budget - spent)
        val style = forcedStyle()
            ?: preferences.getString(MainActivity.KEY_STYLE, MainActivity.DEFAULT_STYLE)
            ?: MainActivity.DEFAULT_STYLE
        val progress = if (budget <= 0) 0 else ((spent.toFloat() / budget.toFloat()) * 100).toInt().coerceIn(0, 100)
        val remainingPercent = if (budget <= 0) 0 else ((monthlyAvailable.toFloat() / budget.toFloat()) * 100).toInt().coerceAtLeast(0)
        val isOverBudget = budget > 0 && monthlyAvailable < 0
        val isCreditDebt = creditBalance < 0
        val message = selectMessage(budget, spent, remainingPercent, isOverBudget, isCreditDebt)
        val views = RemoteViews(context.packageName, layoutForStyle(style)).apply {
            setTextViewText(R.id.widget_title, "오늘 소비 크레딧")
            setTextViewText(R.id.widget_amount, formatKrw(creditBalance))
            setTextColor(
                R.id.widget_amount,
                Color.parseColor(if (isCreditDebt) "#C85B2F" else "#111111"),
            )
            setTextViewText(
                R.id.widget_caption,
                if (budget == 0) "앱에서 예산을 설정해 주세요"
                else "오늘 충전 ${formatKrw(dailyCredit)} / 월 잔여 ${formatKrw(monthlyAvailable)}",
            )
            setTextViewText(
                R.id.widget_state,
                message.state,
            )
            if (style == "wave") {
                setTextViewText(R.id.widget_message, message.speech)
                setImageViewResource(R.id.widget_character, message.characterRes)
            }
            setProgressBar(R.id.widget_progress, 100, progress, false)
            setInt(
                R.id.widget_state,
                "setBackgroundResource",
                when {
                    budget == 0 -> R.drawable.widget_chip_neutral
                    isCreditDebt || isOverBudget -> R.drawable.widget_chip_warning
                    else -> R.drawable.widget_chip_positive
                },
            )
            setTextColor(
                R.id.widget_state,
                Color.parseColor(
                    when {
                        budget == 0 -> "#5F6C60"
                        isCreditDebt || isOverBudget -> "#C85B2F"
                        else -> "#1F4A22"
                    },
                ),
            )
            if (style == "calendar") {
                val now = Date()
                setTextViewText(
                    R.id.widget_calendar_month,
                    SimpleDateFormat("MMM", Locale.US).format(now).uppercase(Locale.US),
                )
                setTextViewText(
                    R.id.widget_calendar_day,
                    SimpleDateFormat("d", Locale.US).format(now),
                )
            }
            if (style == "garden") {
                setViewVisibility(R.id.widget_garden_caption, View.VISIBLE)
                setTextViewText(
                    R.id.widget_garden_caption,
                    when {
                        budget == 0 -> "START YOUR MONTH"
                        isCreditDebt -> "CREDIT DEBT"
                        isOverBudget -> "MONTH OVER"
                        remainingPercent >= 60 -> "SAFE ZONE"
                        remainingPercent >= 30 -> "WATCH ZONE"
                        else -> "TIGHT MODE"
                    },
                )
            }
            setOnClickPendingIntent(R.id.widget_root, launchIntent(context))
        }
        appWidgetManager.updateAppWidget(appWidgetId, views)
    }

    private fun launchIntent(context: Context): PendingIntent {
        val intent = Intent(context, MainActivity::class.java)
        return PendingIntent.getActivity(
            context,
            0,
            intent,
            PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE,
        )
    }

    private fun formatKrw(amount: Int): String = "${if (amount < 0) "-" else ""}₩%,d".format(abs(amount))

    private fun selectMessage(
        budget: Int,
        spent: Int,
        remainingPercent: Int,
        isOverBudget: Boolean,
        isCreditDebt: Boolean,
    ): WidgetMessage {
        val calendar = Calendar.getInstance()
        val day = calendar.get(Calendar.DAY_OF_MONTH)
        val seedBase = day + (spent / 10000) + remainingPercent

        if (budget <= 0) {
            return WidgetMessage(
                state = "SET BUDGET",
                speech = pickMessage(
                    seed = seedBase,
                    "이번 달 예산부터\n같이 정해보자!",
                    "먼저 예산부터!\n그래야 내가 도와줘",
                    "출발 준비 완료?\n예산부터 입력하자",
                    "이번 달 기준선부터\n함께 세워보자!",
                ),
                characterRes = R.drawable.widget_pixel_alien_curious,
            )
        }

        if (isCreditDebt) {
            return WidgetMessage(
                state = "CREDIT DEBT",
                speech = pickMessage(
                    seed = seedBase,
                    "오늘 충전으로\n천천히 회복하자!",
                    "괜찮아, 내일 크레딧이\n먼저 빚을 갚아줘!",
                    "지금은 회복 턴!\n필수 소비만 가보자",
                    "마이너스지만 괜찮아.\n하루씩 다시 채우자!",
                ),
                characterRes = R.drawable.widget_pixel_alien_worried,
            )
        }

        if (isOverBudget) {
            return WidgetMessage(
                state = "OVER",
                speech = pickMessage(
                    seed = seedBase,
                    "앗, 지금은\n브레이크 타임!",
                    "이번 주는\n소비 숨 고르기!",
                    "괜찮아, 이제부터\n천천히 회복하자!",
                    "잠깐 멈춤!\n지갑 회복 모드야",
                    "오늘은 방어 턴.\n천천히 다시 맞추자",
                ),
                characterRes = R.drawable.widget_pixel_alien_dizzy,
            )
        }

        val lastDay = calendar.getActualMaximum(Calendar.DAY_OF_MONTH)
        val monthProgress = day.toFloat() / lastDay.toFloat()
        val spentRatio = spent.toFloat() / budget.toFloat()
        val paceRatio = if (monthProgress == 0f) 0f else spentRatio / monthProgress
        val isEndOfMonth = monthProgress >= 0.8f
        val isOnTrackAtMonthEnd = isEndOfMonth && paceRatio <= 1.05f
        val messageSeed = day + (spent / 10000) + remainingPercent

        if (spent == 0 && day >= 5) {
            return WidgetMessage(
                state = "100% LEFT",
                speech = pickMessage(
                    seed = messageSeed,
                    "아직 0원!\n완전 잘 버티는 중",
                    "지금 흐름 좋아,\n스타트가 완벽해",
                    "와, 이번 달 출발\n아주 예쁘다!",
                    "오늘까지 0원!\n진짜 잘 막는 중",
                    "소비 게이트 방어중.\n아주 든든해",
                    "텅 빈 지출표,\n이거 꽤 멋진데!",
                ),
                characterRes = R.drawable.widget_pixel_alien_happy,
            )
        }

        return when {
            paceRatio <= 0.85f -> WidgetMessage(
                state = "${remainingPercent}% LEFT",
                speech = pickMessage(
                    seed = messageSeed,
                    "아주 좋아!\n지금 페이스 완벽",
                    "여유 있어,\n오늘도 안정적이야",
                    "천재 절약 모드야.\n이 흐름 유지!",
                    "완전 순항중!\n지금 리듬 좋아",
                    "이 정도면 거의\n프로 예산러야",
                    "너무 잘 간다!\n오늘도 클린해",
                ),
                characterRes = R.drawable.widget_pixel_alien_happy,
            )
            paceRatio <= 1.0f || isOnTrackAtMonthEnd -> WidgetMessage(
                state = "${remainingPercent}% LEFT",
                speech = pickMessage(
                    seed = messageSeed,
                    "좋아 좋아,\n지금처럼만 가자",
                    "월말이어도 좋아,\n딱 맞게 가는 중!",
                    "딱 좋다!\n무리 없는 흐름이야",
                    "안정권이야.\n오늘도 잘하고 있어",
                    "예산선 위를\n예쁘게 걷는 중",
                    "아주 무난하고 좋다.\n계속 이렇게!",
                    "흐름이 단정해.\n지금 충분히 좋아",
                ),
                characterRes = R.drawable.widget_pixel_alien_smile,
            )
            paceRatio <= 1.12f -> WidgetMessage(
                state = "${remainingPercent}% LEFT",
                speech = pickMessage(
                    seed = messageSeed,
                    "괜찮아,\n조금만 신경 쓰자",
                    "거의 맞는 중!\n조금만 다듬자",
                    "지금부터만\n살짝 조절해보자",
                    "나쁘지 않아.\n이번 주만 단단하게!",
                    "살짝만 정리하면\n더 좋아질 흐름",
                    "큰 문제는 아냐.\n오늘만 가볍게!",
                    "한 템포만 줄이면\n딱 예뻐질 것 같아",
                ),
                characterRes = R.drawable.widget_pixel_alien_neutral,
            )
            paceRatio <= 1.22f && (remainingPercent >= 12 || isEndOfMonth) -> WidgetMessage(
                state = "${remainingPercent}% LEFT",
                speech = pickMessage(
                    seed = messageSeed,
                    "조금 빠르다!\n오늘은 가볍게",
                    "막판이지만 괜찮아.\n조금만 조절하자",
                    "체크 필요!\n작은 소비만 가자",
                    "슬슬 타이트해.\n한 번 아껴보자",
                    "오늘은 쉬운 선택으로\n가볍게 가보자",
                    "지금은 살짝 민감해.\n작게만 쓰자",
                    "한 번만 브레이크.\n내일이 편해져",
                ),
                characterRes = R.drawable.widget_pixel_alien_worried,
            )
            else -> WidgetMessage(
                state = "${remainingPercent}% LEFT",
                speech = pickMessage(
                    seed = messageSeed,
                    "지금은 세이브!\n진짜 필요한 것만",
                    "막판 구간이야.\n오늘은 쉬어가자",
                    "거의 다 왔어,\n조금만 참아보자!",
                    "오늘은 방어전!\n필수 소비만 통과",
                    "지금 구간은 타이트해.\n잠깐 숨 고르자",
                    "이번엔 지키는 턴!\n내 지갑 보호모드",
                ),
                characterRes = R.drawable.widget_pixel_alien_worried,
            )
        }
    }

    private fun pickMessage(seed: Int, vararg messages: String): String {
        val index = seed.mod(messages.size)
        return messages[index]
    }

    private fun layoutForStyle(style: String): Int {
        return when (style) {
            "calendar" -> R.layout.budget_widget_calendar
            "classic" -> R.layout.budget_widget_classic
            "garden" -> R.layout.budget_widget_garden
            "runway" -> R.layout.budget_widget_runway
            else -> R.layout.budget_widget_wave
        }
    }

    protected open fun forcedStyle(): String? = null

    companion object {
        fun updateAll(context: Context) {
            updateProvider(context, BudgetWidgetProvider::class.java)
            updateProvider(context, CalendarBudgetWidgetProvider::class.java)
            updateProvider(context, WaveBudgetWidgetProvider::class.java)
            updateProvider(context, GardenBudgetWidgetProvider::class.java)
            updateProvider(context, RunwayBudgetWidgetProvider::class.java)
        }

        private fun updateProvider(
            context: Context,
            providerClass: Class<out AppWidgetProvider>,
        ) {
            val manager = AppWidgetManager.getInstance(context)
            val component = ComponentName(context, providerClass)
            val ids = manager.getAppWidgetIds(component)
            val provider = providerClass.getDeclaredConstructor().newInstance() as BudgetWidgetProvider
            ids.forEach { provider.update(context, manager, it) }
        }
    }
}

class CalendarBudgetWidgetProvider : BudgetWidgetProvider() {
    override fun forcedStyle(): String = "calendar"
}

class WaveBudgetWidgetProvider : BudgetWidgetProvider() {
    override fun forcedStyle(): String = "wave"
}

class GardenBudgetWidgetProvider : BudgetWidgetProvider() {
    override fun forcedStyle(): String = "garden"
}

class RunwayBudgetWidgetProvider : BudgetWidgetProvider() {
    override fun forcedStyle(): String = "runway"
}

data class WidgetMessage(
    val state: String,
    val speech: String,
    val characterRes: Int,
)
