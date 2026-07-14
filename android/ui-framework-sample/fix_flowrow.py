import re

file_path = '/Volumes/SSD/Projects/GitHub/project-ui-framework/android/ui-framework-sample/ui-framework/src/main/java/kh/mcnc/lib/components/BizFilterSheet.kt'

with open(file_path, 'r') as f:
    content = f.read()

custom_flow_row = """@Composable
fun SimpleFlowRow(
    modifier: Modifier = Modifier,
    horizontalSpacing: androidx.compose.ui.unit.Dp = 0.dp,
    verticalSpacing: androidx.compose.ui.unit.Dp = 0.dp,
    content: @Composable () -> Unit
) {
    androidx.compose.ui.layout.Layout(
        content = content,
        modifier = modifier
    ) { measurables, constraints ->
        val horizontalSpacingPx = horizontalSpacing.roundToPx()
        val verticalSpacingPx = verticalSpacing.roundToPx()

        val rows = mutableListOf<List<androidx.compose.ui.layout.Placeable>>()
        val rowHeights = mutableListOf<Int>()

        var currentRow = mutableListOf<androidx.compose.ui.layout.Placeable>()
        var currentRowWidth = 0
        var currentRowHeight = 0

        for (measurable in measurables) {
            val placeable = measurable.measure(constraints)

            if (currentRowWidth + placeable.width > constraints.maxWidth && currentRow.isNotEmpty()) {
                rows.add(currentRow)
                rowHeights.add(currentRowHeight)
                currentRow = mutableListOf()
                currentRowWidth = 0
                currentRowHeight = 0
            }

            currentRow.add(placeable)
            currentRowWidth += placeable.width + horizontalSpacingPx
            currentRowHeight = maxOf(currentRowHeight, placeable.height)
        }

        if (currentRow.isNotEmpty()) {
            rows.add(currentRow)
            rowHeights.add(currentRowHeight)
        }

        val totalHeight = rowHeights.sum() + (maxOf(0, rows.size - 1) * verticalSpacingPx)

        layout(constraints.maxWidth, totalHeight) {
            var yPosition = 0

            for (i in rows.indices) {
                val row = rows[i]
                var xPosition = 0

                for (placeable in row) {
                    placeable.placeRelative(xPosition, yPosition)
                    xPosition += placeable.width + horizontalSpacingPx
                }

                yPosition += rowHeights[i] + verticalSpacingPx
            }
        }
    }
}
"""

if "fun SimpleFlowRow" not in content:
    # Add after imports
    content = content.replace('import androidx.compose.ui.unit.sp\n', 'import androidx.compose.ui.unit.sp\n' + custom_flow_row + '\n')

content = re.sub(
    r'FlowRow\(\s*modifier = Modifier\.padding\(bottom = 32\.dp\),\s*horizontalArrangement = Arrangement\.spacedBy\(12\.dp\),\s*verticalArrangement = Arrangement\.spacedBy\(12\.dp\)\s*\)',
    'SimpleFlowRow(\n                modifier = Modifier.padding(bottom = 32.dp),\n                horizontalSpacing = 12.dp,\n                verticalSpacing = 12.dp\n            )',
    content
)

# Remove the import of FlowRow to prevent issues
content = content.replace('import androidx.compose.foundation.layout.FlowRow\n', '')
content = content.replace('import androidx.compose.foundation.layout.ExperimentalLayoutApi\n', '')

with open(file_path, 'w') as f:
    f.write(content)
