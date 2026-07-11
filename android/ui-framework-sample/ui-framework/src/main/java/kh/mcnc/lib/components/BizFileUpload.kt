package kh.mcnc.lib.components

import androidx.compose.foundation.BorderStroke
import androidx.compose.foundation.background
import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.*
import androidx.compose.material3.*
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.style.TextOverflow
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import java.util.UUID

enum class BizFileUploadStatus {
    Pending, Uploading, Success, Error
}

data class BizFileItem(
    val id: String = UUID.randomUUID().toString(),
    val name: String,
    val size: Long,
    val progress: Float = 0f, // 0.0 to 100.0
    val status: BizFileUploadStatus = BizFileUploadStatus.Pending,
    val errorMessage: String? = null
)

@Composable
fun BizFileUpload(
    modifier: Modifier = Modifier,
    multiple: Boolean = false,
    accept: String? = null,
    maxSize: Long? = null,
    disabled: Boolean = false,
    files: List<BizFileItem> = emptyList(),
    onSelect: () -> Unit,
    onRemove: (String) -> Unit = {},
    onRetry: (String) -> Unit = {}
) {
    Column(
        modifier = modifier.fillMaxWidth(),
        verticalArrangement = Arrangement.spacedBy(16.dp)
    ) {
        // Dropzone
        Surface(
            modifier = Modifier
                .fillMaxWidth()
                .clickable(enabled = !disabled, onClick = onSelect),
            shape = RoundedCornerShape(12.dp),
            color = Color(0xFFFAFAFA),
            border = BorderStroke(2.dp, Color(0xFFCCCCCC))
        ) {
            Column(
                modifier = Modifier
                    .fillMaxWidth()
                    .padding(vertical = 32.dp, horizontal = 16.dp)
                    .then(if (disabled) Modifier.background(Color(0x80FFFFFF)) else Modifier),
                horizontalAlignment = Alignment.CenterHorizontally,
                verticalArrangement = Arrangement.spacedBy(12.dp)
            ) {
                Icon(
                    imageVector = Icons.Default.Upload,
                    contentDescription = "Upload",
                    tint = if (disabled) Color.Gray else Color(0xFF999999),
                    modifier = Modifier.size(32.dp)
                )

                Row {
                    Text(
                        text = "Click to upload",
                        fontWeight = FontWeight.SemiBold,
                        color = Color(0xFF1A2A5E),
                        fontSize = 15.sp
                    )
                    Text(
                        text = " or tap to browse",
                        color = Color(0xFF666666),
                        fontSize = 15.sp
                    )
                }

                if (accept != null || maxSize != null) {
                    Row {
                        if (accept != null) {
                            Text(
                                text = accept.replace(",", ", "),
                                color = Color(0xFF999999),
                                fontSize = 13.sp
                            )
                        }
                        if (accept != null && maxSize != null) {
                            Text(text = " (", color = Color(0xFF999999), fontSize = 13.sp)
                        }
                        if (maxSize != null) {
                            Text(
                                text = "Max: ${formatBytes(maxSize)}",
                                color = Color(0xFF999999),
                                fontSize = 13.sp
                            )
                        }
                        if (accept != null && maxSize != null) {
                            Text(text = ")", color = Color(0xFF999999), fontSize = 13.sp)
                        }
                    }
                }
            }
        }

        // File List
        if (files.isNotEmpty()) {
            Column(verticalArrangement = Arrangement.spacedBy(12.dp)) {
                files.forEach { file ->
                    val borderColor = when (file.status) {
                        BizFileUploadStatus.Error -> Color(0xFFFFEBEE)
                        BizFileUploadStatus.Success -> Color(0xFFE8F5E9)
                        else -> Color(0xFFEEEEEE)
                    }
                    val bgColor = when (file.status) {
                        BizFileUploadStatus.Error -> Color(0xFFFFF9F9)
                        else -> Color.White
                    }

                    Surface(
                        modifier = Modifier.fillMaxWidth(),
                        shape = RoundedCornerShape(8.dp),
                        border = BorderStroke(1.dp, borderColor),
                        color = bgColor
                    ) {
                        Row(
                            modifier = Modifier.padding(horizontal = 16.dp, vertical = 12.dp),
                            verticalAlignment = Alignment.CenterVertically,
                            horizontalArrangement = Arrangement.spacedBy(16.dp)
                        ) {
                            // Icon
                            Box(
                                modifier = Modifier
                                    .size(40.dp)
                                    .clip(RoundedCornerShape(8.dp))
                                    .background(Color(0xFFF4F5F8)),
                                contentAlignment = Alignment.Center
                            ) {
                                Icon(
                                    imageVector = Icons.Default.InsertDriveFile,
                                    contentDescription = null,
                                    tint = Color(0xFF666666),
                                    modifier = Modifier.size(20.dp)
                                )
                            }

                            // Details
                            Column(
                                modifier = Modifier.weight(1f),
                                verticalArrangement = Arrangement.spacedBy(4.dp)
                            ) {
                                Row(
                                    modifier = Modifier.fillMaxWidth(),
                                    horizontalArrangement = Arrangement.SpaceBetween,
                                    verticalAlignment = Alignment.CenterVertically
                                ) {
                                    Text(
                                        text = file.name,
                                        fontSize = 14.sp,
                                        fontWeight = FontWeight.Medium,
                                        color = Color(0xFF333333),
                                        maxLines = 1,
                                        overflow = TextOverflow.Ellipsis,
                                        modifier = Modifier.weight(1f, fill = false)
                                    )
                                    Spacer(modifier = Modifier.width(8.dp))
                                    if (file.status != BizFileUploadStatus.Uploading) {
                                        Text(
                                            text = formatBytes(file.size),
                                            fontSize = 12.sp,
                                            color = Color(0xFF999999)
                                        )
                                    } else {
                                        Text(
                                            text = "${file.progress.toInt()}%",
                                            fontSize = 12.sp,
                                            color = Color(0xFF999999)
                                        )
                                    }
                                }

                                if (file.status == BizFileUploadStatus.Uploading) {
                                    LinearProgressIndicator(
                                        progress = file.progress / 100f,
                                        modifier = Modifier
                                            .fillMaxWidth()
                                            .height(4.dp)
                                            .clip(RoundedCornerShape(2.dp)),
                                        color = Color(0xFF3880FF),
                                        trackColor = Color(0xFFEEEEEE),
                                    )
                                } else if (file.status == BizFileUploadStatus.Error) {
                                    Text(
                                        text = file.errorMessage ?: "Upload failed",
                                        fontSize = 12.sp,
                                        color = Color(0xFFD32F2F)
                                    )
                                }
                            }

                            // Actions
                            Row(
                                horizontalArrangement = Arrangement.spacedBy(8.dp),
                                verticalAlignment = Alignment.CenterVertically
                            ) {
                                if (file.status == BizFileUploadStatus.Error) {
                                    IconButton(
                                        onClick = { onRetry(file.id) },
                                        modifier = Modifier.size(32.dp)
                                    ) {
                                        Icon(
                                            imageVector = Icons.Default.Refresh,
                                            contentDescription = "Retry",
                                            tint = Color(0xFF999999),
                                            modifier = Modifier.size(18.dp)
                                        )
                                    }
                                }

                                if (file.status == BizFileUploadStatus.Success) {
                                    Icon(
                                        imageVector = Icons.Default.CheckCircle,
                                        contentDescription = "Success",
                                        tint = Color(0xFF388E3C),
                                        modifier = Modifier.size(20.dp)
                                    )
                                }

                                IconButton(
                                    onClick = { onRemove(file.id) },
                                    modifier = Modifier.size(32.dp)
                                ) {
                                    Icon(
                                        imageVector = Icons.Default.Close,
                                        contentDescription = "Remove",
                                        tint = Color(0xFF999999),
                                        modifier = Modifier.size(18.dp)
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

private fun formatBytes(bytes: Long): String {
    if (bytes <= 0) return "0 Bytes"
    val k = 1024.0
    val sizes = arrayOf("Bytes", "KB", "MB", "GB", "TB")
    val i = Math.floor(Math.log(bytes.toDouble()) / Math.log(k)).toInt()
    return String.format("%.2f %s", bytes / Math.pow(k, i.toDouble()), sizes[i])
}
