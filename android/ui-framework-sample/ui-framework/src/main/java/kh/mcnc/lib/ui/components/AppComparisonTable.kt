package kh.mcnc.lib.ui.components

import androidx.compose.foundation.background
import androidx.compose.foundation.horizontalScroll
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.rememberScrollState
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.Check
import androidx.compose.material.icons.filled.Close
import androidx.compose.material3.Divider
import androidx.compose.material3.Icon
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.unit.dp

data class ComparisonPlan(
    val name: String,
    val price: String,
    val isRecommended: Boolean = false,
    val features: List<Any> // Can be Boolean (for check/cross) or String (for text value)
)

@Composable
fun AppComparisonTable(
    featureNames: List<String>,
    plans: List<ComparisonPlan>,
    modifier: Modifier = Modifier
) {
    val scrollState = rememberScrollState()
    val columnWidth = 120.dp
    val featureColumnWidth = 140.dp

    Row(modifier = modifier.fillMaxWidth()) {
        // Sticky Feature Column
        Column(
            modifier = Modifier
                .width(featureColumnWidth)
                .background(MaterialTheme.colorScheme.surface)
        ) {
            // Header spacer for plan names
            Box(
                modifier = Modifier
                    .height(100.dp)
                    .fillMaxWidth()
                    .padding(8.dp),
                contentAlignment = Alignment.BottomStart
            ) {
                Text(
                    text = "Features",
                    style = MaterialTheme.typography.titleMedium,
                    fontWeight = FontWeight.Bold,
                    color = MaterialTheme.colorScheme.onSurfaceVariant
                )
            }
            
            Divider(color = Color.LightGray.copy(alpha = 0.5f))

            featureNames.forEachIndexed { index, feature ->
                Box(
                    modifier = Modifier
                        .height(56.dp)
                        .fillMaxWidth()
                        .background(if (index % 2 == 0) MaterialTheme.colorScheme.surface else MaterialTheme.colorScheme.surfaceVariant.copy(alpha = 0.3f))
                        .padding(horizontal = 8.dp),
                    contentAlignment = Alignment.CenterStart
                ) {
                    Text(
                        text = feature,
                        style = MaterialTheme.typography.bodyMedium,
                        color = MaterialTheme.colorScheme.onSurface,
                        fontWeight = FontWeight.Medium
                    )
                }
                Divider(color = Color.LightGray.copy(alpha = 0.5f))
            }
        }

        // Scrollable Plans
        Row(
            modifier = Modifier
                .horizontalScroll(scrollState)
                .fillMaxWidth()
        ) {
            plans.forEach { plan ->
                Column(
                    modifier = Modifier.width(columnWidth)
                ) {
                    // Plan Header
                    Box(
                        modifier = Modifier
                            .height(100.dp)
                            .fillMaxWidth()
                            .background(
                                if (plan.isRecommended) MaterialTheme.colorScheme.primaryContainer.copy(alpha = 0.3f)
                                else MaterialTheme.colorScheme.surface
                            )
                            .padding(8.dp),
                        contentAlignment = Alignment.Center
                    ) {
                        Column(horizontalAlignment = Alignment.CenterHorizontally) {
                            if (plan.isRecommended) {
                                Box(
                                    modifier = Modifier
                                        .clip(RoundedCornerShape(4.dp))
                                        .background(MaterialTheme.colorScheme.primary)
                                        .padding(horizontal = 6.dp, vertical = 2.dp)
                                ) {
                                    Text(
                                        text = "BEST",
                                        style = MaterialTheme.typography.labelSmall,
                                        color = MaterialTheme.colorScheme.onPrimary,
                                        fontWeight = FontWeight.Bold
                                    )
                                }
                                Spacer(modifier = Modifier.height(4.dp))
                            }
                            
                            Text(
                                text = plan.name,
                                style = MaterialTheme.typography.titleMedium,
                                fontWeight = FontWeight.Bold,
                                color = MaterialTheme.colorScheme.onSurface
                            )
                            Text(
                                text = plan.price,
                                style = MaterialTheme.typography.bodyMedium,
                                color = MaterialTheme.colorScheme.primary
                            )
                        }
                    }
                    
                    Divider(color = Color.LightGray.copy(alpha = 0.5f))

                    // Plan Features
                    plan.features.forEachIndexed { index, featureValue ->
                        Box(
                            modifier = Modifier
                                .height(56.dp)
                                .fillMaxWidth()
                                .background(
                                    when {
                                        plan.isRecommended -> MaterialTheme.colorScheme.primaryContainer.copy(alpha = 0.1f)
                                        index % 2 == 0 -> MaterialTheme.colorScheme.surface
                                        else -> MaterialTheme.colorScheme.surfaceVariant.copy(alpha = 0.3f)
                                    }
                                )
                                .padding(horizontal = 8.dp),
                            contentAlignment = Alignment.Center
                        ) {
                            when (featureValue) {
                                is Boolean -> {
                                    if (featureValue) {
                                        Icon(
                                            imageVector = Icons.Default.Check,
                                            contentDescription = "Included",
                                            tint = MaterialTheme.colorScheme.primary
                                        )
                                    } else {
                                        Icon(
                                            imageVector = Icons.Default.Close,
                                            contentDescription = "Not Included",
                                            tint = Color.LightGray
                                        )
                                    }
                                }
                                is String -> {
                                    Text(
                                        text = featureValue,
                                        style = MaterialTheme.typography.bodyMedium,
                                        color = MaterialTheme.colorScheme.onSurface,
                                        textAlign = TextAlign.Center
                                    )
                                }
                            }
                        }
                        Divider(color = Color.LightGray.copy(alpha = 0.5f))
                    }
                }
            }
        }
    }
}
