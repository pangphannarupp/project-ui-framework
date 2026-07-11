package kh.mcnc.lib.components

import androidx.compose.foundation.background
import androidx.compose.foundation.border
import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.fillMaxHeight
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.layout.width
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
import androidx.compose.ui.draw.clip
import androidx.compose.ui.focus.onFocusChanged
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.text.TextStyle
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.input.KeyboardType
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp

@Composable
fun BizNumberSpinner(
    value: Int = 0,
    onValueChange: (Int) -> Unit = {},
    onChange: (Int) -> Unit = {}, // equivalent to 'change' emit
    modifier: Modifier = Modifier,
    min: Int? = null,
    max: Int? = null,
    step: Int = 1,
    disabled: Boolean = false
) {
    var isFocused by remember { mutableStateOf(false) }
    
    val updateValue = { newVal: Int ->
        var res = newVal
        if (min != null && res < min) res = min
        if (max != null && res > max) res = max
        if (res != value) {
            onValueChange(res)
            onChange(res)
        }
    }
    
    val canDecrement = !disabled && (min == null || value > min)
    val canIncrement = !disabled && (max == null || value < max)
    
    val borderColor = if (isFocused) Color(0xFF1A2A5E) else Color(0xFFE0E0E0)
    val bgColor = if (disabled) Color(0xFFF5F5F5) else Color.White
    val textColor = if (disabled) Color(0xFF888888) else Color(0xFF333333)
    val btnColor = if (disabled) Color(0xFFBDBDBD) else Color(0xFF333333)
    
    Row(
        modifier = modifier
            .height(48.dp)
            .background(bgColor, RoundedCornerShape(8.dp))
            .border(1.dp, borderColor, RoundedCornerShape(8.dp))
            .clip(RoundedCornerShape(8.dp)),
        verticalAlignment = Alignment.CenterVertically
    ) {
        Box(
            modifier = Modifier
                .width(48.dp)
                .fillMaxHeight()
                .clickable(enabled = canDecrement) { updateValue(value - step) },
            contentAlignment = Alignment.Center
        ) {
            Box(
                modifier = Modifier
                    .size(width = 14.dp, height = 2.dp)
                    .background(if (canDecrement) btnColor else Color(0xFFBDBDBD))
            )
        }
        
        Box(
            modifier = Modifier
                .width(1.dp)
                .fillMaxHeight()
                .background(Color(0xFFE0E0E0))
        )
        
        BasicTextField(
            value = value.toString(),
            onValueChange = { str ->
                val parsed = str.toIntOrNull()
                if (parsed != null) {
                    updateValue(parsed)
                }
            },
            enabled = !disabled,
            modifier = Modifier
                .width(60.dp)
                .fillMaxHeight()
                .onFocusChanged { isFocused = it.isFocused },
            textStyle = TextStyle(
                color = textColor,
                fontSize = 16.sp,
                fontWeight = FontWeight.SemiBold,
                textAlign = TextAlign.Center
            ),
            keyboardOptions = KeyboardOptions(keyboardType = KeyboardType.Number),
            decorationBox = { innerTextField ->
                Box(contentAlignment = Alignment.Center) {
                    innerTextField()
                }
            }
        )
        
        Box(
            modifier = Modifier
                .width(1.dp)
                .fillMaxHeight()
                .background(Color(0xFFE0E0E0))
        )
        
        Box(
            modifier = Modifier
                .width(48.dp)
                .fillMaxHeight()
                .clickable(enabled = canIncrement) { updateValue(value + step) },
            contentAlignment = Alignment.Center
        ) {
            Box(contentAlignment = Alignment.Center) {
                Box(modifier = Modifier.size(width = 14.dp, height = 2.dp).background(if (canIncrement) btnColor else Color(0xFFBDBDBD)))
                Box(modifier = Modifier.size(width = 2.dp, height = 14.dp).background(if (canIncrement) btnColor else Color(0xFFBDBDBD)))
            }
        }
    }
}
