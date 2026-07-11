package kh.mcnc.lib.components

import androidx.compose.foundation.Canvas
import androidx.compose.foundation.background
import androidx.compose.foundation.clickable
import androidx.compose.foundation.interaction.MutableInteractionSource
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.Text
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.draw.shadow
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.graphics.Path
import androidx.compose.ui.graphics.StrokeCap
import androidx.compose.ui.graphics.StrokeJoin
import androidx.compose.ui.graphics.drawscope.Stroke
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp

@Composable
fun BizKhmerKeyboard(
    modifier: Modifier = Modifier,
    onPress: (String) -> Unit
) {
    var isShifted by remember { mutableStateOf(false) }
    var showSymbols by remember { mutableStateOf(false) }

    var shieldPositions by remember { mutableStateOf(listOf(0, 0, 0, 0)) }

    val randomizeKeys = {
        shieldPositions = listOf(
            (0..10).random(),
            (0..10).random(),
            (0..9).random(),
            (0..7).random()
        )
    }

    LaunchedEffect(Unit) {
        randomizeKeys()
    }

    val khmerRow0 = listOf("១","២","៣","៤","៥","៦","៧","៨","៩","០")
    val khmerRow0Shift = listOf("!","@","#","$","%","^","&","*","(",")")

    val khmerDefaultLetters = listOf("ឆ","វ","េ","រ","ត","យ","ុ","ិ","ោ","ផ","ា","ស","ឌ","ថ","ង","ហ","្","ក","ល","ឋ","ខ","ច","វ","ប","ន","ម")
    val khmerShiftedLetters = listOf("ឈ","ឺ","ែ","ឫ","ទ","យ","ូ","ី","ៅ","ភ","ាំ","ស្ស","ធ","ញ","ង","ះ","្រ","គ","ឡ","ឍ","ឃ","ជ","ឈ","ព","ណ","ំ")

    val defaultSymbols = listOf("!","@","#","$","%","^","&","*","(",")","-","+","_","=","{","}","[","]",":",";","\"","'","<",">","?","/")

    val randomizedNumbers = remember(shieldPositions, isShifted) {
        val nums = if (isShifted) khmerRow0Shift.toMutableList() else khmerRow0.toMutableList()
        nums.add(shieldPositions[0], "shield")
        nums
    }

    val row1Keys = remember(shieldPositions, showSymbols, isShifted) {
        val source = if (showSymbols) defaultSymbols else if (isShifted) khmerShiftedLetters else khmerDefaultLetters
        val keys = source.take(10).toMutableList()
        keys.add(shieldPositions[1], "shield")
        keys
    }

    val row2Keys = remember(shieldPositions, showSymbols, isShifted) {
        val source = if (showSymbols) defaultSymbols else if (isShifted) khmerShiftedLetters else khmerDefaultLetters
        val keys = source.drop(10).take(9).toMutableList()
        keys.add(shieldPositions[2], "shield")
        keys
    }

    val row3Keys = remember(shieldPositions, showSymbols, isShifted) {
        val source = if (showSymbols) defaultSymbols else if (isShifted) khmerShiftedLetters else khmerDefaultLetters
        val keys = source.drop(19).take(7).toMutableList()
        keys.add(shieldPositions[3], "shield")
        keys
    }

    Column(
        modifier = modifier
            .fillMaxWidth()
            .background(Color(0xFF1A1B1E))
            .padding(top = 8.dp, start = 4.dp, end = 4.dp, bottom = 24.dp)
    ) {
        // Row 1
        Row(
            modifier = Modifier.fillMaxWidth().padding(bottom = 8.dp),
            horizontalArrangement = Arrangement.spacedBy(6.dp, Alignment.CenterHorizontally)
        ) {
            randomizedNumbers.forEach { item ->
                if (item == "shield") {
                    KhmerShieldKeyboardIndicator()
                } else {
                    KhmerKeyboardCharKey(
                        char = item,
                        onClick = { onPress(item) }
                    )
                }
            }
        }

        // Row 2
        Row(
            modifier = Modifier.fillMaxWidth().padding(bottom = 8.dp),
            horizontalArrangement = Arrangement.spacedBy(6.dp, Alignment.CenterHorizontally)
        ) {
            row1Keys.forEach { item ->
                if (item == "shield") {
                    KhmerShieldKeyboardIndicator()
                } else {
                    KhmerKeyboardCharKey(
                        char = item,
                        onClick = { onPress(item) }
                    )
                }
            }
        }

        // Row 3
        Row(
            modifier = Modifier.fillMaxWidth().padding(bottom = 8.dp, start = 16.dp, end = 16.dp),
            horizontalArrangement = Arrangement.spacedBy(6.dp, Alignment.CenterHorizontally)
        ) {
            row2Keys.forEach { item ->
                if (item == "shield") {
                    KhmerShieldKeyboardIndicator()
                } else {
                    KhmerKeyboardCharKey(
                        char = item,
                        onClick = { onPress(item) }
                    )
                }
            }
        }

        // Row 4
        Row(
            modifier = Modifier.fillMaxWidth().padding(bottom = 8.dp),
            horizontalArrangement = Arrangement.spacedBy(6.dp, Alignment.CenterHorizontally)
        ) {
            KhmerKeyboardFuncKey(
                content = { ShiftIconCanvas(isShifted = isShifted) },
                onClick = { 
                    isShifted = !isShifted
                    if (showSymbols) showSymbols = false
                }
            )

            row3Keys.forEach { item ->
                if (item == "shield") {
                    KhmerShieldKeyboardIndicator()
                } else {
                    KhmerKeyboardCharKey(
                        char = item,
                        onClick = { onPress(item) }
                    )
                }
            }

            KhmerKeyboardFuncKey(
                content = { BackspaceIconCanvas(tint = Color.White) },
                onClick = { onPress("backspace") }
            )
        }

        // Row 5
        Row(
            modifier = Modifier.fillMaxWidth(),
            horizontalArrangement = Arrangement.spacedBy(6.dp, Alignment.CenterHorizontally)
        ) {
            KhmerKeyboardFuncKey(
                modifier = Modifier.weight(1.5f),
                text = if (showSymbols) "ABC" else "$%?",
                onClick = {
                    showSymbols = !showSymbols
                    if (showSymbols) isShifted = false
                }
            )

            KhmerKeyboardFuncKey(
                modifier = Modifier.weight(1.5f),
                text = "😊",
                onClick = { onPress("emoji") }
            )

            // Space
            Box(
                modifier = Modifier
                    .weight(5f)
                    .height(48.dp)
                    .clip(RoundedCornerShape(8.dp))
                    .background(Color(0xFF2C2D31))
                    .clickable { onPress(" ") }
            )

            KhmerKeyboardFuncKey(
                modifier = Modifier.weight(1.5f),
                text = ".",
                onClick = { onPress(".") }
            )

            KhmerKeyboardFuncKey(
                modifier = Modifier.weight(1.5f),
                content = { EnterIconCanvas() },
                onClick = { onPress("enter") }
            )
        }
    }
}

@Composable
private fun KhmerKeyboardCharKey(
    modifier: Modifier = Modifier,
    char: String,
    onClick: () -> Unit
) {
    Box(
        modifier = modifier
            .widthIn(max = 40.dp)
            .height(48.dp)
            .shadow(1.dp, RoundedCornerShape(8.dp), spotColor = Color.Black.copy(alpha = 0.2f))
            .clip(RoundedCornerShape(8.dp))
            .background(Color(0xFF2C2D31))
            .clickable(onClick = onClick)
            .then(Modifier.wrapContentWidth()),
        contentAlignment = Alignment.Center
    ) {
        Text(
            text = char,
            fontSize = 20.sp,
            fontWeight = FontWeight.Medium,
            color = Color.White,
            modifier = Modifier.padding(horizontal = 8.dp)
        )
    }
}

@Composable
private fun KhmerKeyboardFuncKey(
    modifier: Modifier = Modifier,
    text: String? = null,
    content: (@Composable () -> Unit)? = null,
    onClick: () -> Unit
) {
    Box(
        modifier = modifier
            .widthIn(max = 50.dp)
            .height(48.dp)
            .clip(RoundedCornerShape(8.dp))
            .background(Color(0xFF202124))
            .clickable(onClick = onClick)
            .then(Modifier.wrapContentWidth()),
        contentAlignment = Alignment.Center
    ) {
        if (text != null) {
            Text(
                text = text,
                fontSize = 14.sp,
                fontWeight = FontWeight.SemiBold,
                color = Color(0xFFAEB0B4),
                modifier = Modifier.padding(horizontal = 8.dp)
            )
        } else if (content != null) {
            content()
        }
    }
}

@Composable
private fun KhmerShieldKeyboardIndicator(modifier: Modifier = Modifier) {
    Box(
        modifier = modifier
            .widthIn(max = 40.dp)
            .height(48.dp),
        contentAlignment = Alignment.Center
    ) {
        Canvas(modifier = Modifier.size(20.dp)) {
            val w = size.width
            val h = size.height
            val path = Path().apply {
                moveTo(w * 0.5f, h * 0.1f)
                lineTo(w * 0.9f, h * 0.25f)
                lineTo(w * 0.9f, h * 0.6f)
                cubicTo(w * 0.9f, h * 0.8f, w * 0.5f, h * 0.9f, w * 0.5f, h * 0.9f)
                cubicTo(w * 0.5f, h * 0.9f, w * 0.1f, h * 0.8f, w * 0.1f, h * 0.6f)
                lineTo(w * 0.1f, h * 0.25f)
                close()
            }
            drawPath(
                path = path,
                color = Color(0xFF5F6368),
                style = Stroke(width = 1.5f.dp.toPx(), join = StrokeJoin.Round)
            )
        }
    }
}
