package kh.mcnc.lib.ui

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import kh.mcnc.lib.ui.theme.AppTheme

class ComponentGalleryActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        androidx.core.view.WindowCompat.setDecorFitsSystemWindows(window, false)
        setContent {
            AppTheme {
                ComponentGalleryScreen()
            }
        }
    }
}
