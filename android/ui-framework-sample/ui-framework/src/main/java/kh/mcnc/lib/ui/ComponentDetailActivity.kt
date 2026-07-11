package kh.mcnc.lib.ui

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import kh.mcnc.lib.ui.theme.AppTheme

class ComponentDetailActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        
        val componentName = intent.getStringExtra("COMPONENT_NAME")
        
        setContent {
            AppTheme {
                ComponentGalleryScreen(initialSelection = componentName)
            }
        }
    }
}
