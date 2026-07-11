package kh.mcnc.lib.components

import androidx.compose.foundation.layout.*
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Modifier

enum class BizSelectVariant {
    Outlined, Filled, Underlined
}

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun BizSelect(
    modifier: Modifier = Modifier,
    value: String = "",
    onValueChange: (String) -> Unit = {},
    label: String? = null,
    placeholder: String? = null,
    options: List<String> = emptyList(),
    variant: BizSelectVariant = BizSelectVariant.Outlined,
    disabled: Boolean = false,
    error: String? = null,
    helperText: String? = null,
    required: Boolean = false
) {
    var expanded by remember { mutableStateOf(false) }

    ExposedDropdownMenuBox(
        expanded = expanded,
        onExpandedChange = { if (!disabled) expanded = !expanded },
        modifier = modifier
    ) {
        val labelContent: @Composable (() -> Unit)? = if (label != null) {
            { Text("$label${if (required) " *" else ""}") }
        } else null

        val placeholderContent: @Composable (() -> Unit)? = if (placeholder != null) {
            { Text(placeholder) }
        } else null

        when (variant) {
            BizSelectVariant.Outlined -> {
                OutlinedTextField(
                    value = value,
                    onValueChange = {},
                    readOnly = true,
                    label = labelContent,
                    placeholder = placeholderContent,
                    modifier = Modifier.menuAnchor().fillMaxWidth(),
                    trailingIcon = { ExposedDropdownMenuDefaults.TrailingIcon(expanded = expanded) },
                    colors = ExposedDropdownMenuDefaults.outlinedTextFieldColors(),
                    enabled = !disabled,
                    isError = error != null,
                    supportingText = if (error != null || helperText != null) {
                        { Text(error ?: helperText ?: "") }
                    } else null
                )
            }
            BizSelectVariant.Filled -> {
                TextField(
                    value = value,
                    onValueChange = {},
                    readOnly = true,
                    label = labelContent,
                    placeholder = placeholderContent,
                    modifier = Modifier.menuAnchor().fillMaxWidth(),
                    trailingIcon = { ExposedDropdownMenuDefaults.TrailingIcon(expanded = expanded) },
                    colors = ExposedDropdownMenuDefaults.textFieldColors(),
                    enabled = !disabled,
                    isError = error != null,
                    supportingText = if (error != null || helperText != null) {
                        { Text(error ?: helperText ?: "") }
                    } else null
                )
            }
            BizSelectVariant.Underlined -> {
                TextField(
                    value = value,
                    onValueChange = {},
                    readOnly = true,
                    label = labelContent,
                    placeholder = placeholderContent,
                    modifier = Modifier.menuAnchor().fillMaxWidth(),
                    trailingIcon = { ExposedDropdownMenuDefaults.TrailingIcon(expanded = expanded) },
                    colors = ExposedDropdownMenuDefaults.textFieldColors(
                        focusedIndicatorColor = MaterialTheme.colorScheme.primary,
                        unfocusedIndicatorColor = MaterialTheme.colorScheme.onSurfaceVariant
                    ),
                    enabled = !disabled,
                    isError = error != null,
                    supportingText = if (error != null || helperText != null) {
                        { Text(error ?: helperText ?: "") }
                    } else null
                )
            }
        }
        
        ExposedDropdownMenu(
            expanded = expanded,
            onDismissRequest = { expanded = false }
        ) {
            options.forEach { option ->
                DropdownMenuItem(
                    text = { Text(option) },
                    onClick = {
                        onValueChange(option)
                        expanded = false
                    }
                )
            }
        }
    }
}
