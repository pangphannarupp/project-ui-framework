package kh.mcnc.lib.ui.components.calendar

import android.app.Activity
import android.content.Intent
import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
import kh.mcnc.lib.R

class CalendarSampleActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_calendar_sample)

        val calendarView = findViewById<AppKhmerCalendarView>(R.id.khmerCalendarView)

        calendarView.onMonthChangedListener = { year, month ->
            // No action needed for month change
        }

        calendarView.onDateSelectedListener = { date ->
            val resultIntent = Intent()
            resultIntent.putExtra("result", true)
            resultIntent.putExtra("selectedDate", date.toString())
            resultIntent.putExtra("selectedDateLong", date.time)
            setResult(Activity.RESULT_OK, resultIntent)
            finish()
        }

        calendarView.onRangeSelectedListener = { start, end ->
            val resultIntent = Intent()
            resultIntent.putExtra("result", true)
            if (start != null) {
                resultIntent.putExtra("startDate", start.toString())
                resultIntent.putExtra("startDateLong", start.time)
            }
            if (end != null) {
                resultIntent.putExtra("endDate", end.toString())
                resultIntent.putExtra("endDateLong", end.time)
            }
            setResult(Activity.RESULT_OK, resultIntent)
            finish()
        }
    }
}
