package kh.mcnc.lib.components

import androidx.compose.foundation.background
import androidx.compose.foundation.border
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.aspectRatio
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.widthIn
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.foundation.text.BasicTextField
import androidx.compose.foundation.text.KeyboardOptions
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.focus.FocusRequester
import androidx.compose.ui.focus.focusRequester
import androidx.compose.ui.focus.onFocusChanged
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.input.key.Key
import androidx.compose.ui.input.key.key
import androidx.compose.ui.input.key.onKeyEvent
import androidx.compose.ui.text.TextStyle
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.input.KeyboardType
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp

@Composable
fun BizOtpInput(
    value: String,
    onValueChange: (String) -> Unit,
    modifier: Modifier = Modifier,
    length: Int = 6,
    onComplete: (String) -> Unit = {}
) {
    val focusRequesters = remember { List(length) { FocusRequester() } }
    
    Row(
        modifier = modifier.fillMaxWidth(),
        horizontalArrangement = Arrangement.spacedBy(8.dp, Alignment.CenterHorizontally),
        verticalAlignment = Alignment.CenterVertically
    ) {
        for (i in 0 until length) {
            val char = value.getOrNull(i)?.toString() ?: ""
            var isFocused by remember { mutableStateOf(false) }
            
            val isFilled = char.isNotBlank()
            val borderColor = if (isFocused) Color(0xFF003399) else if (isFilled) Color(0xFF2954D6) else Color(0xFFE0E0E0)
            val bgColor = if (isFilled) Color(0xFF2954D6) else Color.White
            val textColor = if (isFilled) Color.White else Color(0xFF1A2A5E)
            
            BasicTextField(
                value = char,
                onValueChange = { str ->
                    val digits = str.filter { it.isDigit() }
                    if (digits.length > 1) {
                        val nextValue = (value.take(i) + digits).take(length)
                        onValueChange(nextValue)
                        if (nextValue.length == length) onComplete(nextValue)
                        val nextFocus = (i + digits.length).coerceAtMost(length - 1)
                        focusRequesters[nextFocus].requestFocus()
                    } else if (digits.isNotEmpty()) {
                        val lastChar = digits.last()
                        val builder = StringBuilder(value.padEnd(length, ' ').substring(0, length))
                        builder.setCharAt(i, lastChar)
                        val nextValue = builder.toString().trimEnd()
                        onValueChange(nextValue)
                        if (nextValue.length == length && !nextValue.contains(' ')) {
                            onComplete(nextValue.replace(" ", ""))
                        }
                        if (i < length - 1) {
                            focusRequesters[i + 1].requestFocus()
                        }
                    } else if (str.isEmpty()) {
                        val builder = StringBuilder(value.padEnd(length, ' ').substring(0, length))
                        builder.setCharAt(i, ' ')
                        onValueChange(builder.toString().trimEnd())
                    }
                },
                modifier = Modifier
                    .weight(1f)
                    .widthIn(max = 50.dp)
                    .aspectRatio(1f)
                    .focusRequester(focusRequesters[i])
                    .onFocusChanged { isFocused = it.isFocused }
                    .onKeyEvent { event ->
                        if (event.key == Key.Backspace && char.isBlank() && i > 0) {
                            focusRequesters[i - 1].requestFocus()
                            true
                        } else {
                            false
                        }
                    },
                keyboardOptions = KeyboardOptions(keyboardType = KeyboardType.NumberPassword),
                textStyle = TextStyle(
                    color = textColor,
                    fontSize = 20.sp,
                    fontWeight = FontWeight.Bold,
                    textAlign = TextAlign.Center
                ),
                decorationBox = { innerTextField ->
                    Box(
                        modifier = Modifier
                            .fillMaxSize()
                            .background(bgColor, RoundedCornerShape(12.dp))
                            .border(1.dp, borderColor, RoundedCornerShape(12.dp)),
                        contentAlignment = Alignment.Center
                    ) {
                        innerTextField()
                    }
                }
            )
        }
    }
}
