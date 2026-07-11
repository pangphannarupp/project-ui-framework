package kh.mcnc.lib.components

import androidx.compose.foundation.background
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.fillMaxHeight
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.width
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.graphics.RectangleShape
import androidx.compose.ui.unit.Dp
import androidx.compose.ui.unit.dp

enum class BizSkeletonVariant {
    Text, Rect, Circle, Image
}

@Composable
fun BizSkeletonItem(
    modifier: Modifier = Modifier,
    variant: BizSkeletonVariant = BizSkeletonVariant.Text,
    width: Dp? = null,
    height: Dp? = null
) {
    val bgColor = Color(0xFFF0F0F0)

    var currentModifier = modifier

    currentModifier = when (variant) {
        BizSkeletonVariant.Text -> {
            currentModifier
                .then(if (width != null) Modifier.width(width) else Modifier.fillMaxWidth())
                .then(if (height != null) Modifier.height(height) else Modifier.height(16.dp))
                .background(bgColor, RoundedCornerShape(4.dp))
        }
        BizSkeletonVariant.Rect -> {
            currentModifier
                .then(if (width != null) Modifier.width(width) else Modifier.fillMaxWidth())
                .then(if (height != null) Modifier.height(height) else Modifier.fillMaxHeight())
                .background(bgColor, RoundedCornerShape(8.dp))
        }
        BizSkeletonVariant.Circle -> {
            currentModifier
                .then(if (width != null) Modifier.width(width) else Modifier.width(48.dp))
                .then(if (height != null) Modifier.height(height) else Modifier.height(48.dp))
                .background(bgColor, CircleShape)
        }
        BizSkeletonVariant.Image -> {
            currentModifier
                .then(if (width != null) Modifier.width(width) else Modifier.fillMaxWidth())
                .then(if (height != null) Modifier.height(height) else Modifier.height(200.dp))
                .background(bgColor, RectangleShape)
        }
    }

    Box(modifier = currentModifier)
}
