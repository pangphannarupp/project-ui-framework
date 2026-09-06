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
 * BizTable - Jetpack Compose component matching Web UI-Framework `PPTable.vue`.
 */
@Composable
fun BizTable(
    modifier: Modifier = Modifier,
    columns: List<String> = emptyList(),
    required: String = "",
    data: List<String> = emptyList(),
    pagination: Boolean = false,
    pageSize: Int = 0,
    striped: Boolean = false,
    bordered: Boolean = false,
    hover: Boolean = false,
    compact: Boolean = false,
    paginationVariant: String = "",
    paginationShape: String = "",
    paginationSize: String = "",
    showSizeChanger: Boolean = false,
    pageSizes: List<String> = emptyList(),
    paginationAlign: String = "",
    sizeChangerPosition: String = "",
    showFirstLast: Boolean = false,
    selectable: Boolean = false,
    multiple: Boolean = false,
    rowKey: String = "",
    modelValue: List<String> = emptyList(),
    loading: Boolean = false,
    skeletonRows: Int = 0,
    expandable: Boolean = false,
    spanMethod: String = "",
    emptyText: String = "",
    emptyIcon: String = "",
    onClick: () -> Unit = {},
    onValueChange: ((String) -> Unit)? = null,
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
                    text = "Table",
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
 * Web UI-Framework parity alias for [BizTable].
 */
@Composable
fun PPTable(
    modifier: Modifier = Modifier,
    columns: List<String> = emptyList(),
    required: String = "",
    data: List<String> = emptyList(),
    pagination: Boolean = false,
    pageSize: Int = 0,
    striped: Boolean = false,
    bordered: Boolean = false,
    hover: Boolean = false,
    compact: Boolean = false,
    paginationVariant: String = "",
    paginationShape: String = "",
    paginationSize: String = "",
    showSizeChanger: Boolean = false,
    pageSizes: List<String> = emptyList(),
    paginationAlign: String = "",
    sizeChangerPosition: String = "",
    showFirstLast: Boolean = false,
    selectable: Boolean = false,
    multiple: Boolean = false,
    rowKey: String = "",
    modelValue: List<String> = emptyList(),
    loading: Boolean = false,
    skeletonRows: Int = 0,
    expandable: Boolean = false,
    spanMethod: String = "",
    emptyText: String = "",
    emptyIcon: String = "",
    onClick: () -> Unit = {},
    onValueChange: ((String) -> Unit)? = null,
    content: @Composable (() -> Unit)? = null
) = BizTable(
        modifier = modifier,
        columns = columns,
        required = required,
        data = data,
        pagination = pagination,
        pageSize = pageSize,
        striped = striped,
        bordered = bordered,
        hover = hover,
        compact = compact,
        paginationVariant = paginationVariant,
        paginationShape = paginationShape,
        paginationSize = paginationSize,
        showSizeChanger = showSizeChanger,
        pageSizes = pageSizes,
        paginationAlign = paginationAlign,
        sizeChangerPosition = sizeChangerPosition,
        showFirstLast = showFirstLast,
        selectable = selectable,
        multiple = multiple,
        rowKey = rowKey,
        modelValue = modelValue,
        loading = loading,
        skeletonRows = skeletonRows,
        expandable = expandable,
        spanMethod = spanMethod,
        emptyText = emptyText,
        emptyIcon = emptyIcon,
        onClick = onClick,
        onValueChange = onValueChange,
        content = content
)
