package kh.mcnc.lib.components

import androidx.compose.foundation.background
import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.material3.LocalContentColor
import androidx.compose.runtime.Composable
import androidx.compose.runtime.CompositionLocalProvider
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.draw.shadow
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.semantics.Role
import androidx.compose.ui.unit.dp

enum class BizFabActionColor {
    Primary, Secondary, Danger, Light
}

@Composable
fun BizFabAction(
    onClick: () -> Unit,
    modifier: Modifier = Modifier,
    color: BizFabActionColor = BizFabActionColor.Light,
    content: @Composable () -> Unit
) {
    val (bgColor, contentColor) = when (color) {
        BizFabActionColor.Primary -> Color(0xFF1A2A5E) to Color.White
        BizFabActionColor.Secondary -> Color(0xFFE0E0E0) to Color(0xFF333333)
        BizFabActionColor.Danger -> Color(0xFFD32F2F) to Color.White
        BizFabActionColor.Light -> Color.White to Color(0xFF333333)
    }

    Box(
        modifier = modifier
            .size(40.dp)
            .shadow(elevation = 2.dp, shape = CircleShape)
            .clip(CircleShape)
            .background(bgColor)
            .clickable(
                role = Role.Button,
                onClick = onClick
            ),
        contentAlignment = Alignment.Center
    ) {
        CompositionLocalProvider(LocalContentColor provides contentColor) {
            content()
        }
    }
}
