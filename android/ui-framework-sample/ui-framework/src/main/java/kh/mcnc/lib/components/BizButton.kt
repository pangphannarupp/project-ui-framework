package kh.mcnc.lib.components

import androidx.compose.foundation.BorderStroke
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.*
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp

enum class BizButtonVariant {
    Primary, Secondary, Outline, Ghost, OutlineDanger
}

@Composable
fun BizButton(
    text: String,
    modifier: Modifier = Modifier,
    variant: BizButtonVariant = BizButtonVariant.Primary,
    block: Boolean = false,
    enabled: Boolean = true,
    iconLeft: @Composable (() -> Unit)? = null,
    iconRight: @Composable (() -> Unit)? = null,
    onClick: () -> Unit
) {
    val containerColor = when (variant) {
        BizButtonVariant.Primary -> Color(0xFF1A2A5E)
        BizButtonVariant.Secondary -> Color(0xFFE0E0E0)
        BizButtonVariant.Outline, BizButtonVariant.OutlineDanger, BizButtonVariant.Ghost -> Color.Transparent
    }

    val contentColor = when (variant) {
        BizButtonVariant.Primary -> Color.White
        BizButtonVariant.Secondary -> Color(0xFF333333)
        BizButtonVariant.Outline -> Color(0xFF3B63CC)
        BizButtonVariant.OutlineDanger -> Color(0xFFD32F2F)
        BizButtonVariant.Ghost -> Color(0xFF0066CC)
    }

    val border = when (variant) {
        BizButtonVariant.Outline -> BorderStroke(1.dp, Color(0xFFCCCCCC))
        BizButtonVariant.OutlineDanger -> BorderStroke(1.dp, Color(0xFFD32F2F))
        else -> null
    }

    val buttonModifier = if (block) modifier.fillMaxWidth() else modifier

    Button(
        onClick = onClick,
        enabled = enabled,
        modifier = buttonModifier.defaultMinSize(minHeight = 56.dp),
        shape = RoundedCornerShape(12.dp),
        colors = ButtonDefaults.buttonColors(
            containerColor = containerColor,
            contentColor = contentColor,
            disabledContainerColor = Color(0xFFC0C0C0),
            disabledContentColor = Color.White
        ),
        border = border,
        elevation = if (variant == BizButtonVariant.Ghost) null else ButtonDefaults.buttonElevation(0.dp, 0.dp)
    ) {
        if (iconLeft != null) {
            iconLeft()
            Spacer(modifier = Modifier.width(8.dp))
        }
        Text(
            text = text,
            fontSize = 16.sp,
            fontWeight = FontWeight.SemiBold
        )
        if (iconRight != null) {
            Spacer(modifier = Modifier.width(8.dp))
            iconRight()
        }
    }
}
