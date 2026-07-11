package kh.mcnc.lib.components

import androidx.compose.foundation.background
import androidx.compose.foundation.clickable
import androidx.compose.foundation.isSystemInDarkTheme
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.Divider
import androidx.compose.material3.Surface
import androidx.compose.material3.Text
import androidx.compose.material3.TextButton
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import androidx.compose.ui.window.Dialog
import androidx.compose.ui.window.DialogProperties

@Composable
fun BizTimePickerAlert(
    visible: Boolean,
    onDismissRequest: () -> Unit,
    timeValue: String? = null,
    title: String? = null,
    min: String? = null,
    max: String? = null,
    minuteValues: Any? = null, // String or List<Int>
    hourCycle: String? = null, // 'h12' | 'h23'
    dismissOnOverlayClick: Boolean = true,
    onTimeUpdate: ((String?) -> Unit)? = null,
    onConfirm: ((String?) -> Unit)? = null,
    onCancel: (() -> Unit)? = null
) {
    var internalTime by remember(timeValue) { mutableStateOf(timeValue) }

    if (visible) {
        val isDark = isSystemInDarkTheme()
        val bgColor = if (isDark) Color(0xFF1E1E1E) else Color.White
        val textColor = if (isDark) Color.White else Color(0xFF333333)
        val dividerColor = if (isDark) Color(0xFF333333) else Color(0xFFEEEEEE)
        val cancelColor = Color(0xFF999999)
        val confirmColor = Color(0xFF007AFF)

        Dialog(
            onDismissRequest = {
                if (dismissOnOverlayClick) onDismissRequest()
            },
            properties = DialogProperties(
                dismissOnBackPress = true,
                dismissOnClickOutside = dismissOnOverlayClick,
                usePlatformDefaultWidth = false
            )
        ) {
            Box(
                modifier = Modifier
                    .fillMaxSize()
                    .clickable(
                        enabled = dismissOnOverlayClick,
                        onClick = onDismissRequest
                    )
                    .padding(16.dp),
                contentAlignment = Alignment.Center
            ) {
                Surface(
                    modifier = Modifier
                        .widthIn(max = 340.dp)
                        .fillMaxWidth()
                        .clickable(enabled = false, onClick = {}),
                    shape = RoundedCornerShape(16.dp),
                    color = bgColor,
                    shadowElevation = 12.dp
                ) {
                    Column {
                        if (!title.isNullOrEmpty()) {
                            Box(
                                modifier = Modifier
                                    .fillMaxWidth()
                                    .padding(top = 20.dp, bottom = 10.dp, start = 20.dp, end = 20.dp),
                                contentAlignment = Alignment.Center
                            ) {
                                Text(
                                    text = title,
                                    fontSize = 18.sp,
                                    fontWeight = FontWeight.SemiBold,
                                    color = textColor
                                )
                            }
                        }

                        Box(modifier = Modifier.padding(start = 20.dp, end = 20.dp, top = 10.dp, bottom = 20.dp)) {
                            BizTimePicker(
                                timeValue = internalTime,
                                min = min,
                                max = max,
                                minuteValues = minuteValues,
                                hourCycle = hourCycle,
                                showActionButtons = false,
                                onTimeUpdate = { 
                                    internalTime = it
                                }
                            )
                        }

                        Divider(color = dividerColor, thickness = 1.dp)

                        Row(modifier = Modifier.fillMaxWidth()) {
                            TextButton(
                                onClick = {
                                    onCancel?.invoke()
                                    onDismissRequest()
                                },
                                modifier = Modifier.weight(1f).padding(vertical = 4.dp)
                            ) {
                                Text("Cancel", color = cancelColor, fontSize = 16.sp, fontWeight = FontWeight.SemiBold)
                            }
                            
                            Box(modifier = Modifier.width(1.dp).height(48.dp).background(dividerColor).align(Alignment.CenterVertically))

                            TextButton(
                                onClick = {
                                    onTimeUpdate?.invoke(internalTime)
                                    onConfirm?.invoke(internalTime)
                                    onDismissRequest()
                                },
                                modifier = Modifier.weight(1f).padding(vertical = 4.dp)
                            ) {
                                Text("OK", color = confirmColor, fontSize = 16.sp, fontWeight = FontWeight.SemiBold)
                            }
                        }
                    }
                }
            }
        }
    }
}
