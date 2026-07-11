package kh.mcnc.lib.ui.components.branch

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Surface
import androidx.compose.ui.Modifier

class BranchLocatorActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        
        val sampleBranches = listOf(
            BranchData(
                id = "1",
                name = "Main Branch",
                distance = "0.01 km",
                businessTime = "8am - 4pm",
                facilities = listOf("Coffee", "Korean", "Chinese"),
                latitude = 11.5564,
                longitude = 104.9282
            ),
            BranchData(
                id = "2",
                name = "Koh Pich Branch",
                distance = "1.7 km",
                businessTime = "8am - 4pm",
                facilities = listOf("Coffee", "Korean", "Chinese"),
                latitude = 11.5450,
                longitude = 104.9350
            ),
            BranchData(
                id = "3",
                name = "Toul Kork Branch",
                distance = "2.5 km",
                businessTime = "8am - 4pm",
                facilities = listOf("Coffee", "Korean", "Chinese"),
                latitude = 11.5732,
                longitude = 104.8967
            ),
            BranchData(
                id = "4",
                name = "BKK Branch",
                distance = "500 m",
                businessTime = "8am - 4pm",
                facilities = listOf("Coffee", "Korean", "Chinese"),
                latitude = 11.5501,
                longitude = 104.9220
            )
        )

        setContent {
            MaterialTheme {
                Surface(
                    modifier = Modifier.fillMaxSize(),
                    color = MaterialTheme.colorScheme.background
                ) {
                    AppBranchLocatorScreen(
                        branches = sampleBranches,
                        onBackClick = { finish() }
                    )
                }
            }
        }
    }
}
