package kh.mcnc.lib.components

import androidx.compose.foundation.background
import androidx.compose.foundation.border
import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.items
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.Checkbox
import androidx.compose.material3.Icon
import androidx.compose.material3.Text
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.alpha
import androidx.compose.ui.draw.clip
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.graphics.vector.ImageVector
import androidx.compose.ui.graphics.vector.PathBuilder
import androidx.compose.ui.graphics.vector.path
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp

data class TransferOption(
    val key: String,
    val label: String,
    val disabled: Boolean = false
)

enum class BizTransferVariant {
    Outlined, Filled, Underlined
}

@Composable
fun BizTransferList(
    data: List<TransferOption>,
    targetKeys: List<String>,
    onTargetKeysChange: (List<String>) -> Unit,
    modifier: Modifier = Modifier,
    titles: Pair<String, String> = "Source" to "Target",
    variant: BizTransferVariant = BizTransferVariant.Outlined,
    disabled: Boolean = false
) {
    var leftChecked by remember { mutableStateOf(setOf<String>()) }
    var rightChecked by remember { mutableStateOf(setOf<String>()) }

    val leftData = data.filter { it.key !in targetKeys }
    val rightData = data.filter { it.key in targetKeys }

    fun moveToRight() {
        val newTarget = targetKeys + leftChecked
        onTargetKeysChange(newTarget)
        leftChecked = emptySet()
    }

    fun moveToLeft() {
        val newTarget = targetKeys.filter { it !in rightChecked }
        onTargetKeysChange(newTarget)
        rightChecked = emptySet()
    }

    Row(
        modifier = modifier
            .fillMaxWidth()
            .height(250.dp)
            .let { if (disabled) it.alpha(0.6f) else it },
        horizontalArrangement = Arrangement.spacedBy(16.dp),
        verticalAlignment = Alignment.CenterVertically
    ) {
        // Left Panel
        TransferPanel(
            title = titles.first,
            data = leftData,
            checkedKeys = leftChecked,
            onCheckedKeysChange = { leftChecked = it },
            variant = variant,
            disabled = disabled,
            modifier = Modifier.weight(1f).fillMaxHeight()
        )

        // Actions
        Column(
            verticalArrangement = Arrangement.spacedBy(12.dp),
            horizontalAlignment = Alignment.CenterHorizontally
        ) {
            TransferButton(
                isRight = true,
                onClick = { moveToRight() },
                enabled = !disabled && leftChecked.isNotEmpty()
            )
            TransferButton(
                isRight = false,
                onClick = { moveToLeft() },
                enabled = !disabled && rightChecked.isNotEmpty()
            )
        }

        // Right Panel
        TransferPanel(
            title = titles.second,
            data = rightData,
            checkedKeys = rightChecked,
            onCheckedKeysChange = { rightChecked = it },
            variant = variant,
            disabled = disabled,
            modifier = Modifier.weight(1f).fillMaxHeight()
        )
    }
}

@Composable
private fun TransferPanel(
    title: String,
    data: List<TransferOption>,
    checkedKeys: Set<String>,
    onCheckedKeysChange: (Set<String>) -> Unit,
    variant: BizTransferVariant,
    disabled: Boolean,
    modifier: Modifier
) {
    val allEnabledData = data.filter { !it.disabled }
    val isAllChecked = allEnabledData.isNotEmpty() && checkedKeys.containsAll(allEnabledData.map { it.key })
    val shape = if (variant == BizTransferVariant.Underlined) RoundedCornerShape(0.dp) else RoundedCornerShape(8.dp)

    val baseModifier = modifier.clip(shape)
    val panelModifier = when (variant) {
        BizTransferVariant.Outlined -> baseModifier.background(Color.White).border(1.dp, Color(0xFFCCCCCC), shape)
        BizTransferVariant.Filled -> baseModifier.background(Color(0xFFF5F5F5)) // Usually bottom border is drawn differently, omitting for simplicity
        BizTransferVariant.Underlined -> baseModifier.background(Color.Transparent)
    }

    Column(modifier = panelModifier) {
        // Header
        val headerBg = when (variant) {
            BizTransferVariant.Outlined -> Color(0xFFFAFAFA)
            BizTransferVariant.Filled -> Color(0xFFE8E8E8)
            BizTransferVariant.Underlined -> Color.Transparent
        }
        val headerPadding = if (variant == BizTransferVariant.Underlined) PaddingValues(horizontal = 8.dp, vertical = 12.dp)
        else PaddingValues(horizontal = 16.dp, vertical = 12.dp)

        Row(
            modifier = Modifier
                .fillMaxWidth()
                .background(headerBg)
                .padding(headerPadding),
            verticalAlignment = Alignment.CenterVertically,
            horizontalArrangement = Arrangement.SpaceBetween
        ) {
            Row(verticalAlignment = Alignment.CenterVertically) {
                Checkbox(
                    checked = isAllChecked,
                    onCheckedChange = { checked ->
                        if (checked) onCheckedKeysChange(allEnabledData.map { it.key }.toSet())
                        else onCheckedKeysChange(emptySet())
                    },
                    enabled = !disabled,
                    modifier = Modifier.size(24.dp)
                )
                Spacer(modifier = Modifier.width(8.dp))
                Text(text = title, fontSize = 14.sp, fontWeight = FontWeight.Medium, color = Color(0xFF333333))
            }
            Text(text = "${checkedKeys.size}/${data.size}", fontSize = 12.sp, color = Color(0xFF999999))
        }

        // Dividers
        if (variant == BizTransferVariant.Outlined) {
            Box(Modifier.fillMaxWidth().height(1.dp).background(Color(0xFFEEEEEE)))
        } else if (variant == BizTransferVariant.Filled) {
            Box(Modifier.fillMaxWidth().height(1.dp).background(Color(0xFFDDDDDD)))
        } else if (variant == BizTransferVariant.Underlined) {
            Box(Modifier.fillMaxWidth().height(2.dp).background(Color(0xFFCCCCCC)))
        }

        // Body
        if (data.isEmpty()) {
            Box(modifier = Modifier.fillMaxSize(), contentAlignment = Alignment.Center) {
                Text(text = "No Data", color = Color(0xFFCCCCCC), fontSize = 14.sp)
            }
        } else {
            LazyColumn(
                modifier = Modifier
                    .fillMaxSize()
                    .padding(vertical = 8.dp)
            ) {
                items(data, key = { it.key }) { item ->
                    val isChecked = checkedKeys.contains(item.key)
                    val itemDisabled = disabled || item.disabled
                    Row(
                        modifier = Modifier
                            .fillMaxWidth()
                            .clickable(enabled = !itemDisabled) {
                                if (isChecked) onCheckedKeysChange(checkedKeys - item.key)
                                else onCheckedKeysChange(checkedKeys + item.key)
                            }
                            .background(if (isChecked) Color(0x0D1A2A5E) else Color.Transparent)
                            .padding(
                                horizontal = if (variant == BizTransferVariant.Underlined) 8.dp else 16.dp,
                                vertical = 8.dp
                            ),
                        verticalAlignment = Alignment.CenterVertically
                    ) {
                        Checkbox(
                            checked = isChecked,
                            onCheckedChange = null,
                            enabled = !itemDisabled,
                            modifier = Modifier.size(24.dp)
                        )
                        Spacer(modifier = Modifier.width(8.dp))
                        Text(
                            text = item.label,
                            fontSize = 14.sp,
                            color = if (itemDisabled) Color(0xFF333333).copy(alpha = 0.5f) else Color(0xFF333333)
                        )
                    }
                }
            }
        }
    }
}

@Composable
private fun TransferButton(
    isRight: Boolean,
    onClick: () -> Unit,
    enabled: Boolean
) {
    Box(
        modifier = Modifier
            .size(36.dp)
            .clip(RoundedCornerShape(4.dp))
            .background(if (enabled) Color.White else Color(0xFFF5F5F5))
            .border(1.dp, if (enabled) Color(0xFFCCCCCC) else Color(0xFFEEEEEE), RoundedCornerShape(4.dp))
            .clickable(enabled = enabled, onClick = onClick),
        contentAlignment = Alignment.Center
    ) {
        val vector = androidx.compose.ui.graphics.vector.ImageVector.Builder(
            name = if (isRight) "Right" else "Left",
            defaultWidth = 18.dp,
            defaultHeight = 18.dp,
            viewportWidth = 24f,
            viewportHeight = 24f
        ).apply {
            path(
                stroke = androidx.compose.ui.graphics.SolidColor(if (enabled) Color(0xFF333333) else Color(0xFFCCCCCC)),
                strokeLineWidth = 2f,
                strokeLineCap = androidx.compose.ui.graphics.StrokeCap.Round,
                strokeLineJoin = androidx.compose.ui.graphics.StrokeJoin.Round
            ) {
                if (isRight) {
                    moveTo(9f, 18f)
                    lineTo(15f, 12f)
                    lineTo(9f, 6f)
                } else {
                    moveTo(15f, 18f)
                    lineTo(9f, 12f)
                    lineTo(15f, 6f)
                }
            }
        }.build()

        Icon(
            imageVector = vector,
            contentDescription = null,
            tint = Color.Unspecified,
            modifier = Modifier.size(18.dp)
        )
    }
}
