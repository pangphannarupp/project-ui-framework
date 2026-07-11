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
fun BizLanguageSheet(
    isVisible: Boolean,
    selectedLang: String,
    onDismissRequest: () -> Unit,
    onChange: (String) -> Unit
) {
    data class LangOption(val code: String, val name: String, val flag: String)
    val languages = listOf(
        LangOption("km", "ភាសាខ្មែរ", "🇰🇭"),
        LangOption("en", "English", "🇬🇧"),
        LangOption("ko", "한국어", "🇰🇷"),
        LangOption("ja", "日本語", "🇯🇵"),
        LangOption("zh", "漢語", "🇨🇳")
    )

    BizBottomSheet(
        isVisible = isVisible,
        onDismissRequest = onDismissRequest
    ) {
        Column(
            modifier = Modifier
                .fillMaxWidth()
                .padding(horizontal = 24.dp)
                .padding(top = 8.dp, bottom = 32.dp)
        ) {
            Text(
                text = "Please Select Your Language",
                fontSize = 16.sp,
                fontWeight = FontWeight.Bold,
                color = Color(0xFF1A2A5E),
                modifier = Modifier.padding(bottom = 8.dp)
            )
            Text(
                text = "Choose the language and region you want to use in smartBiz app",
                fontSize = 12.sp,
                color = Color(0xFF555555),
                lineHeight = 16.sp,
                modifier = Modifier.padding(bottom = 24.dp)
            )

            Column(
                modifier = Modifier.fillMaxWidth(),
                verticalArrangement = Arrangement.spacedBy(12.dp)
            ) {
                languages.forEach { lang ->
                    val isActive = selectedLang == lang.code
                    Surface(
                        shape = RoundedCornerShape(12.dp),
                        color = Color.White,
                        border = BorderStroke(
                            width = 1.5.dp,
                            color = if (isActive) Color(0xFF1A2A5E) else Color(0xFFEAEAEA)
                        ),
                        modifier = Modifier
                            .fillMaxWidth()
                            .clickable {
                                onChange(lang.code)
                                CoroutineScope(Dispatchers.Main).launch {
                                    delay(200)
                                    onDismissRequest()
                                }
                            }
                    ) {
                        Row(
                            modifier = Modifier
                                .fillMaxWidth()
                                .padding(horizontal = 16.dp, vertical = 12.dp),
                            horizontalArrangement = Arrangement.SpaceBetween,
                            verticalAlignment = Alignment.CenterVertically
                        ) {
                            Row(
                                verticalAlignment = Alignment.CenterVertically,
                                horizontalArrangement = Arrangement.spacedBy(12.dp)
                            ) {
                                Text(
                                    text = lang.flag,
                                    fontSize = 20.sp
                                )
                                Text(
                                    text = lang.name,
                                    fontSize = 14.sp,
                                    color = Color(0xFF111111),
                                    fontWeight = FontWeight.SemiBold
                                )
                            }

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
