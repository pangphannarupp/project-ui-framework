package kh.mcnc.lib.components

import androidx.compose.foundation.BorderStroke
import androidx.compose.foundation.background
import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.Surface
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.delay
import kotlinx.coroutines.launch

@Composable
fun BizSortSheet(
    isVisible: Boolean,
    selectedSort: String,
    onDismissRequest: () -> Unit,
    onChange: (String) -> Unit
) {
    val options = listOf(
        "distance" to "By Distance",
        "name" to "By Name"
    )

    BizBottomSheet(
        isVisible = isVisible,
        onDismissRequest = onDismissRequest
    ) {
        Column(
            modifier = Modifier
                .fillMaxWidth()
                .padding(horizontal = 24.dp)
                .padding(bottom = 32.dp)
        ) {
            Text(
                text = "Sort",
                fontSize = 20.sp,
                fontWeight = FontWeight.Bold,
                color = Color(0xFF1A2A5E),
                modifier = Modifier.padding(bottom = 8.dp)
            )
            Text(
                text = "More convenient to locate the branch you wish to visit.",
                fontSize = 14.sp,
                color = Color(0xFF555555),
                modifier = Modifier.padding(bottom = 24.dp)
            )

            Column(
                modifier = Modifier.fillMaxWidth(),
                verticalArrangement = Arrangement.spacedBy(16.dp)
            ) {
                options.forEach { (value, label) ->
                    val isActive = selectedSort == value
                    Surface(
                        shape = RoundedCornerShape(12.dp),
                        color = Color.White,
                        border = BorderStroke(
                            width = if (isActive) 2.dp else 1.dp,
                            color = if (isActive) Color(0xFF1A2A5E) else Color(0xFFEAEAEA)
                        ),
                        modifier = Modifier
                            .fillMaxWidth()
                            .clickable {
                                onChange(value)
                                CoroutineScope(Dispatchers.Main).launch {
                                    delay(200)
                                    onDismissRequest()
                                }
                            }
                    ) {
                        Row(
                            modifier = Modifier
                                .fillMaxWidth()
                                .padding(horizontal = 20.dp, vertical = if (isActive) 15.dp else 16.dp),
                            horizontalArrangement = Arrangement.SpaceBetween,
                            verticalAlignment = Alignment.CenterVertically
                        ) {
                            Text(
                                text = label,
                                fontSize = 15.sp,
                                color = Color(0xFF111111),
                                fontWeight = if (isActive) FontWeight.Bold else FontWeight.Normal
                            )

                            Box(
                                modifier = Modifier
                                    .size(22.dp)
                                    .background(Color.Transparent, CircleShape)
                                    .padding(if (isActive) 0.dp else 0.5.dp), // Adjust for border width visually
                                contentAlignment = Alignment.Center
                            ) {
                                Surface(
                                    modifier = Modifier.fillMaxSize(),
                                    shape = CircleShape,
                                    color = Color.Transparent,
                                    border = BorderStroke(
                                        width = if (isActive) 2.5.dp else 1.5.dp,
                                        color = if (isActive) Color(0xFF1A2A5E) else Color(0xFFEAEAEA)
                                    )
                                ) {}
                                if (isActive) {
                                    Box(
                                        modifier = Modifier
                                            .size(10.dp)
                                            .background(Color(0xFF1A2A5E), CircleShape)
                                    )
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
