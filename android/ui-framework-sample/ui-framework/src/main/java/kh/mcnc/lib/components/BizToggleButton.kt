package kh.mcnc.lib.components

import androidx.compose.foundation.BorderStroke
import androidx.compose.foundation.layout.PaddingValues
import androidx.compose.foundation.layout.RowScope
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.ButtonDefaults
import androidx.compose.material3.Icon
import androidx.compose.material3.OutlinedButton
import androidx.compose.material3.Text
import androidx.compose.material3.TextButton
import androidx.compose.material3.Button
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.graphics.vector.ImageVector
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp

enum class BizToggleButtonVariant {
    Solid, Outline, Text
}

enum class BizToggleButtonSize {
    Small, Medium, Large
}

@Composable
fun BizToggleButton(
    checked: Boolean,
    onCheckedChange: (Boolean) -> Unit,
    modifier: Modifier = Modifier,
    variant: BizToggleButtonVariant = BizToggleButtonVariant.Outline,
    size: BizToggleButtonSize = BizToggleButtonSize.Medium,
    enabled: Boolean = true,
    icon: ImageVector? = null,
    text: String? = null
) {
    val height = when (size) {
        BizToggleButtonSize.Small -> 32.dp
        BizToggleButtonSize.Medium -> 40.dp
        BizToggleButtonSize.Large -> 48.dp
    }
    val fontSize = when (size) {
        BizToggleButtonSize.Small -> 13.sp
        BizToggleButtonSize.Medium -> 14.sp
        BizToggleButtonSize.Large -> 16.sp
    }
    val iconSize = when (size) {
        BizToggleButtonSize.Small -> 16.dp
        BizToggleButtonSize.Medium -> 20.dp
        BizToggleButtonSize.Large -> 24.dp
    }

    val contentPadding = if (text == null && icon != null) {
        PaddingValues(0.dp) // icon only
    } else {
        when (size) {
            BizToggleButtonSize.Small -> PaddingValues(horizontal = 12.dp)
            BizToggleButtonSize.Medium -> PaddingValues(horizontal = 16.dp)
            BizToggleButtonSize.Large -> PaddingValues(horizontal = 20.dp)
        }
    }

    val finalModifier = if (text == null && icon != null) {
        modifier.size(height) // icon only is square
    } else {
        modifier.height(height)
    }

    val primaryColor = Color(0xFF1A2A5E)
    
    val content: @Composable RowScope.() -> Unit = {
        if (icon != null) {
            Icon(
                imageVector = icon,
                contentDescription = text,
                modifier = Modifier.size(iconSize)
            )
        }
        if (text != null) {
            Text(text = text, fontSize = fontSize)
        }
    }

    when (variant) {
        BizToggleButtonVariant.Solid -> {
            val containerColor = if (checked) primaryColor else Color(0xFFF0F0F0)
            val contentColor = if (checked) Color.White else Color(0xFF555555)
            Button(
                onClick = { onCheckedChange(!checked) },
                modifier = finalModifier,
                enabled = enabled,
                shape = RoundedCornerShape(8.dp),
                colors = ButtonDefaults.buttonColors(
                    containerColor = containerColor,
                    contentColor = contentColor,
                    disabledContainerColor = containerColor.copy(alpha = 0.5f),
                    disabledContentColor = contentColor.copy(alpha = 0.5f)
                ),
                contentPadding = contentPadding,
                content = content
            )
        }
        BizToggleButtonVariant.Outline -> {
            val containerColor = if (checked) primaryColor.copy(alpha = 0.1f) else Color.Transparent
            val contentColor = if (checked) primaryColor else Color(0xFF333333)
            val borderColor = if (checked) primaryColor else Color(0xFFCCCCCC)
            OutlinedButton(
                onClick = { onCheckedChange(!checked) },
                modifier = finalModifier,
                enabled = enabled,
                shape = RoundedCornerShape(8.dp),
                colors = ButtonDefaults.outlinedButtonColors(
                    containerColor = containerColor,
                    contentColor = contentColor,
                    disabledContainerColor = containerColor.copy(alpha = 0.5f),
                    disabledContentColor = contentColor.copy(alpha = 0.5f)
                ),
                border = BorderStroke(1.dp, if (enabled) borderColor else borderColor.copy(alpha = 0.5f)),
                contentPadding = contentPadding,
                content = content
            )
        }
        BizToggleButtonVariant.Text -> {
            val containerColor = if (checked) primaryColor.copy(alpha = 0.1f) else Color.Transparent
            val contentColor = if (checked) primaryColor else Color(0xFF555555)
            TextButton(
                onClick = { onCheckedChange(!checked) },
                modifier = finalModifier,
                enabled = enabled,
                shape = RoundedCornerShape(8.dp),
                colors = ButtonDefaults.textButtonColors(
                    containerColor = containerColor,
                    contentColor = contentColor,
                    disabledContainerColor = containerColor.copy(alpha = 0.5f),
                    disabledContentColor = contentColor.copy(alpha = 0.5f)
                ),
                contentPadding = contentPadding,
                content = content
            )
        }
    }
}
