package mcnc.app.ui_framework_sample

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.activity.enableEdgeToEdge
import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.items
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.ArrowBack
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.unit.dp
import kh.mcnc.lib.components.BizBottomMenu
import kh.mcnc.lib.components.BizBottomMenuItem
import kh.mcnc.lib.components.BizButton
import kh.mcnc.lib.components.BizCollapsingToolbar
import kh.mcnc.lib.components.BizCheckbox
import kh.mcnc.lib.components.BizRadio
import kh.mcnc.lib.components.BizSwitch
import kh.mcnc.lib.components.BizIconButton
import kh.mcnc.lib.components.BizFab
import kh.mcnc.lib.components.BizTextField
import kh.mcnc.lib.components.BizInput
import kh.mcnc.lib.components.BizAppBar
import kh.mcnc.lib.components.BizInfoCard
import kh.mcnc.lib.components.BizRating
import kh.mcnc.lib.components.BizToast
import kh.mcnc.lib.components.BizSkeletonText
import kh.mcnc.lib.components.BizProgressGauge
import kh.mcnc.lib.components.BizAccountCard
import kh.mcnc.lib.components.BizAccountCardType
import kh.mcnc.lib.components.BizSegment
import kh.mcnc.lib.components.BizSlider
import kh.mcnc.lib.components.BizPieChart
import kh.mcnc.lib.components.BizPieSegment
import kh.mcnc.lib.components.BizBarChart
import kh.mcnc.lib.components.BizBarChartData
import kh.mcnc.lib.components.BizLineChart
import androidx.compose.material.icons.filled.Home
import androidx.compose.material.icons.filled.Person
import androidx.compose.material.icons.filled.Search
import androidx.compose.material.icons.filled.Settings
import androidx.compose.material.icons.outlined.Home
import androidx.compose.material.icons.outlined.Person
import androidx.compose.material.icons.outlined.Search
import androidx.compose.material.icons.outlined.Settings
import androidx.compose.foundation.background
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.text.font.FontFamily
import androidx.compose.ui.platform.LocalClipboardManager
import androidx.compose.ui.text.AnnotatedString
import kotlinx.coroutines.delay
import kotlinx.coroutines.launch
import androidx.compose.material.icons.filled.Check
import androidx.compose.material.icons.filled.ContentCopy

data class UIComponent(
    val name: String,
    val description: String,
    val codeSnippet: String,
    val viewFactory: @Composable () -> Unit
)

class MainActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        enableEdgeToEdge()
        setContent {
            MaterialTheme {
                Surface(modifier = Modifier.fillMaxSize()) {
                    CatalogApp()
                }
            }
        }
    }
}

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun CatalogApp() {
    var selectedComponent by remember { mutableStateOf<UIComponent?>(null) }
    
    val components = remember {
        listOf(
            UIComponent(
                name = "BizButton (Compose)",
                description = "A standard Compose button designed for the Biz platform. It features rounded corners, a primary brand color, and predefined text styling.",
                codeSnippet = """
BizButton(
    title = "Click Me!",
    onClick = { /* Handle click */ }
)
                """.trimIndent(),
                viewFactory = {
                    Box(modifier = Modifier.fillMaxWidth().padding(32.dp), contentAlignment = Alignment.Center) {
                        BizButton(title = "Biz Compose Button", onClick = {})
                    }
                }
            ),
            UIComponent(
                name = "BizBottomMenu (Compose M3)",
                description = "A native Compose implementation of the Material Design 3 Bottom Navigation bar. It features pill-shaped active indicators, smooth animations, and standard M3 layout.",
                codeSnippet = """
var selectedItem by remember { mutableIntStateOf(0) }
BizBottomMenu(
    items = items,
    selectedIndex = selectedItem,
    onItemSelected = { selectedItem = it }
)
                """.trimIndent(),
                viewFactory = {
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
            ),
            UIComponent(
                name = "BizCollapsingToolbar",
                description = "A collapsing top app bar that shrinks as you scroll down. It uses Material 3's LargeTopAppBar with exitUntilCollapsedScrollBehavior.",
                codeSnippet = """
val scrollBehavior = TopAppBarDefaults.exitUntilCollapsedScrollBehavior()
BizCollapsingToolbar(
    title = "Collapsing Bar",
    scrollBehavior = scrollBehavior
) { paddingValues ->
    // Scrollable content
    LazyColumn(contentPadding = paddingValues) { ... }
}
                """.trimIndent(),
                viewFactory = {
                    val scrollBehavior = TopAppBarDefaults.exitUntilCollapsedScrollBehavior()
                    Box(modifier = Modifier.fillMaxWidth().height(400.dp)) {
                        BizCollapsingToolbar(
                            title = "Collapsing Bar",
                            scrollBehavior = scrollBehavior
                        ) { paddingValues ->
                            LazyColumn(contentPadding = paddingValues) {
                                items(20) { index ->
                                    Text(
                                        text = "Scrollable Item ${index + 1}",
                                        modifier = Modifier.fillMaxWidth().padding(16.dp)
                                    )
                                    HorizontalDivider()
                                }
                            }
                        }
                    }
                }
            ),
            UIComponent(
                name = "BizCheckbox",
                description = "A standard Material 3 Checkbox mapped to the Biz design system.",
                codeSnippet = """
var checked by remember { mutableStateOf(false) }
BizCheckbox(
    checked = checked,
    onCheckedChange = { checked = it },
    label = "Accept Terms"
)
                """.trimIndent(),
                viewFactory = {
                    var checked by remember { mutableStateOf(false) }
                    Box(modifier = Modifier.fillMaxWidth().padding(32.dp), contentAlignment = Alignment.Center) {
                        BizCheckbox(
                            checked = checked,
                            onCheckedChange = { checked = it },
                            label = "Accept Terms"
                        )
                    }
                }
            ),
            UIComponent(
                name = "BizRadio",
                description = "A standard Material 3 Radio Button mapped to the Biz design system.",
                codeSnippet = """
var selected by remember { mutableStateOf(false) }
BizRadio(
    selected = selected,
    onClick = { selected = !selected },
    label = "Option 1"
)
                """.trimIndent(),
                viewFactory = {
                    var selected by remember { mutableStateOf(false) }
                    Box(modifier = Modifier.fillMaxWidth().padding(32.dp), contentAlignment = Alignment.Center) {
                        BizRadio(
                            selected = selected,
                            onClick = { selected = !selected },
                            label = "Option 1"
                        )
                    }
                }
            ),
            UIComponent(
                name = "BizSwitch",
                description = "A standard Material 3 Switch mapped to the Biz design system.",
                codeSnippet = """
var checked by remember { mutableStateOf(false) }
BizSwitch(
    checked = checked,
    onCheckedChange = { checked = it },
    label = "Enable Notifications"
)
                """.trimIndent(),
                viewFactory = {
                    var checked by remember { mutableStateOf(false) }
                    Box(modifier = Modifier.fillMaxWidth().padding(32.dp), contentAlignment = Alignment.Center) {
                        BizSwitch(
                            checked = checked,
                            onCheckedChange = { checked = it },
                            label = "Enable Notifications"
                        )
                    }
                }
            ),
            UIComponent(
                name = "BizIconButton",
                description = "A standard Icon Button.",
                codeSnippet = """
BizIconButton(
    icon = Icons.Default.Settings,
    onClick = { /* action */ }
)
                """.trimIndent(),
                viewFactory = {
                    Box(modifier = Modifier.fillMaxWidth().padding(32.dp), contentAlignment = Alignment.Center) {
                        BizIconButton(icon = Icons.Default.Settings, onClick = {})
                    }
                }
            ),
            UIComponent(
                name = "BizFab",
                description = "A Floating Action Button (FAB).",
                codeSnippet = """
BizFab(
    icon = Icons.Default.Check,
    onClick = { /* action */ }
)
                """.trimIndent(),
                viewFactory = {
                    Box(modifier = Modifier.fillMaxWidth().padding(32.dp), contentAlignment = Alignment.Center) {
                        BizFab(icon = Icons.Default.Check, onClick = {})
                    }
                }
            ),
            UIComponent(
                name = "BizTextField",
                description = "An outlined Text Field for user input.",
                codeSnippet = """
var text by remember { mutableStateOf("") }
BizTextField(
    value = text,
    onValueChange = { text = it },
    placeholder = "Enter text..."
)
                """.trimIndent(),
                viewFactory = {
                    var text by remember { mutableStateOf("") }
                    Box(modifier = Modifier.fillMaxWidth().padding(32.dp), contentAlignment = Alignment.Center) {
                        BizTextField(value = text, onValueChange = { text = it }, placeholder = "Enter text...")
                    }
                }
            ),
            UIComponent(
                name = "BizInput",
                description = "A standard filled Input field.",
                codeSnippet = """
var text by remember { mutableStateOf("") }
BizInput(
    value = text,
    onValueChange = { text = it },
    placeholder = "Search..."
)
                """.trimIndent(),
                viewFactory = {
                    var text by remember { mutableStateOf("") }
                    Box(modifier = Modifier.fillMaxWidth().padding(32.dp), contentAlignment = Alignment.Center) {
                        BizInput(value = text, onValueChange = { text = it }, placeholder = "Search...")
                    }
                }
            ),
            UIComponent(
                name = "BizAppBar",
                description = "A standard top App Bar.",
                codeSnippet = """
BizAppBar(
    title = "Home",
    onNavigationClick = { /* back */ }
) {
    BizIconButton(icon = Icons.Default.Search, onClick = {}, tint = Color.White)
}
                """.trimIndent(),
                viewFactory = {
                    Box(modifier = Modifier.fillMaxWidth().padding(32.dp), contentAlignment = Alignment.Center) {
                        BizAppBar(
                            title = "Home",
                            onNavigationClick = {}
                        ) {
                            BizIconButton(icon = Icons.Default.Search, onClick = {}, tint = Color.White)
                        }
                    }
                }
            ),
            UIComponent(
                name = "BizInfoCard",
                description = "An info/warning card for important messages.",
                codeSnippet = """
BizInfoCard(
    text = "This is a warning message.",
    type = BizInfoCardType.Warning
)
                """.trimIndent(),
                viewFactory = {
                    Box(modifier = Modifier.fillMaxWidth().padding(32.dp), contentAlignment = Alignment.Center) {
                        BizInfoCard(text = "Please check your network connection.")
                    }
                }
            ),
            UIComponent(
                name = "BizRating",
                description = "A 5-star rating component.",
                codeSnippet = """
var rating by remember { mutableIntStateOf(3) }
BizRating(
    rating = rating,
    onRatingChange = { rating = it }
)
                """.trimIndent(),
                viewFactory = {
                    var rating by remember { mutableIntStateOf(3) }
                    Box(modifier = Modifier.fillMaxWidth().padding(32.dp), contentAlignment = Alignment.Center) {
                        BizRating(rating = rating, onRatingChange = { rating = it })
                    }
                }
            ),
            UIComponent(
                name = "BizToast",
                description = "A custom toast notification.",
                codeSnippet = """
var showToast by remember { mutableStateOf(false) }
// ... button triggers showToast = true
BizToast(
    visible = showToast,
    message = "Action successful!",
    onDismiss = { showToast = false }
)
                """.trimIndent(),
                viewFactory = {
                    var showToast by remember { mutableStateOf(false) }
                    Box(modifier = Modifier.fillMaxSize().padding(16.dp), contentAlignment = Alignment.Center) {
                        Button(onClick = { showToast = true }) {
                            Text("Show Toast")
                        }
                        Box(modifier = Modifier.fillMaxSize(), contentAlignment = Alignment.BottomCenter) {
                            BizToast(
                                visible = showToast,
                                message = "Action successful!",
                                onDismiss = { showToast = false }
                            )
                        }
                    }
                }
            ),
            UIComponent(
                name = "BizSkeleton",
                description = "A shimmer loading effect placeholder.",
                codeSnippet = """
BizSkeletonText(
    modifier = Modifier.width(200.dp)
)
                """.trimIndent(),
                viewFactory = {
                    Box(modifier = Modifier.fillMaxWidth().padding(32.dp), contentAlignment = Alignment.Center) {
                        Column(verticalArrangement = Arrangement.spacedBy(8.dp)) {
                            BizSkeletonText(modifier = Modifier.fillMaxWidth())
                            BizSkeletonText(modifier = Modifier.fillMaxWidth(0.8f))
                            BizSkeletonText(modifier = Modifier.fillMaxWidth(0.6f))
                        }
                    }
                }
            ),
            UIComponent(
                name = "BizProgressGauge",
                description = "A half-circle progress gauge.",
                codeSnippet = """
BizProgressGauge(
    value = 75f,
    max = 100f,
    label = "Completion"
)
                """.trimIndent(),
                viewFactory = {
                    Box(modifier = Modifier.fillMaxWidth().padding(32.dp), contentAlignment = Alignment.Center) {
                        BizProgressGauge(value = 75f, label = "Completion")
                    }
                }
            ),
            UIComponent(
                name = "BizAccountCard",
                description = "A card showing account balance.",
                codeSnippet = """
BizAccountCard(
    count = 2,
    balance = 12500.50,
    type = BizAccountCardType.Deposit
)
                """.trimIndent(),
                viewFactory = {
                    Box(modifier = Modifier.fillMaxWidth().padding(16.dp), contentAlignment = Alignment.Center) {
                        BizAccountCard(count = 2, balance = 12500.50)
                    }
                }
            ),
            UIComponent(
                name = "BizSegment",
                description = "A segmented control for tab selection.",
                codeSnippet = """
var selected by remember { mutableIntStateOf(0) }
BizSegment(
    items = listOf("Day", "Week", "Month"),
    selectedIndex = selected,
    onItemSelected = { selected = it }
)
                """.trimIndent(),
                viewFactory = {
                    var selected by remember { mutableIntStateOf(0) }
                    Box(modifier = Modifier.fillMaxWidth().padding(16.dp), contentAlignment = Alignment.Center) {
                        BizSegment(
                            items = listOf("Day", "Week", "Month"),
                            selectedIndex = selected,
                            onItemSelected = { selected = it }
                        )
                    }
                }
            ),
            UIComponent(
                name = "BizSlider",
                description = "A slider for numeric input.",
                codeSnippet = """
var value by remember { mutableFloatStateOf(50f) }
BizSlider(
    value = value,
    onValueChange = { value = it },
    label = "Volume",
    showValue = true
)
                """.trimIndent(),
                viewFactory = {
                    var value by remember { mutableFloatStateOf(50f) }
                    Box(modifier = Modifier.fillMaxWidth().padding(16.dp), contentAlignment = Alignment.Center) {
                        BizSlider(
                            value = value,
                            onValueChange = { value = it },
                            label = "Volume",
                            showValue = true
                        )
                    }
                }
            ),
            UIComponent(
                name = "BizPieChart",
                description = "A simple pie chart visualizing data segments.",
                codeSnippet = """
BizPieChart(
    data = listOf(
        BizPieSegment(40f, Color(0xFF1A75FF)),
        BizPieSegment(30f, Color(0xFFFF3366)),
        BizPieSegment(30f, Color(0xFF00CC66))
    )
)
                """.trimIndent(),
                viewFactory = {
                    Box(modifier = Modifier.fillMaxWidth().padding(32.dp), contentAlignment = Alignment.Center) {
                        BizPieChart(
                            data = listOf(
                                BizPieSegment(40f, Color(0xFF1A75FF)),
                                BizPieSegment(30f, Color(0xFFFF3366)),
                                BizPieSegment(30f, Color(0xFF00CC66))
                            ),
                            modifier = Modifier.size(200.dp)
                        )
                    }
                }
            ),
            UIComponent(
                name = "BizBarChart",
                description = "A simple bar chart visualizing data columns.",
                codeSnippet = """
BizBarChart(
    data = listOf(
        BizBarChartData(label = "Jan", value = 65f),
        BizBarChartData(label = "Feb", value = 59f),
        BizBarChartData(label = "Mar", value = 80f),
        BizBarChartData(label = "Apr", value = 81f),
        BizBarChartData(label = "May", value = 56f)
    )
)
                """.trimIndent(),
                viewFactory = {
                    Box(modifier = Modifier.fillMaxWidth().padding(16.dp)) {
                        BizBarChart(
                            data = listOf(
                                BizBarChartData(label = "Jan", value = 65f),
                                BizBarChartData(label = "Feb", value = 59f),
                                BizBarChartData(label = "Mar", value = 80f),
                                BizBarChartData(label = "Apr", value = 81f),
                                BizBarChartData(label = "May", value = 56f)
                            )
                        )
                    }
                }
            ),
            UIComponent(
                name = "BizLineChart",
                description = "A simple line chart visualizing trends.",
                codeSnippet = """
BizLineChart(
    data = listOf(65f, 59f, 80f, 81f, 56f, 55f, 40f),
    labels = listOf("Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun")
)
                """.trimIndent(),
                viewFactory = {
                    Box(modifier = Modifier.fillMaxWidth().padding(16.dp)) {
                        BizLineChart(
                            data = listOf(65f, 59f, 80f, 81f, 56f, 55f, 40f),
                            labels = listOf("Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun")
                        )
                    }
                }
            )
        )
    }

    if (selectedComponent == null) {
        Scaffold(
            topBar = { TopAppBar(title = { Text("UI Framework Components") }) }
        ) { padding ->
            LazyColumn(modifier = Modifier.padding(padding).fillMaxSize()) {
                items(components) { component ->
                    ListItem(
                        headlineContent = { Text(component.name) },
                        modifier = Modifier.clickable { selectedComponent = component }
                    )
                    HorizontalDivider()
                }
            }
        }
    } else {
        ComponentDetailScreen(
            component = selectedComponent!!,
            onBack = { selectedComponent = null }
        )
    }
}

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun ComponentDetailScreen(component: UIComponent, onBack: () -> Unit) {
    Scaffold(
        topBar = {
            TopAppBar(
                title = { Text(component.name) },
                navigationIcon = {
                    IconButton(onClick = onBack) {
                        Icon(Icons.Default.ArrowBack, contentDescription = "Back")
                    }
                }
            )
        }
    ) { padding ->
        Column(
            modifier = Modifier
                .padding(padding)
                .fillMaxSize()
        ) {
            // Component View
            Box(
                modifier = Modifier.weight(1f).fillMaxWidth(),
                contentAlignment = Alignment.TopCenter
            ) {
                component.viewFactory()
            }
            
            // Usage Guide
            Surface(
                color = MaterialTheme.colorScheme.surfaceVariant,
                shape = RoundedCornerShape(12.dp),
                modifier = Modifier
                    .fillMaxWidth()
                    .padding(16.dp)
            ) {
                Column(modifier = Modifier.padding(16.dp)) {
                    Text("Usage Guide", style = MaterialTheme.typography.titleLarge)
                    Spacer(modifier = Modifier.height(8.dp))
                    Text(component.description, style = MaterialTheme.typography.bodyMedium)
                    Spacer(modifier = Modifier.height(16.dp))
                    
                    // Code Block
                    CodeBlockView(code = component.codeSnippet)
                }
            }
        }
    }
}

@Composable
fun CodeBlockView(code: String) {
    val clipboardManager = LocalClipboardManager.current
    var copied by remember { mutableStateOf(false) }
    val scope = rememberCoroutineScope()
    
    Box(
        modifier = Modifier
            .fillMaxWidth()
            .background(Color(0xFF1E1E1E), RoundedCornerShape(8.dp))
            .padding(8.dp)
    ) {
        Column {
            Row(
                modifier = Modifier.fillMaxWidth(),
                horizontalArrangement = Arrangement.End
            ) {
                TextButton(onClick = {
                    clipboardManager.setText(AnnotatedString(code))
                    copied = true
                    scope.launch {
                        delay(2000)
                        copied = false
                    }
                }) {
                    Icon(
                        imageVector = if (copied) Icons.Default.Check else Icons.Default.ContentCopy,
                        contentDescription = "Copy",
                        tint = if (copied) Color.Green else Color.White,
                        modifier = Modifier.size(16.dp)
                    )
                    Spacer(modifier = Modifier.width(4.dp))
                    Text(
                        text = if (copied) "Copied!" else "Copy",
                        color = if (copied) Color.Green else Color.White,
                        style = MaterialTheme.typography.labelMedium
                    )
                }
            }
            Text(
                text = code,
                color = Color(0xFF4CAF50), // Green monospaced text
                fontFamily = FontFamily.Monospace,
                style = MaterialTheme.typography.bodySmall,
                modifier = Modifier.padding(horizontal = 8.dp, vertical = 4.dp)
            )
        }
    }
}