package kh.mcnc.lib.ui.components

import androidx.compose.foundation.background
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.foundation.text.BasicTextField
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.FormatBold
import androidx.compose.material.icons.filled.FormatItalic
import androidx.compose.material.icons.filled.FormatListBulleted
import androidx.compose.material.icons.filled.FormatUnderlined
import androidx.compose.material3.Divider
import androidx.compose.material3.Icon
import androidx.compose.material3.IconButton
import androidx.compose.material3.IconToggleButton
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Surface
import androidx.compose.material3.Text
import androidx.compose.runtime.*
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.graphics.SolidColor
import androidx.compose.ui.text.TextStyle
import androidx.compose.ui.text.font.FontStyle
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.style.TextDecoration
import androidx.compose.ui.unit.dp

@Composable
fun AppRichTextEditor(
    modifier: Modifier = Modifier
) {
    var text by remember { mutableStateOf("Take notes on this application here...\n\n- Good credit history\n- Employed for 5 years") }
    
    var isBold by remember { mutableStateOf(false) }
    var isItalic by remember { mutableStateOf(false) }
    var isUnderline by remember { mutableStateOf(false) }

    Surface(
        modifier = modifier.fillMaxWidth(),
        shape = RoundedCornerShape(8.dp),
        color = MaterialTheme.colorScheme.surface,
        shadowElevation = 2.dp
    ) {
        Column {
            // Toolbar
            Row(
                modifier = Modifier
                    .fillMaxWidth()
                    .background(MaterialTheme.colorScheme.surfaceVariant.copy(alpha = 0.5f))
                    .padding(4.dp),
                horizontalArrangement = Arrangement.Start
            ) {
                IconToggleButton(checked = isBold, onCheckedChange = { isBold = it }) {
                    Icon(
                        imageVector = Icons.Default.FormatBold,
                        contentDescription = "Bold",
                        tint = if (isBold) MaterialTheme.colorScheme.primary else MaterialTheme.colorScheme.onSurfaceVariant
                    )
                }
                IconToggleButton(checked = isItalic, onCheckedChange = { isItalic = it }) {
                    Icon(
                        imageVector = Icons.Default.FormatItalic,
                        contentDescription = "Italic",
                        tint = if (isItalic) MaterialTheme.colorScheme.primary else MaterialTheme.colorScheme.onSurfaceVariant
                    )
                }
                IconToggleButton(checked = isUnderline, onCheckedChange = { isUnderline = it }) {
                    Icon(
                        imageVector = Icons.Default.FormatUnderlined,
                        contentDescription = "Underline",
                        tint = if (isUnderline) MaterialTheme.colorScheme.primary else MaterialTheme.colorScheme.onSurfaceVariant
                    )
                }
                IconButton(onClick = { /* add list logic */ }) {
                    Icon(
                        imageVector = Icons.Default.FormatListBulleted,
                        contentDescription = "Bullet List",
                        tint = MaterialTheme.colorScheme.onSurfaceVariant
                    )
                }
            }
            
            Divider(color = Color.LightGray.copy(alpha = 0.5f))
            
            // Text Area
            Box(
                modifier = Modifier
                    .fillMaxWidth()
                    .height(200.dp)
                    .padding(16.dp)
            ) {
                BasicTextField(
                    value = text,
                    onValueChange = { text = it },
                    modifier = Modifier.fillMaxSize(),
                    textStyle = TextStyle(
                        color = MaterialTheme.colorScheme.onSurface,
                        fontWeight = if (isBold) FontWeight.Bold else FontWeight.Normal,
                        fontStyle = if (isItalic) FontStyle.Italic else FontStyle.Normal,
                        textDecoration = if (isUnderline) TextDecoration.Underline else TextDecoration.None
                    ),
                    cursorBrush = SolidColor(MaterialTheme.colorScheme.primary)
                )
                
                if (text.isEmpty()) {
                    Text(
                        text = "Type here...",
                        color = MaterialTheme.colorScheme.onSurfaceVariant.copy(alpha = 0.6f)
                    )
                }
            }
        }
    }
}
