package kh.mcnc.lib.ui.components

import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.text.KeyboardOptions
import androidx.compose.material3.OutlinedTextField
import androidx.compose.material3.Text
import androidx.compose.runtime.*
import androidx.compose.ui.Modifier
import androidx.compose.ui.text.AnnotatedString
import androidx.compose.ui.text.input.KeyboardType
import androidx.compose.ui.text.input.OffsetMapping
import androidx.compose.ui.text.input.TransformedText
import androidx.compose.ui.text.input.VisualTransformation
import java.text.DecimalFormat

@Composable
fun AppCurrencyTextField(
    value: String,
    onValueChange: (String) -> Unit,
    modifier: Modifier = Modifier,
    label: String = "Amount",
    currencySymbol: String = "$"
) {
    OutlinedTextField(
        value = value,
        onValueChange = { newValue ->
            // Only allow digits and optionally a single decimal point
            val filtered = newValue.filter { it.isDigit() || it == '.' }
            if (filtered.count { it == '.' } <= 1) {
                onValueChange(filtered)
            }
        },
        modifier = modifier.fillMaxWidth(),
        label = { Text(label) },
        leadingIcon = { Text(currencySymbol) },
        keyboardOptions = KeyboardOptions(keyboardType = KeyboardType.Decimal),
        visualTransformation = CurrencyVisualTransformation(),
        singleLine = true
    )
}

class CurrencyVisualTransformation : VisualTransformation {
    override fun filter(text: AnnotatedString): TransformedText {
        val originalText = text.text
        if (originalText.isEmpty()) {
            return TransformedText(text, OffsetMapping.Identity)
        }

        val parts = originalText.split(".")
        val integerPart = parts[0]
        val fractionalPart = if (parts.size > 1) "." + parts[1] else if (originalText.endsWith(".")) "." else ""

        val formattedInteger = if (integerPart.isNotEmpty()) {
            try {
                val parsed = integerPart.toLong()
                val formatter = DecimalFormat("#,###")
                formatter.format(parsed)
            } catch (e: Exception) {
                integerPart
            }
        } else {
            ""
        }

        val formattedText = formattedInteger + fractionalPart
        val offsetMapping = CurrencyOffsetMapping(originalText, formattedText)

        return TransformedText(AnnotatedString(formattedText), offsetMapping)
    }

    private class CurrencyOffsetMapping(val original: String, val formatted: String) : OffsetMapping {
        override fun originalToTransformed(offset: Int): Int {
            if (offset <= 0) return 0
            if (offset >= original.length) return formatted.length
            
            // Simple approach for comma tracking: count how many characters we have passed
            val substring = original.substring(0, offset)
            val commaCount = formatted.substring(0, formatted.length.coerceAtMost(offset + formatted.count { it == ',' })).count { it == ',' }
            return offset + commaCount
        }

        override fun transformedToOriginal(offset: Int): Int {
            if (offset <= 0) return 0
            if (offset >= formatted.length) return original.length
            
            val substring = formatted.substring(0, offset)
            val commaCount = substring.count { it == ',' }
            return offset - commaCount
        }
    }
}
