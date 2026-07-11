package kh.mcnc.lib.ui.components.calendar

import android.content.Context
import android.util.AttributeSet
import androidx.compose.foundation.background
import androidx.compose.foundation.border
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.platform.AbstractComposeView
import androidx.compose.ui.unit.dp
import java.util.Calendar
import java.util.Date
import androidx.lifecycle.setViewTreeLifecycleOwner
import androidx.lifecycle.setViewTreeViewModelStoreOwner
import androidx.savedstate.setViewTreeSavedStateRegistryOwner

/**
 * An XML-friendly wrapper for the AppKhmerCalendar Compose component.
 */
class AppKhmerCalendarView @JvmOverloads constructor(
    context: Context,
    attrs: AttributeSet? = null,
    defStyleAttr: Int = 0
) : AbstractComposeView(context, attrs, defStyleAttr) {

    // Mutable states to trigger Compose recomposition when properties change
    var config by mutableStateOf(CalendarConfig())
    var onDateSelectedListener: ((Date) -> Unit)? = null
    var onRangeSelectedListener: ((Date?, Date?) -> Unit)? = null
    var onMonthChangedListener: ((Int, Int) -> Unit)? = null
    
    var showActionButtons by mutableStateOf(false)
    var onConfirmListener: ((Date?, Date?) -> Unit)? = null
    var onCancelListener: (() -> Unit)? = null

    init {
        if (attrs != null) {
            val typedArray = context.obtainStyledAttributes(attrs, kh.mcnc.lib.R.styleable.AppKhmerCalendarView, 0, 0)
            
            val firstDayOfWeek = typedArray.getInt(kh.mcnc.lib.R.styleable.AppKhmerCalendarView_akc_firstDayOfWeek, Calendar.MONDAY)
            val showAdjacentMonths = typedArray.getBoolean(kh.mcnc.lib.R.styleable.AppKhmerCalendarView_akc_showAdjacentMonths, true)
            
            val selectionModeInt = typedArray.getInt(kh.mcnc.lib.R.styleable.AppKhmerCalendarView_akc_selectionMode, 0)
            val selectionMode = when (selectionModeInt) {
                1 -> SelectionMode.Range
                2 -> SelectionMode.Week
                else -> SelectionMode.Single
            }

            val extraWeeksBefore = typedArray.getInt(kh.mcnc.lib.R.styleable.AppKhmerCalendarView_akc_extraWeeksBefore, 0)
            val extraWeeksAfter = typedArray.getInt(kh.mcnc.lib.R.styleable.AppKhmerCalendarView_akc_extraWeeksAfter, 0)

            config = CalendarConfig(
                firstDayOfWeek = firstDayOfWeek,
                showAdjacentMonths = showAdjacentMonths,
                selectionMode = selectionMode,
                extraWeeksBefore = extraWeeksBefore,
                extraWeeksAfter = extraWeeksAfter
            )

            typedArray.recycle()
        }
    }

    // Helpers for Kotlin usage
    fun setFirstDayOfWeek(day: Int) {
        config = config.copy(firstDayOfWeek = day)
    }

    fun setShowAdjacentMonths(show: Boolean) {
        config = config.copy(showAdjacentMonths = show)
    }

    fun setSelectionMode(mode: SelectionMode) {
        config = config.copy(selectionMode = mode)
    }

    @Composable
    override fun Content() {
        kh.mcnc.lib.ui.theme.AppTheme {
            if (isInEditMode) {
                // In XML layout editor, Compose Pager or complex calendar states might crash LayoutLib.
                // Render a simplified static preview so it appears nicely in Android Studio.
                Box(
                    modifier = Modifier
                        .fillMaxWidth()
                        .height(350.dp)
                        .background(MaterialTheme.colorScheme.surface)
                        .border(
                            1.dp, 
                            MaterialTheme.colorScheme.outlineVariant, 
                            RoundedCornerShape(8.dp)
                        ),
                    contentAlignment = Alignment.Center
                ) {
                    Text(
                        text = "AppKhmerCalendarView (Preview)",
                        color = MaterialTheme.colorScheme.onSurface,
                        style = MaterialTheme.typography.titleMedium
                    )
                }
                return@AppTheme
            }

            AppKhmerCalendar(
                config = config,
                showActionButtons = showActionButtons,
                onDateSelected = { date ->
                    onDateSelectedListener?.invoke(date)
                },
                onRangeSelected = { start, end ->
                    onRangeSelectedListener?.invoke(start, end)
                },
                onMonthChanged = { year, month ->
                    onMonthChangedListener?.invoke(year, month)
                },
                onConfirm = { start, end ->
                    onConfirmListener?.invoke(start, end)
                },
                onCancel = {
                    onCancelListener?.invoke()
                }
            )
        }
    }

    companion object {
        fun showAsDialog(
            context: Context,
            config: CalendarConfig = CalendarConfig(),
            showActionButtons: Boolean = true,
            onDateSelected: ((Date) -> Unit)? = null,
            onRangeSelected: ((Date?, Date?) -> Unit)? = null,
            onMonthChanged: ((Int, Int) -> Unit)? = null,
            onDismiss: (() -> Unit)? = null
        ): androidx.appcompat.app.AlertDialog {
            val view = AppKhmerCalendarView(context).apply {
                this.config = config
                this.showActionButtons = showActionButtons
            }
            
            val container = android.widget.FrameLayout(context).apply {
                val dp = context.resources.displayMetrics.density
                
                // Set rounded white background
                val shape = android.graphics.drawable.GradientDrawable().apply {
                    setColor(android.graphics.Color.WHITE)
                    cornerRadius = 16 * dp
                }
                background = shape
                
                val padding = (16 * dp).toInt()
                setPadding(padding, padding, padding, padding)
                addView(view, android.widget.FrameLayout.LayoutParams(
                    android.view.ViewGroup.LayoutParams.MATCH_PARENT,
                    android.view.ViewGroup.LayoutParams.WRAP_CONTENT
                ))
            }
            
            val dialog = androidx.appcompat.app.AlertDialog.Builder(context)
                .setView(container)
                .setOnDismissListener { onDismiss?.invoke() }
                .create()
                
            var isSelected = false
                
            view.onDateSelectedListener = { date ->
                if (!showActionButtons) {
                    isSelected = true
                    onDateSelected?.invoke(date)
                    dialog.dismiss()
                }
            }
            view.onRangeSelectedListener = { start, end ->
                if (!showActionButtons && start != null && end != null) {
                    isSelected = true
                    onRangeSelected?.invoke(start, end)
                    dialog.dismiss()
                }
            }
            view.onMonthChangedListener = onMonthChanged
            
            view.onConfirmListener = { start, end ->
                isSelected = true
                if (config.selectionMode is SelectionMode.Single) {
                    if (start != null) onDateSelected?.invoke(start)
                } else {
                    onRangeSelected?.invoke(start, end)
                }
                dialog.dismiss()
            }
            view.onCancelListener = {
                dialog.dismiss()
            }

            dialog.show()
            dialog.window?.setBackgroundDrawableResource(android.R.color.transparent)
            
            // Fix ViewTreeLifecycleOwner missing for Compose in Dialog
            val decorView = dialog.window?.decorView
            val activity = context as? androidx.activity.ComponentActivity
            if (decorView != null && activity != null) {
                decorView.setViewTreeLifecycleOwner(activity)
                decorView.setViewTreeViewModelStoreOwner(activity)
                decorView.setViewTreeSavedStateRegistryOwner(activity)
            }
            
            return dialog
        }

        fun showAsBottomSheet(
            context: Context,
            config: CalendarConfig = CalendarConfig(),
            showActionButtons: Boolean = true,
            onDateSelected: ((Date) -> Unit)? = null,
            onRangeSelected: ((Date?, Date?) -> Unit)? = null,
            onMonthChanged: ((Int, Int) -> Unit)? = null,
            onDismiss: (() -> Unit)? = null
        ): com.google.android.material.bottomsheet.BottomSheetDialog {
            val view = AppKhmerCalendarView(context).apply {
                this.config = config
                this.showActionButtons = showActionButtons
            }
            
            val container = android.widget.FrameLayout(context).apply {
                val dp = context.resources.displayMetrics.density
                
                // Set rounded top white background
                val shape = android.graphics.drawable.GradientDrawable().apply {
                    setColor(android.graphics.Color.WHITE)
                    val r = 24 * dp
                    cornerRadii = floatArrayOf(r, r, r, r, 0f, 0f, 0f, 0f)
                }
                background = shape
                
                val padding = (16 * dp).toInt()
                val topPadding = (24 * dp).toInt()
                setPadding(padding, topPadding, padding, padding)
                addView(view, android.widget.FrameLayout.LayoutParams(
                    android.view.ViewGroup.LayoutParams.MATCH_PARENT,
                    android.view.ViewGroup.LayoutParams.WRAP_CONTENT
                ))
            }
            
            val bottomSheet = com.google.android.material.bottomsheet.BottomSheetDialog(context)
            bottomSheet.setContentView(container)
            bottomSheet.behavior.state = com.google.android.material.bottomsheet.BottomSheetBehavior.STATE_EXPANDED
            bottomSheet.behavior.skipCollapsed = true
            bottomSheet.setOnDismissListener { onDismiss?.invoke() }
            
            var isSelected = false
            
            view.onDateSelectedListener = { date ->
                if (!showActionButtons) {
                    isSelected = true
                    onDateSelected?.invoke(date)
                    bottomSheet.dismiss()
                }
            }
            view.onRangeSelectedListener = { start, end ->
                if (!showActionButtons && start != null && end != null) {
                    isSelected = true
                    onRangeSelected?.invoke(start, end)
                    bottomSheet.dismiss()
                }
            }
            view.onMonthChangedListener = onMonthChanged

            view.onConfirmListener = { start, end ->
                isSelected = true
                if (config.selectionMode is SelectionMode.Single) {
                    if (start != null) onDateSelected?.invoke(start)
                } else {
                    onRangeSelected?.invoke(start, end)
                }
                bottomSheet.dismiss()
            }
            view.onCancelListener = {
                bottomSheet.dismiss()
            }

            bottomSheet.show()
            
            // Make default bottom sheet background transparent to show our rounded corners
            bottomSheet.findViewById<android.view.View>(com.google.android.material.R.id.design_bottom_sheet)?.setBackgroundResource(android.R.color.transparent)
            
            // Fix ViewTreeLifecycleOwner missing for Compose in Dialog
            val decorView = bottomSheet.window?.decorView
            val activity = context as? androidx.activity.ComponentActivity
            if (decorView != null && activity != null) {
                decorView.setViewTreeLifecycleOwner(activity)
                decorView.setViewTreeViewModelStoreOwner(activity)
                decorView.setViewTreeSavedStateRegistryOwner(activity)
            }
            
            return bottomSheet
        }
    }
}
