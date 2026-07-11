package kh.mcnc.lib.components

import androidx.compose.foundation.background
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.offset
import androidx.compose.runtime.Composable
import androidx.compose.runtime.mutableFloatStateOf
import androidx.compose.runtime.remember
import androidx.compose.ui.Modifier
import androidx.compose.ui.geometry.Offset
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.input.nestedscroll.NestedScrollConnection
import androidx.compose.ui.input.nestedscroll.NestedScrollSource
import androidx.compose.ui.input.nestedscroll.nestedScroll
import androidx.compose.ui.platform.LocalDensity
import androidx.compose.ui.unit.Dp
import androidx.compose.ui.unit.IntOffset
import androidx.compose.ui.unit.dp
import androidx.compose.ui.zIndex
import kotlin.math.roundToInt

@Composable
fun BizHideAppBar(
    headerHeight: Dp = 56.dp,
    header: @Composable () -> Unit,
    content: @Composable () -> Unit
) {
    val headerHeightPx = with(LocalDensity.current) { headerHeight.toPx() }
    val headerOffsetHeightPx = remember { mutableFloatStateOf(0f) }

    val nestedScrollConnection = remember {
        object : NestedScrollConnection {
            override fun onPreScroll(available: Offset, source: NestedScrollSource): Offset {
                val delta = available.y
                if (delta > 0) { // Scrolling UP
                    headerOffsetHeightPx.value = (headerOffsetHeightPx.value + delta).coerceAtMost(0f)
                } else { // Scrolling DOWN
                    headerOffsetHeightPx.value = (headerOffsetHeightPx.value + delta).coerceAtLeast(-headerHeightPx)
                }
                // We don't consume the scroll, just observe
                return Offset.Zero
            }
        }
    }

    Box(
        modifier = Modifier
            .fillMaxSize()
            .background(Color(0xFFF4F5F8))
            .nestedScroll(nestedScrollConnection)
    ) {
        Box(
            modifier = Modifier.fillMaxSize()
        ) {
            content()
        }

        Box(
            modifier = Modifier
                .fillMaxWidth()
                .height(headerHeight)
                .offset { IntOffset(x = 0, y = headerOffsetHeightPx.value.roundToInt()) }
                .zIndex(10f)
                .background(Color.White)
        ) {
            header()
        }
    }
}
