package kh.mcnc.lib.ui.components

import android.graphics.Bitmap
import android.graphics.pdf.PdfRenderer
import android.os.ParcelFileDescriptor
import androidx.compose.foundation.Image
import androidx.compose.foundation.background
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.material3.CircularProgressIndicator
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Text
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.graphics.asImageBitmap
import androidx.compose.ui.layout.ContentScale
import androidx.compose.ui.platform.LocalDensity
import androidx.compose.ui.unit.dp
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.isActive
import kotlinx.coroutines.withContext

/**
 * A wrapper component for rendering PDF documents using the native Android PdfRenderer.
 * Note: Provide a valid ParcelFileDescriptor for an actual PDF.
 */
@Composable
fun AppPdfViewer(
    fileDescriptor: ParcelFileDescriptor?,
    modifier: Modifier = Modifier
) {
    if (fileDescriptor == null) {
        Box(
            modifier = modifier
                .fillMaxWidth()
                .height(300.dp)
                .background(Color.LightGray.copy(alpha = 0.3f)),
            contentAlignment = Alignment.Center
        ) {
            Text(
                text = "No PDF document provided",
                color = MaterialTheme.colorScheme.onSurfaceVariant
            )
        }
        return
    }

    var pdfRenderer by remember { mutableStateOf<PdfRenderer?>(null) }
    var pageCount by remember { mutableStateOf(0) }

    DisposableEffect(fileDescriptor) {
        try {
            val renderer = PdfRenderer(fileDescriptor)
            pdfRenderer = renderer
            pageCount = renderer.pageCount
        } catch (e: Exception) {
            e.printStackTrace()
        }

        onDispose {
            pdfRenderer?.close()
        }
    }

    if (pageCount == 0) {
        Box(
            modifier = modifier
                .fillMaxWidth()
                .height(300.dp),
            contentAlignment = Alignment.Center
        ) {
            CircularProgressIndicator()
        }
    } else {
        LazyColumn(
            modifier = modifier
                .fillMaxWidth()
                .background(Color.DarkGray)
        ) {
            items(pageCount) { index ->
                PdfPage(
                    pdfRenderer = pdfRenderer,
                    pageIndex = index,
                    modifier = Modifier
                        .fillMaxWidth()
                        .padding(bottom = 8.dp)
                )
            }
        }
    }
}

@Composable
private fun PdfPage(
    pdfRenderer: PdfRenderer?,
    pageIndex: Int,
    modifier: Modifier = Modifier
) {
    var bitmap by remember { mutableStateOf<Bitmap?>(null) }
    val density = LocalDensity.current.density

    LaunchedEffect(pdfRenderer, pageIndex) {
        withContext(Dispatchers.IO) {
            if (pdfRenderer != null && isActive) {
                try {
                    val page = pdfRenderer.openPage(pageIndex)
                    // Render at a higher resolution (e.g. 2x density) for clarity
                    val width = (page.width * density).toInt()
                    val height = (page.height * density).toInt()
                    
                    val renderBitmap = Bitmap.createBitmap(width, height, Bitmap.Config.ARGB_8888)
                    // Fill with white background before rendering
                    renderBitmap.eraseColor(android.graphics.Color.WHITE)
                    
                    page.render(renderBitmap, null, null, PdfRenderer.Page.RENDER_MODE_FOR_DISPLAY)
                    page.close()

                    withContext(Dispatchers.Main) {
                        bitmap = renderBitmap
                    }
                } catch (e: Exception) {
                    e.printStackTrace()
                }
            }
        }
    }

    if (bitmap != null) {
        Image(
            bitmap = bitmap!!.asImageBitmap(),
            contentDescription = "PDF Page ${pageIndex + 1}",
            contentScale = ContentScale.FillWidth,
            modifier = modifier
        )
    } else {
        Box(
            modifier = modifier
                .fillMaxWidth()
                .aspectRatio(0.7f) // Typical A4 aspect ratio approximation
                .background(Color.White),
            contentAlignment = Alignment.Center
        ) {
            CircularProgressIndicator()
        }
    }
}
