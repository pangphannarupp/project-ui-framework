package kh.mcnc.lib.components

import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.Home
import androidx.compose.material.icons.filled.Person
import androidx.compose.material.icons.filled.Search
import androidx.compose.material.icons.filled.Settings
import androidx.compose.material.icons.outlined.Home
import androidx.compose.material.icons.outlined.Person
import androidx.compose.material.icons.outlined.Search
import androidx.compose.material.icons.outlined.Settings
import androidx.compose.material3.Icon
import androidx.compose.material3.NavigationBar
import androidx.compose.material3.NavigationBarItem
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableIntStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.setValue
import androidx.compose.ui.graphics.vector.ImageVector
import androidx.compose.ui.tooling.preview.Preview

data class BizBottomMenuItem(
    val title: String,
    val selectedIcon: ImageVector,
    val unselectedIcon: ImageVector
)

@Composable
fun BizBottomMenu(
    items: List<BizBottomMenuItem>,
    selectedIndex: Int,
    onItemSelected: (Int) -> Unit
) {
    NavigationBar {
        items.forEachIndexed { index, item ->
            NavigationBarItem(
                icon = {
                    Icon(
                        imageVector = if (index == selectedIndex) item.selectedIcon else item.unselectedIcon,
                        contentDescription = item.title
                    )
                },
                label = { Text(item.title) },
                selected = index == selectedIndex,
                onClick = { onItemSelected(index) }
            )
        }
    }
}

@Preview(showBackground = true)
@Composable
fun BizBottomMenuPreview() {
    val items = listOf(
        BizBottomMenuItem("Home", Icons.Filled.Home, Icons.Outlined.Home),
        BizBottomMenuItem("Search", Icons.Filled.Search, Icons.Outlined.Search),
        BizBottomMenuItem("Profile", Icons.Filled.Person, Icons.Outlined.Person),
        BizBottomMenuItem("Settings", Icons.Filled.Settings, Icons.Outlined.Settings)
    )
    
    var selectedItem by remember { mutableIntStateOf(0) }
    
    BizBottomMenu(
        items = items,
        selectedIndex = selectedItem,
        onItemSelected = { selectedItem = it }
    )
}
