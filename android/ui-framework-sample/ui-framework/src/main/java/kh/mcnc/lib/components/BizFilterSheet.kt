package kh.mcnc.lib.components

import androidx.compose.foundation.BorderStroke
import androidx.compose.foundation.background
import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.Surface
import androidx.compose.material3.Text
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp

@OptIn(ExperimentalLayoutApi::class)
@Composable
fun BizFilterSheet(
    isVisible: Boolean,
    selectedFacilities: List<String>,
    onDismissRequest: () -> Unit,
    onApply: (List<String>) -> Unit
) {
    val facilities = listOf("Korea Desk", "Japan Desk", "China Desk", "SME Center", "Coffee")
    var currentSelection by remember { mutableStateOf(selectedFacilities) }

    LaunchedEffect(isVisible) {
        if (isVisible) {
            currentSelection = selectedFacilities.toList()
        }
    }

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
                text = "Filter",
                fontSize = 20.sp,
                fontWeight = FontWeight.Bold,
                color = Color(0xFF1A2A5E),
                modifier = Modifier.padding(bottom = 8.dp)
            )
            Text(
                text = "Search branch you wish to visit faster.",
                fontSize = 14.sp,
                color = Color(0xFF555555),
                modifier = Modifier.padding(bottom = 24.dp)
            )

            Text(
                text = "BRANCH FACILITY",
                fontSize = 12.sp,
                fontWeight = FontWeight.Bold,
                color = Color(0xFF1A2A5E),
                letterSpacing = 0.5.sp,
                modifier = Modifier.padding(bottom = 16.dp)
            )

            FlowRow(
                modifier = Modifier.padding(bottom = 32.dp),
                horizontalArrangement = Arrangement.spacedBy(12.dp),
                verticalArrangement = Arrangement.spacedBy(12.dp)
            ) {
                facilities.forEach { facility ->
                    val isActive = currentSelection.contains(facility)
                    Surface(
                        shape = RoundedCornerShape(20.dp),
                        color = if (isActive) Color(0xFF1A2A5E) else Color.White,
                        border = BorderStroke(1.dp, if (isActive) Color(0xFF1A2A5E) else Color(0xFFEAEAEA)),
                        modifier = Modifier.clickable {
                            currentSelection = if (isActive) {
                                currentSelection - facility
                            } else {
                                currentSelection + facility
                            }
                        }
                    ) {
                        Text(
                            text = facility,
                            color = if (isActive) Color.White else Color(0xFF111111),
                            fontSize = 13.sp,
                            fontWeight = FontWeight.SemiBold,
                            modifier = Modifier.padding(horizontal = 16.dp, vertical = 10.dp)
                        )
                    }
                }
            }

            Spacer(modifier = Modifier.weight(1f, fill = false))

            Column(
                modifier = Modifier.fillMaxWidth(),
                verticalArrangement = Arrangement.spacedBy(12.dp)
            ) {
                BizButton(
                    text = "Apply",
                    variant = BizButtonVariant.Primary,
                    block = true,
                    onClick = {
                        onApply(currentSelection)
                        onDismissRequest()
                    }
                )
                Surface(
                    shape = RoundedCornerShape(12.dp),
                    color = Color.White,
                    border = BorderStroke(1.dp, Color(0xFFEAEAEA)),
                    modifier = Modifier
                        .fillMaxWidth()
                        .clickable { onDismissRequest() }
                ) {
                    Box(
                        modifier = Modifier.padding(14.dp),
                        contentAlignment = Alignment.Center
                    ) {
                        Text(
                            text = "Close",
                            color = Color(0xFF1A2A5E),
                            fontSize = 15.sp,
                            fontWeight = FontWeight.SemiBold
                        )
                    }
                }
            }
        }
    }
}
