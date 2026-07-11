package kh.mcnc.lib.components

import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier

@Composable
fun BizButtonGroup(
    modifier: Modifier = Modifier,
    vertical: Boolean = false,
    content: @Composable () -> Unit
) {
    if (vertical) {
        Column(modifier = modifier) {
            content()
        }
    } else {
        Row(modifier = modifier) {
            content()
        }
    }
}
