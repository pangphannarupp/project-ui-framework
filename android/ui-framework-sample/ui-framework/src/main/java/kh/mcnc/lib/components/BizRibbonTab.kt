package kh.mcnc.lib.components

import androidx.compose.foundation.background
import androidx.compose.foundation.border
import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp

/**
 * BizRibbonTab - Jetpack Compose component matching Web UI-Framework `PPRibbonTab.vue`.
 */
@Composable
fun BizRibbonTab(
    modifier: Modifier = Modifier,
    title: String = "",
    color: String = "",
    id: String = "",
    onClick: () -> Unit = {},
    content: @Composable (() -> Unit)? = null
) {
    val primaryNavy = Color(0xFF1A2A5E)
    val primaryBlue = Color(0xFF003399)
    val secondaryBg = Color(0xFFF1F5F9)
    val borderColor = Color(0xFFCBD5E1)

    Box(
        modifier = modifier
            .fillMaxWidth()
            .defaultMinSize(minHeight = 44.dp)
            .background(Color.White, shape = RoundedCornerShape(12.dp))
            .border(1.dp, borderColor, shape = RoundedCornerShape(12.dp))
            .padding(16.dp)
            .clickable(onClick = onClick),
        contentAlignment = Alignment.CenterStart
    ) {
        Row(
            verticalAlignment = Alignment.CenterVertically,
            horizontalArrangement = Arrangement.SpaceBetween,
            modifier = Modifier.fillMaxWidth()
        ) {
            Column(modifier = Modifier.weight(1f)) {
                Text(
                    text = "RibbonTab",
                    fontSize = 16.sp,
                    fontWeight = FontWeight.SemiBold,
                    color = primaryNavy
                )
                if (content != null) {
                    Spacer(modifier = Modifier.height(8.dp))
                    content()
                }
            }
        }
    }
}

/**
 * Web UI-Framework parity alias for [BizRibbonTab].
 */
@Composable
fun PPRibbonTab(
    modifier: Modifier = Modifier,
    title: String = "",
    color: String = "",
    id: String = "",
    onClick: () -> Unit = {},
    content: @Composable (() -> Unit)? = null
) = BizRibbonTab(
        modifier = modifier,
        title = title,
        color = color,
        id = id,
        onClick = onClick,
        content = content
)
