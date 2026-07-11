package kh.mcnc.lib.components

import androidx.compose.foundation.BorderStroke
import androidx.compose.foundation.background
import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.rememberScrollState
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.foundation.verticalScroll
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.Search
import androidx.compose.material3.Icon
import androidx.compose.material3.OutlinedTextField
import androidx.compose.material3.OutlinedTextFieldDefaults
import androidx.compose.material3.Surface
import androidx.compose.material3.Text
import androidx.compose.runtime.*
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
fun BizCountryCodeSheet(
    isVisible: Boolean,
    selectedCode: String,
    onDismissRequest: () -> Unit,
    onChange: (String) -> Unit
) {
    data class Country(val code: String, val name: String, val dialCode: String)
    val popularCountries = listOf(
        Country("KH", "Cambodia", "+855"),
        Country("KR", "Republic of Korea", "+82"),
        Country("CN", "China", "+86"),
        Country("JP", "Japan", "+81")
    )
    val allCountries = popularCountries + listOf(
        Country("US", "United States", "+1"),
        Country("GB", "United Kingdom", "+44"),
        Country("TH", "Thailand", "+66"),
        Country("VN", "Vietnam", "+84"),
        Country("SG", "Singapore", "+65")
    )

    var searchQuery by remember { mutableStateOf("") }
    var activeTab by remember { mutableStateOf("popular") }

    val filteredCountries = remember(activeTab, searchQuery) {
        val list = if (activeTab == "popular") popularCountries else allCountries
        if (searchQuery.isEmpty()) list
        else {
            val query = searchQuery.lowercase()
            list.filter { it.name.lowercase().contains(query) || it.dialCode.contains(query) }
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
                .heightIn(max = 600.dp)
        ) {
            Text(
                text = "Select Your Country Code",
                fontSize = 16.sp,
                fontWeight = FontWeight.Bold,
                color = Color(0xFF1A2A5E),
                modifier = Modifier.padding(bottom = 20.dp)
            )

            // Search Box (simplified placeholder for BizInput)
            OutlinedTextField(
                value = searchQuery,
                onValueChange = { searchQuery = it },
                placeholder = { Text("Search", color = Color(0xFF999999)) },
                leadingIcon = {
                    Icon(
                        imageVector = Icons.Default.Search,
                        contentDescription = "Search",
                        tint = Color(0xFF999999),
                        modifier = Modifier.size(18.dp)
                    )
                },
                modifier = Modifier
                    .fillMaxWidth()
                    .padding(bottom = 16.dp),
                shape = RoundedCornerShape(12.dp),
                colors = OutlinedTextFieldDefaults.colors(
                    unfocusedBorderColor = Color(0xFFEAEAEA),
                    focusedBorderColor = Color(0xFF0066CC)
                ),
                singleLine = true
            )

            // Segmented Button (simplified)
            Row(
                modifier = Modifier
                    .fillMaxWidth()
                    .padding(bottom = 16.dp)
                    .background(Color(0xFFF5F5F5), RoundedCornerShape(8.dp))
                    .padding(4.dp)
            ) {
                val tabs = listOf("popular" to "Popular", "all" to "All Country")
                tabs.forEach { (value, label) ->
                    val isActive = activeTab == value
                    Box(
                        modifier = Modifier
                            .weight(1f)
                            .background(
                                color = if (isActive) Color.White else Color.Transparent,
                                shape = RoundedCornerShape(6.dp)
                            )
                            .clickable { activeTab = value }
                            .padding(vertical = 8.dp),
                        contentAlignment = Alignment.Center
                    ) {
                        Text(
                            text = label,
                            fontSize = 14.sp,
                            fontWeight = if (isActive) FontWeight.SemiBold else FontWeight.Normal,
                            color = if (isActive) Color(0xFF1A2A5E) else Color(0xFF777777)
                        )
                    }
                }
            }

            Column(
                modifier = Modifier
                    .fillMaxWidth()
                    .verticalScroll(rememberScrollState()),
                verticalArrangement = Arrangement.spacedBy(12.dp)
            ) {
                filteredCountries.forEach { country ->
                    val isActive = selectedCode == country.dialCode
                    Surface(
                        shape = RoundedCornerShape(12.dp),
                        color = Color.White,
                        border = BorderStroke(
                            width = 1.5.dp,
                            color = if (isActive) Color(0xFF0066CC) else Color(0xFFEAEAEA)
                        ),
                        modifier = Modifier
                            .fillMaxWidth()
                            .clickable {
                                onChange(country.dialCode)
                                CoroutineScope(Dispatchers.Main).launch {
                                    delay(200)
                                    onDismissRequest()
                                }
                            }
                    ) {
                        Row(
                            modifier = Modifier
                                .fillMaxWidth()
                                .padding(horizontal = 16.dp, vertical = 14.dp),
                            horizontalArrangement = Arrangement.SpaceBetween,
                            verticalAlignment = Alignment.CenterVertically
                        ) {
                            Text(
                                text = "${country.name} (${country.dialCode})",
                                fontSize = 14.sp,
                                fontWeight = FontWeight.Medium,
                                color = if (isActive) Color(0xFF0066CC) else Color(0xFF111111)
                            )

                            Box(
                                modifier = Modifier
                                    .size(20.dp)
                                    .background(Color.Transparent, CircleShape),
                                contentAlignment = Alignment.Center
                            ) {
                                Surface(
                                    modifier = Modifier.fillMaxSize(),
                                    shape = CircleShape,
                                    color = Color.Transparent,
                                    border = BorderStroke(
                                        width = 2.dp,
                                        color = if (isActive) Color(0xFF0066CC) else Color(0xFFEAEAEA)
                                    )
                                ) {}
                                if (isActive) {
                                    Box(
                                        modifier = Modifier
                                            .size(10.dp)
                                            .background(Color(0xFF0066CC), CircleShape)
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
