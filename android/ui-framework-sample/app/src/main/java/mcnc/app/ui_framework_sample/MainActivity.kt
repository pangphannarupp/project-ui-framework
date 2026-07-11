package mcnc.app.ui_framework_sample

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.activity.enableEdgeToEdge
import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.items
import androidx.compose.foundation.rememberScrollState
import androidx.compose.foundation.verticalScroll
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
import kh.mcnc.lib.components.BizCalendar
import kh.mcnc.lib.components.BizKhmerCalendar
import kh.mcnc.lib.utils.CalendarConfig
import kh.mcnc.lib.utils.SelectionMode
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
    text = "Click Me!",
    onClick = { /* Handle click */ }
)
                """.trimIndent(),
                viewFactory = {
                    Box(modifier = Modifier.fillMaxWidth().padding(32.dp), contentAlignment = Alignment.Center) {
                        BizButton(text = "Biz Compose Button", onClick = {})
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
            ),
            UIComponent(
                name = "BizCalendar",
                description = "A standard Gregorian calendar with range and single selection.",
                codeSnippet = """
BizCalendar(
    config = CalendarConfig(selectionMode = SelectionMode.Single),
    onDateSelected = { date -> /* Handle selection */ }
)
                """.trimIndent(),
                viewFactory = {
                    var mode by remember { mutableStateOf(SelectionMode.Single) }
                    var startDayIndex by remember { mutableStateOf(0) }
                    var minDateEnabled by remember { mutableStateOf(false) }
                    var maxDateEnabled by remember { mutableStateOf(false) }
                    var weeksBefore by remember { mutableStateOf(0) }
                    var weeksAfter by remember { mutableStateOf(0) }
                    var selectedDateEnabled by remember { mutableStateOf(false) }
                    var showBottomSheet by remember { mutableStateOf(false) }
                    var showAlert by remember { mutableStateOf(false) }

                    val today = remember { java.util.Date() }
                    val minDate = remember(minDateEnabled) { if (minDateEnabled) today else null }
                    val maxDate = remember(maxDateEnabled) { 
                        if (maxDateEnabled) {
                            val cal = java.util.Calendar.getInstance()
                            cal.time = today
                            cal.add(java.util.Calendar.DAY_OF_YEAR, 30)
                            cal.time
                        } else null 
                    }
                    val initialDate = remember(selectedDateEnabled) {
                        if (selectedDateEnabled) {
                            val cal = java.util.Calendar.getInstance()
                            cal.time = today
                            cal.add(java.util.Calendar.DAY_OF_YEAR, 2)
                            cal.time
                        } else today
                    }

                    val scrollState = rememberScrollState()
                    Column(modifier = Modifier.fillMaxWidth().padding(16.dp).verticalScroll(scrollState)) {
                        Text("Selection Mode", style = MaterialTheme.typography.labelSmall)
                        BizSegment(
                            items = listOf("Single", "Range", "Week"),
                            selectedIndex = mode.ordinal,
                            onItemSelected = { mode = SelectionMode.values()[it] }
                        )
                        Spacer(modifier = Modifier.height(8.dp))
                        
                        Text("Start Day", style = MaterialTheme.typography.labelSmall)
                        BizSegment(
                            items = listOf("Sunday", "Monday"),
                            selectedIndex = startDayIndex,
                            onItemSelected = { startDayIndex = it }
                        )
                        Spacer(modifier = Modifier.height(8.dp))

                        Row(verticalAlignment = Alignment.CenterVertically) {
                            Checkbox(checked = minDateEnabled, onCheckedChange = { minDateEnabled = it })
                            Text("Set Min Date (Today)", style = MaterialTheme.typography.bodySmall)
                        }
                        Row(verticalAlignment = Alignment.CenterVertically) {
                            Checkbox(checked = maxDateEnabled, onCheckedChange = { maxDateEnabled = it })
                            Text("Set Max Date (+30 Days)", style = MaterialTheme.typography.bodySmall)
                        }
                        Row(verticalAlignment = Alignment.CenterVertically) {
                            Checkbox(checked = selectedDateEnabled, onCheckedChange = { selectedDateEnabled = it })
                            Text("Initial Date (+2 Days)", style = MaterialTheme.typography.bodySmall)
                        }

                        Row(modifier = Modifier.fillMaxWidth(), horizontalArrangement = Arrangement.SpaceBetween) {
                            Column {
                                Text("Extra Weeks Before", style = MaterialTheme.typography.labelSmall)
                                Row(verticalAlignment = Alignment.CenterVertically) {
                                    IconButton(onClick = { if (weeksBefore > 0) weeksBefore-- }) { Icon(androidx.compose.material.icons.Icons.Default.ArrowBack, "") }
                                    Text(weeksBefore.toString())
                                    IconButton(onClick = { if (weeksBefore < 5) weeksBefore++ }) { Icon(androidx.compose.material.icons.Icons.Default.Check, "") }
                                }
                            }
                            Column {
                                Text("Extra Weeks After", style = MaterialTheme.typography.labelSmall)
                                Row(verticalAlignment = Alignment.CenterVertically) {
                                    IconButton(onClick = { if (weeksAfter > 0) weeksAfter-- }) { Icon(androidx.compose.material.icons.Icons.Default.ArrowBack, "") }
                                    Text(weeksAfter.toString())
                                    IconButton(onClick = { if (weeksAfter < 5) weeksAfter++ }) { Icon(androidx.compose.material.icons.Icons.Default.Check, "") }
                                }
                            }
                        }

                        Row(modifier = Modifier.fillMaxWidth(), horizontalArrangement = Arrangement.spacedBy(8.dp)) {
                            Button(
                                onClick = { showBottomSheet = true },
                                modifier = Modifier.weight(1f)
                            ) {
                                Text("Bottom Sheet")
                            }
                            Button(
                                onClick = { showAlert = true },
                                modifier = Modifier.weight(1f)
                            ) {
                                Text("Alert")
                            }
                        }
                        Spacer(modifier = Modifier.height(16.dp))
                        
                        BizCalendar(
                            config = CalendarConfig(
                                selectionMode = mode,
                                firstDayOfWeek = startDayIndex,
                                extraWeeksBefore = weeksBefore,
                                extraWeeksAfter = weeksAfter,
                                minDate = minDate,
                                maxDate = maxDate
                            ),
                            initialDate = initialDate,
                            onDateSelected = { _ -> },
                            onRangeSelected = { _, _ -> }
                        )
                    }

                    if (showBottomSheet) {
                        ModalBottomSheet(
                            onDismissRequest = { showBottomSheet = false },
                            sheetState = rememberModalBottomSheetState(skipPartiallyExpanded = true)
                        ) {
                            Column(modifier = Modifier.verticalScroll(rememberScrollState()).padding(bottom = 32.dp)) {
                                BizCalendar(
                                    config = CalendarConfig(
                                        selectionMode = mode,
                                        firstDayOfWeek = startDayIndex,
                                        extraWeeksBefore = weeksBefore,
                                        extraWeeksAfter = weeksAfter,
                                        minDate = minDate,
                                        maxDate = maxDate
                                    ),
                                    initialDate = initialDate,
                                    showActionButtons = true,
                                    onDateSelected = { _ -> },
                                    onRangeSelected = { _, _ -> },
                                    onCancel = { showBottomSheet = false },
                                    onConfirm = { _, _ -> showBottomSheet = false }
                                )
                            }
                        }
                    }

                    if (showAlert) {
                        androidx.compose.ui.window.Dialog(onDismissRequest = { showAlert = false }) {
                            androidx.compose.material3.Surface(
                                shape = androidx.compose.foundation.shape.RoundedCornerShape(16.dp),
                                color = androidx.compose.material3.MaterialTheme.colorScheme.surface
                            ) {
                                BizCalendar(
                                    config = CalendarConfig(
                                        selectionMode = mode,
                                        firstDayOfWeek = startDayIndex,
                                        extraWeeksBefore = weeksBefore,
                                        extraWeeksAfter = weeksAfter,
                                        minDate = minDate,
                                        maxDate = maxDate
                                    ),
                                    initialDate = initialDate,
                                    showActionButtons = true,
                                    onDateSelected = { _ -> },
                                    onRangeSelected = { _, _ -> },
                                    onCancel = { showAlert = false },
                                    onConfirm = { _, _ -> showAlert = false }
                                )
                            }
                        }
                    }
                }
            ),
            UIComponent(
                name = "BizMonthPicker",
                description = "A month picker for selecting single or range of months.",
                codeSnippet = "BizMonthPicker()",
                viewFactory = {
                    var mode by remember { mutableStateOf(SelectionMode.Single) }
                    var minDateEnabled by remember { mutableStateOf(false) }
                    var maxDateEnabled by remember { mutableStateOf(false) }
                    var showBottomSheet by remember { mutableStateOf(false) }
                    var showAlert by remember { mutableStateOf(false) }

                    val today = remember { java.util.Date() }
                    val minDate = remember(minDateEnabled) { if (minDateEnabled) today else null }
                    val maxDate = remember(maxDateEnabled) { 
                        if (maxDateEnabled) {
                            val cal = java.util.Calendar.getInstance()
                            cal.time = today
                            cal.add(java.util.Calendar.DAY_OF_YEAR, 30)
                            cal.time
                        } else null 
                    }

                    val scrollState = rememberScrollState()
                    Column(modifier = Modifier.fillMaxWidth().padding(16.dp).verticalScroll(scrollState)) {
                        Text("Selection Mode", style = MaterialTheme.typography.labelSmall)
                        BizSegment(
                            items = listOf("Single", "Range"),
                            selectedIndex = if (mode == SelectionMode.Single) 0 else 1,
                            onItemSelected = { mode = if (it == 0) SelectionMode.Single else SelectionMode.Range }
                        )
                        Spacer(modifier = Modifier.height(8.dp))
                        Row(modifier = Modifier.fillMaxWidth(), verticalAlignment = Alignment.CenterVertically) {
                            Checkbox(checked = minDateEnabled, onCheckedChange = { minDateEnabled = it })
                            Text("Set Min Date (Today)")
                        }
                        Row(modifier = Modifier.fillMaxWidth(), verticalAlignment = Alignment.CenterVertically) {
                            Checkbox(checked = maxDateEnabled, onCheckedChange = { maxDateEnabled = it })
                            Text("Set Max Date (+30 Days)")
                        }

                        Spacer(modifier = Modifier.height(16.dp))
                        Row(modifier = Modifier.fillMaxWidth(), horizontalArrangement = Arrangement.spacedBy(8.dp)) {
                            Button(
                                onClick = { showBottomSheet = true },
                                modifier = Modifier.weight(1f)
                            ) {
                                Text("Bottom Sheet")
                            }
                            Button(
                                onClick = { showAlert = true },
                                modifier = Modifier.weight(1f)
                            ) {
                                Text("Alert")
                            }
                        }
                        Spacer(modifier = Modifier.height(16.dp))

                        Box(
                            modifier = Modifier
                                .fillMaxWidth()
                                .background(Color.White, RoundedCornerShape(12.dp))
                                .border(1.dp, Color(0xFFE5E7EB), RoundedCornerShape(12.dp))
                                .padding(8.dp)
                        ) {
                            BizMonthPicker(
                                config = CalendarConfig(
                                    selectionMode = mode,
                                    minDate = minDate,
                                    maxDate = maxDate
                                ),
                                showActionButtons = false
                            )
                        }

                        if (showBottomSheet) {
                            androidx.compose.material3.ModalBottomSheet(
                                onDismissRequest = { showBottomSheet = false },
                                sheetState = androidx.compose.material3.rememberModalBottomSheetState(skipPartiallyExpanded = false)
                            ) {
                                Box(modifier = Modifier.fillMaxWidth().padding(16.dp)) {
                                    BizMonthPicker(
                                        config = CalendarConfig(
                                            selectionMode = mode,
                                            minDate = minDate,
                                            maxDate = maxDate
                                        ),
                                        showActionButtons = true,
                                        onCancel = { showBottomSheet = false },
                                        onConfirm = { _, _ -> showBottomSheet = false }
                                    )
                                }
                            }
                        }

                        if (showAlert) {
                            androidx.compose.ui.window.Dialog(onDismissRequest = { showAlert = false }) {
                                androidx.compose.material3.Surface(
                                    shape = androidx.compose.foundation.shape.RoundedCornerShape(16.dp),
                                    color = androidx.compose.material3.MaterialTheme.colorScheme.surface
                                ) {
                                    BizMonthPicker(
                                        config = CalendarConfig(
                                            selectionMode = mode,
                                            minDate = minDate,
                                            maxDate = maxDate
                                        ),
                                        showActionButtons = true,
                                        onCancel = { showAlert = false },
                                        onConfirm = { _, _ -> showAlert = false }
                                    )
                                }
                            }
                        }
                    }
                }
            ),
            UIComponent(
                name = "BizKhmerCalendar",
                description = "A Khmer calendar that shows Gregorian dates with lunar dates and zodiac information.",
                codeSnippet = """
BizKhmerCalendar(
    config = CalendarConfig(selectionMode = SelectionMode.Range),
    onDateSelected = { date, khmerDate, text -> /* Handle selection */ }
)
                """.trimIndent(),
                viewFactory = {
                    var mode by remember { mutableStateOf(SelectionMode.Single) }
                    var startDayIndex by remember { mutableStateOf(0) }
                    var minDateEnabled by remember { mutableStateOf(false) }
                    var maxDateEnabled by remember { mutableStateOf(false) }
                    var weeksBefore by remember { mutableStateOf(0) }
                    var weeksAfter by remember { mutableStateOf(0) }
                    var selectedDateEnabled by remember { mutableStateOf(false) }
                    var showBottomSheet by remember { mutableStateOf(false) }
                    var showAlert by remember { mutableStateOf(false) }

                    val today = remember { java.util.Date() }
                    val minDate = remember(minDateEnabled) { if (minDateEnabled) today else null }
                    val maxDate = remember(maxDateEnabled) { 
                        if (maxDateEnabled) {
                            val cal = java.util.Calendar.getInstance()
                            cal.time = today
                            cal.add(java.util.Calendar.DAY_OF_YEAR, 30)
                            cal.time
                        } else null 
                    }
                    val initialDate = remember(selectedDateEnabled) {
                        if (selectedDateEnabled) {
                            val cal = java.util.Calendar.getInstance()
                            cal.time = today
                            cal.add(java.util.Calendar.DAY_OF_YEAR, 2)
                            cal.time
                        } else today
                    }

                    val scrollState = rememberScrollState()
                    Column(modifier = Modifier.fillMaxWidth().padding(16.dp).verticalScroll(scrollState)) {
                        Text("Selection Mode", style = MaterialTheme.typography.labelSmall)
                        BizSegment(
                            items = listOf("Single", "Range", "Week"),
                            selectedIndex = mode.ordinal,
                            onItemSelected = { mode = SelectionMode.values()[it] }
                        )
                        Spacer(modifier = Modifier.height(8.dp))
                        
                        Text("Start Day", style = MaterialTheme.typography.labelSmall)
                        BizSegment(
                            items = listOf("Sunday", "Monday"),
                            selectedIndex = startDayIndex,
                            onItemSelected = { startDayIndex = it }
                        )
                        Spacer(modifier = Modifier.height(8.dp))

                        Row(verticalAlignment = Alignment.CenterVertically) {
                            Checkbox(checked = minDateEnabled, onCheckedChange = { minDateEnabled = it })
                            Text("Set Min Date (Today)", style = MaterialTheme.typography.bodySmall)
                        }
                        Row(verticalAlignment = Alignment.CenterVertically) {
                            Checkbox(checked = maxDateEnabled, onCheckedChange = { maxDateEnabled = it })
                            Text("Set Max Date (+30 Days)", style = MaterialTheme.typography.bodySmall)
                        }
                        Row(verticalAlignment = Alignment.CenterVertically) {
                            Checkbox(checked = selectedDateEnabled, onCheckedChange = { selectedDateEnabled = it })
                            Text("Initial Date (+2 Days)", style = MaterialTheme.typography.bodySmall)
                        }

                        Row(modifier = Modifier.fillMaxWidth(), horizontalArrangement = Arrangement.SpaceBetween) {
                            Column {
                                Text("Extra Weeks Before", style = MaterialTheme.typography.labelSmall)
                                Row(verticalAlignment = Alignment.CenterVertically) {
                                    IconButton(onClick = { if (weeksBefore > 0) weeksBefore-- }) { Icon(androidx.compose.material.icons.Icons.Default.ArrowBack, "") }
                                    Text(weeksBefore.toString())
                                    IconButton(onClick = { if (weeksBefore < 5) weeksBefore++ }) { Icon(androidx.compose.material.icons.Icons.Default.Check, "") }
                                }
                            }
                            Column {
                                Text("Extra Weeks After", style = MaterialTheme.typography.labelSmall)
                                Row(verticalAlignment = Alignment.CenterVertically) {
                                    IconButton(onClick = { if (weeksAfter > 0) weeksAfter-- }) { Icon(androidx.compose.material.icons.Icons.Default.ArrowBack, "") }
                                    Text(weeksAfter.toString())
                                    IconButton(onClick = { if (weeksAfter < 5) weeksAfter++ }) { Icon(androidx.compose.material.icons.Icons.Default.Check, "") }
                                }
                            }
                        }

                        Row(modifier = Modifier.fillMaxWidth(), horizontalArrangement = Arrangement.spacedBy(8.dp)) {
                            Button(
                                onClick = { showBottomSheet = true },
                                modifier = Modifier.weight(1f)
                            ) {
                                Text("Bottom Sheet")
                            }
                            Button(
                                onClick = { showAlert = true },
                                modifier = Modifier.weight(1f)
                            ) {
                                Text("Alert")
                            }
                        }
                        Spacer(modifier = Modifier.height(16.dp))
                        
                        BizKhmerCalendar(
                            config = CalendarConfig(
                                selectionMode = mode,
                                firstDayOfWeek = startDayIndex,
                                extraWeeksBefore = weeksBefore,
                                extraWeeksAfter = weeksAfter,
                                minDate = minDate,
                                maxDate = maxDate
                            ),
                            initialDate = initialDate,
                            onDateSelected = { _, _, _ -> },
                            onRangeSelected = { _, _, _, _, _, _ -> }
                        )
                    }

                    if (showBottomSheet) {
                        ModalBottomSheet(
                            onDismissRequest = { showBottomSheet = false },
                            sheetState = rememberModalBottomSheetState(skipPartiallyExpanded = true)
                        ) {
                            Column(modifier = Modifier.verticalScroll(rememberScrollState()).padding(bottom = 32.dp)) {
                                BizKhmerCalendar(
                                    config = CalendarConfig(
                                        selectionMode = mode,
                                        firstDayOfWeek = startDayIndex,
                                        extraWeeksBefore = weeksBefore,
                                        extraWeeksAfter = weeksAfter,
                                        minDate = minDate,
                                        maxDate = maxDate
                                    ),
                                    initialDate = initialDate,
                                    showActionButtons = true,
                                    onDateSelected = { _, _, _ -> },
                                    onRangeSelected = { _, _, _, _, _, _ -> },
                                    onCancel = { showBottomSheet = false },
                                    onConfirm = { _, _ -> showBottomSheet = false }
                                )
                            }
                        }
                    }

                    if (showAlert) {
                        androidx.compose.ui.window.Dialog(onDismissRequest = { showAlert = false }) {
                            androidx.compose.material3.Surface(
                                shape = androidx.compose.foundation.shape.RoundedCornerShape(16.dp),
                                color = androidx.compose.material3.MaterialTheme.colorScheme.surface
                            ) {
                                BizKhmerCalendar(
                                    config = CalendarConfig(
                                        selectionMode = mode,
                                        firstDayOfWeek = startDayIndex,
                                        extraWeeksBefore = weeksBefore,
                                        extraWeeksAfter = weeksAfter,
                                        minDate = minDate,
                                        maxDate = maxDate
                                    ),
                                    initialDate = initialDate,
                                    showActionButtons = true,
                                    onDateSelected = { _, _, _ -> },
                                    onRangeSelected = { _, _, _, _, _, _ -> },
                                    onCancel = { showAlert = false },
                                    onConfirm = { _, _ -> showAlert = false }
                                )
                            }
                        }
                    }
                }
            ),
            UIComponent(
                name = "BizButtonGroup",
                description = "A group of buttons that are visually connected together.",
                codeSnippet = "BizButtonGroup { BizButton(...) }",
                viewFactory = {
                    Column(verticalArrangement = Arrangement.spacedBy(24.dp), modifier = Modifier.padding(16.dp)) {
                        BizButtonGroup(vertical = false) {
                            BizButton(text = "Left", variant = BizButtonVariant.Outline, onClick = {})
                            BizButton(text = "Middle", variant = BizButtonVariant.Outline, onClick = {})
                            BizButton(text = "Right", variant = BizButtonVariant.Outline, onClick = {})
                        }
                        
                        BizButtonGroup(vertical = true) {
                            BizButton(text = "Top", variant = BizButtonVariant.Outline, onClick = {})
                            BizButton(text = "Middle", variant = BizButtonVariant.Outline, onClick = {})
                            BizButton(text = "Bottom", variant = BizButtonVariant.Outline, onClick = {})
                        }
                    }
                }
            ),
            UIComponent(
                name = "BizAutocomplete",
                description = "An input field that provides suggestions while typing.",
                codeSnippet = "BizAutocomplete(text = text, options = options)",
                viewFactory = {
                    var text by remember { mutableStateOf("") }
                    val options = listOf(
                        kh.mcnc.lib.components.AutocompleteOption("Apple", "apple"),
                        kh.mcnc.lib.components.AutocompleteOption("Banana", "banana"),
                        kh.mcnc.lib.components.AutocompleteOption("Cherry", "cherry")
                    )
                    Box(modifier = Modifier.padding(16.dp)) {
                        BizAutocomplete(
                            value = text,
                            onValueChange = { text = it },
                            label = "Select Fruit",
                            placeholder = "Search...",
                            options = options
                        )
                    }
                }
            ),
            UIComponent(
                name = "BizSelect",
                description = "A dropdown select input for choosing from a list of options.",
                codeSnippet = "BizSelect(selectedValue = val, options = opts)",
                viewFactory = {
                    var selectedValue by remember { mutableStateOf("") }
                    val options = listOf(
                        kh.mcnc.lib.components.SelectOption("Option 1", "1"),
                        kh.mcnc.lib.components.SelectOption("Option 2", "2"),
                        kh.mcnc.lib.components.SelectOption("Option 3", "3")
                    )
                    Column(verticalArrangement = Arrangement.spacedBy(24.dp), modifier = Modifier.padding(16.dp)) {
                        BizSelect(value = selectedValue, onValueChange = { selectedValue = it }, options = options, label = "Outlined", variant = kh.mcnc.lib.components.SelectVariant.Outlined)
                        BizSelect(value = selectedValue, onValueChange = { selectedValue = it }, options = options, label = "Filled", variant = kh.mcnc.lib.components.SelectVariant.Filled)
                        BizSelect(value = selectedValue, onValueChange = { selectedValue = it }, options = options, label = "Underlined", variant = kh.mcnc.lib.components.SelectVariant.Underlined)
                    }
                }
            ),
            UIComponent(
                name = "BizTimePicker",
                description = "A wheel picker to select a specific hour and minute.",
                codeSnippet = "BizTimePicker(time = time)",
                viewFactory = {
                    var time by remember { mutableStateOf("14:30") }
                    Column(modifier = Modifier.padding(16.dp)) {
                        Text("Selected Time: $time", style = MaterialTheme.typography.titleMedium)
                        Spacer(modifier = Modifier.height(16.dp))
                        BizTimePicker(
                            value = time,
                            onValueChange = { time = it },
                            title = "Select Time",
                            showActionButtons = true,
                            onConfirm = { time = it }
                        )
                    }
                }
            ),
            UIComponent(
                name = "BizScrollSegment",
                description = "A horizontally scrollable segment of tabs.",
                codeSnippet = "BizScrollSegment(selectedId = id, options = opts)",
                viewFactory = {
                    var selectedId by remember { mutableStateOf("1") }
                    val options = listOf(
                        kh.mcnc.lib.components.ScrollSegmentOption("1", "All"),
                        kh.mcnc.lib.components.ScrollSegmentOption("2", "Payments"),
                        kh.mcnc.lib.components.ScrollSegmentOption("3", "Transfers"),
                        kh.mcnc.lib.components.ScrollSegmentOption("4", "Deposits")
                    )
                    Box(modifier = Modifier.padding(16.dp)) {
                        BizScrollSegment(
                            selectedId = selectedId,
                            onSelected = { selectedId = it },
                            options = options
                        )
                    }
                }
            ),
            UIComponent(
                name = "BizBottomSheet",
                description = "A customizable bottom sheet that can be dragged down to dismiss.",
                codeSnippet = "BizBottomSheet(show = show) { ... }",
                viewFactory = {
                    var showSheet by remember { mutableStateOf(false) }
                    Box(modifier = Modifier.fillMaxSize().padding(16.dp)) {
                        BizButton(text = "Show Bottom Sheet", onClick = { showSheet = true })
                        
                        BizBottomSheet(
                            show = showSheet,
                            onDismissRequest = { showSheet = false },
                            header = { Text("Header Title", style = MaterialTheme.typography.titleMedium, modifier = Modifier.padding(bottom = 16.dp)) },
                            footer = { BizButton(text = "Confirm", onClick = { showSheet = false }) }
                        ) {
                            Column(modifier = Modifier.padding(16.dp)) {
                                Text("This is the bottom sheet content.")
                                Spacer(modifier = Modifier.height(100.dp))
                            }
                        }
                    }
                }
            ),
            UIComponent(
                name = "BizHideAppBar",
                description = "An app bar that hides when scrolling down and shows when scrolling up.",
                codeSnippet = "BizHideAppBar(header = { ... }) { ... }",
                viewFactory = {
                    BizHideAppBar(
                        header = {
                            Box(modifier = Modifier.fillMaxWidth().height(60.dp).background(Color.White), contentAlignment = Alignment.Center) {
                                Text("Auto-Hiding App Bar", style = MaterialTheme.typography.titleMedium)
                            }
                        }
                    ) {
                        Column(modifier = Modifier.padding(vertical = 16.dp), verticalArrangement = Arrangement.spacedBy(16.dp)) {
                            for (i in 0..20) {
                                Text("List Item $i", modifier = Modifier.fillMaxWidth().padding(horizontal = 16.dp).background(Color.White, RoundedCornerShape(8.dp)).padding(16.dp))
                            }
                        }
                    }
                }
            ),
            UIComponent(
                name = "BizUserCard",
                description = "A card displaying user information, avatar, and badges.",
                codeSnippet = "BizUserCard(name = \"John Doe\", phone = \"123\")",
                viewFactory = {
                    val scrollState = rememberScrollState()
                    Column(modifier = Modifier.fillMaxSize().background(Color(0xFFF4F5F8)).verticalScroll(scrollState).padding(16.dp), verticalArrangement = Arrangement.spacedBy(16.dp)) {
                        BizUserCard(
                            name = "John Doe",
                            phone = "012 345 678",
                            status = "Active",
                            isMaster = true,
                            hasSmartBiz = true,
                            hasSmartPay = true
                        )
                        BizUserCard(
                            name = "Alice Smith",
                            phone = "098 765 432",
                            status = "Pending",
                            isMaster = false,
                            hasSmartBiz = false,
                            hasSmartPay = true
                        )
                    }
                }
            ),
            UIComponent(
                name = "BizSwipeItem",
                description = "A list item that can be swiped to reveal left and right actions.",
                codeSnippet = "BizSwipeItem(leftActions = { ... }, rightActions = { ... }) { ... }",
                viewFactory = {
                    Column(modifier = Modifier.fillMaxSize().background(Color(0xFFF4F5F8)).padding(16.dp)) {
                        BizSwipeItem(
                            leftActions = {
                                Box(modifier = Modifier.fillMaxHeight().background(Color.Green).padding(horizontal = 20.dp), contentAlignment = Alignment.Center) {
                                    Text("Approve", color = Color.White)
                                }
                            },
                            rightActions = {
                                Box(modifier = Modifier.fillMaxHeight().background(Color.Red).padding(horizontal = 20.dp), contentAlignment = Alignment.Center) {
                                    Text("Delete", color = Color.White)
                                }
                            }
                        ) {
                            Box(modifier = Modifier.fillMaxWidth().background(Color.White).padding(16.dp)) {
                                Text("Swipe Me Left or Right")
                            }
                        }
                    }
                }
            ),
            UIComponent(
                name = "BizPullToRefresh",
                description = "A pull-to-refresh wrapper with custom animation.",
                codeSnippet = "BizPullToRefresh(isRefreshing = refreshing, onRefresh = { ... }) { ... }",
                viewFactory = {
                    var isRefreshing by remember { mutableStateOf(false) }
                    var items by remember { mutableStateOf(listOf("Item 1", "Item 2", "Item 3")) }
                    val scope = rememberCoroutineScope()
                    
                    BizPullToRefresh(
                        isRefreshing = isRefreshing,
                        onRefresh = {
                            isRefreshing = true
                            scope.launch {
                                kotlinx.coroutines.delay(1500)
                                items = listOf("New Item ${items.size + 1}") + items
                                isRefreshing = false
                            }
                        }
                    ) {
                        Column(modifier = Modifier.fillMaxSize().padding(16.dp), verticalArrangement = Arrangement.spacedBy(12.dp)) {
                            items.forEach { item ->
                                Text(item, modifier = Modifier.fillMaxWidth().background(Color.White, RoundedCornerShape(8.dp)).padding(16.dp))
                            }
                        }
                    }
                }
            ),
            UIComponent(
                name = "BizSkeleton",
                description = "Animated placeholders for loading states.",
                codeSnippet = "BizSkeletonList(count = 3)",
                viewFactory = {
                    val scrollState = rememberScrollState()
                    Column(modifier = Modifier.fillMaxSize().verticalScroll(scrollState).padding(16.dp), verticalArrangement = Arrangement.spacedBy(24.dp)) {
                        Text("Skeleton Items", style = MaterialTheme.typography.titleMedium)
                        Row(horizontalArrangement = Arrangement.spacedBy(16.dp)) {
                            BizSkeletonItem(variant = kh.mcnc.lib.components.SkeletonVariant.Circle, width = 48.dp, height = 48.dp)
                            Column(verticalArrangement = Arrangement.spacedBy(8.dp)) {
                                BizSkeletonItem(variant = kh.mcnc.lib.components.SkeletonVariant.Text, width = 150.dp, height = 16.dp)
                                BizSkeletonItem(variant = kh.mcnc.lib.components.SkeletonVariant.Text, width = 100.dp, height = 12.dp)
                            }
                        }
                        
                        Text("Skeleton List", style = MaterialTheme.typography.titleMedium)
                        BizSkeletonList(count = 3)
                        
                        Text("Skeleton Detail", style = MaterialTheme.typography.titleMedium)
                        BizSkeletonDetail(paragraphs = 2)
                    }
                }
            ),
            UIComponent(
                name = "BizNoResult",
                description = "A component to show empty states or no search results.",
                codeSnippet = "BizNoResult(title = \"No data\")",
                viewFactory = {
                    BizNoResult(title = "No Transactions") {
                        BizButton(text = "Go Home", variant = BizButtonVariant.Outline, onClick = {})
                    }
                }
            ),
            UIComponent(
                name = "BizToast",
                description = "A transient notification message.",
                codeSnippet = "BizToast(message = \"Done\", show = show)",
                viewFactory = {
                    var showToast by remember { mutableStateOf(false) }
                    Box(modifier = Modifier.fillMaxSize().padding(16.dp)) {
                        BizButton(text = "Show Toast", onClick = { showToast = true })
                        BizToast(
                            message = "Action successful!",
                            show = showToast,
                            onDismiss = { showToast = false }
                        )
                    }
                }
            ),
            UIComponent(
                name = "BizProgressGauge",
                description = "A circular gauge indicating progress.",
                codeSnippet = "BizProgressGauge(progress = 65f)",
                viewFactory = {
                    var progress by remember { mutableStateOf(65f) }
                    Column(modifier = Modifier.fillMaxSize().padding(16.dp), verticalArrangement = Arrangement.spacedBy(32.dp)) {
                        BizProgressGauge(progress = progress, title = "Monthly Goal")
                        BizSlider(value = progress, onValueChange = { progress = it }, valueRange = 0f..100f)
                    }
                }
            ),
            UIComponent(
                name = "BizRating",
                description = "A star rating component.",
                codeSnippet = "BizRating(rating = rating)",
                viewFactory = {
                    var rating by remember { mutableStateOf(3) }
                    Column(modifier = Modifier.fillMaxSize().padding(16.dp), verticalArrangement = Arrangement.spacedBy(16.dp)) {
                        Text("Rate your experience", style = MaterialTheme.typography.titleMedium)
                        BizRating(rating = rating, onRatingChanged = { rating = it })
                        Text("Selected: $rating stars")
                    }
                }
            ),
            UIComponent(
                name = "BizCharts",
                description = "Simple data visualization charts (Bar, Line, Pie).",
                codeSnippet = "BizBarChart(data = listOf(...))",
                viewFactory = {
                    val scrollState = rememberScrollState()
                    Column(modifier = Modifier.fillMaxSize().verticalScroll(scrollState).padding(16.dp), verticalArrangement = Arrangement.spacedBy(32.dp)) {
                        Text("Bar Chart", style = MaterialTheme.typography.titleMedium)
                        Box(modifier = Modifier.fillMaxWidth().height(200.dp)) {
                            BizBarChart(data = listOf(10f, 45f, 30f, 80f, 50f), labels = listOf("Mon", "Tue", "Wed", "Thu", "Fri"))
                        }
                        
                        Text("Line Chart", style = MaterialTheme.typography.titleMedium)
                        Box(modifier = Modifier.fillMaxWidth().height(200.dp)) {
                            BizLineChart(data = listOf(10f, 45f, 30f, 80f, 50f), labels = listOf("Mon", "Tue", "Wed", "Thu", "Fri"))
                        }
                        
                        Text("Pie Chart", style = MaterialTheme.typography.titleMedium)
                        Box(modifier = Modifier.fillMaxWidth().height(200.dp)) {
                            BizPieChart(data = listOf(30f, 50f, 20f), labels = listOf("Apples", "Bananas", "Cherries"))
                        }
                    }
                }
            ),
            UIComponent(
                name = "BizCheckboxGroup",
                description = "A group of checkboxes sharing a selection set.",
                codeSnippet = "BizCheckboxGroup(selection = selection, options = options)",
                viewFactory = {
                    var selection by remember { mutableStateOf(setOf("1")) }
                    val options = listOf(
                        kh.mcnc.lib.components.CheckboxOption("1", "Option A"),
                        kh.mcnc.lib.components.CheckboxOption("2", "Option B"),
                        kh.mcnc.lib.components.CheckboxOption("3", "Option C")
                    )
                    Column(modifier = Modifier.fillMaxSize().padding(16.dp), verticalArrangement = Arrangement.spacedBy(32.dp)) {
                        Text("Horizontal Checkbox Group", style = MaterialTheme.typography.titleMedium)
                        BizCheckboxGroup(selection = selection, options = options, onSelectionChange = { selection = it }, vertical = false)
                        
                        Text("Vertical Checkbox Group", style = MaterialTheme.typography.titleMedium)
                        BizCheckboxGroup(selection = selection, options = options, onSelectionChange = { selection = it }, vertical = true)
                    }
                }
            ),
            UIComponent(
                name = "BizRadioGroup",
                description = "A group of radio buttons for mutually exclusive selection.",
                codeSnippet = "BizRadioGroup(selection = selection, options = options)",
                viewFactory = {
                    var selection by remember { mutableStateOf<String?>("2") }
                    val options = listOf(
                        kh.mcnc.lib.components.RadioOption("1", "Option A"),
                        kh.mcnc.lib.components.RadioOption("2", "Option B"),
                        kh.mcnc.lib.components.RadioOption("3", "Option C")
                    )
                    Column(modifier = Modifier.fillMaxSize().padding(16.dp), verticalArrangement = Arrangement.spacedBy(32.dp)) {
                        Text("Horizontal Radio Group", style = MaterialTheme.typography.titleMedium)
                        BizRadioGroup(selection = selection, options = options, onSelectionChange = { selection = it }, vertical = false)
                        
                        Text("Vertical Radio Group", style = MaterialTheme.typography.titleMedium)
                        BizRadioGroup(selection = selection, options = options, onSelectionChange = { selection = it }, vertical = true)
                    }
                }
            ),
            UIComponent(
                name = "BizPhoneInput",
                description = "An input tailored for phone numbers with country code selector.",
                codeSnippet = "BizPhoneInput(value = phone)",
                viewFactory = {
                    var phone by remember { mutableStateOf("") }
                    Column(modifier = Modifier.fillMaxSize().background(Color(0xFFF4F5F8)).padding(16.dp), verticalArrangement = Arrangement.spacedBy(16.dp)) {
                        Text("Phone Input", style = MaterialTheme.typography.titleMedium)
                        BizPhoneInput(
                            value = phone,
                            onValueChange = { phone = it },
                            label = "Phone Number",
                            placeholder = "12 345 678"
                        )
                        Text("Value: $phone")
                    }
                }
            ),
            UIComponent(
                name = "BizNumberSpinner",
                description = "A numeric input with increment and decrement buttons.",
                codeSnippet = "BizNumberSpinner(value = count)",
                viewFactory = {
                    var count by remember { mutableStateOf(1) }
                    Column(modifier = Modifier.fillMaxSize().padding(16.dp), verticalArrangement = Arrangement.spacedBy(16.dp)) {
                        Text("Number Spinner", style = MaterialTheme.typography.titleMedium)
                        BizNumberSpinner(value = count, onValueChange = { count = it }, min = 0, max = 10)
                        Text("Current Value: $count")
                    }
                }
            ),
            UIComponent(
                name = "BizOtpInput",
                description = "A specialized input for One-Time Passwords with auto-advance.",
                codeSnippet = "BizOtpInput(value = otp, length = 6)",
                viewFactory = {
                    var otp by remember { mutableStateOf("") }
                    Column(modifier = Modifier.fillMaxSize().padding(16.dp), verticalArrangement = Arrangement.spacedBy(16.dp)) {
                        Text("OTP Input", style = MaterialTheme.typography.titleMedium)
                        BizOtpInput(value = otp, length = 6, onValueChange = { otp = it }, onComplete = { /* Handle completion */ })
                        Text("Value: $otp")
                    }
                }
            ),
            UIComponent(
                name = "BizPinDots",
                description = "Visual dots representing a secure PIN entry with animations.",
                codeSnippet = "BizPinDots(length = 6, value = pin)",
                viewFactory = {
                    var pin by remember { mutableStateOf("") }
                    var hasError by remember { mutableStateOf(false) }
                    var isSuccess by remember { mutableStateOf(false) }
                    
                    Column(modifier = Modifier.fillMaxSize().padding(16.dp), verticalArrangement = Arrangement.spacedBy(32.dp)) {
                        Text("PIN Dots", style = MaterialTheme.typography.titleMedium)
                        
                        BizPinDots(length = 6, value = pin, isError = hasError, isSuccess = isSuccess)
                        
                        BizTextField(
                            value = pin, 
                            onValueChange = { 
                                if (it.length <= 6) pin = it
                                hasError = false
                                isSuccess = false
                            },
                            label = "Simulate Typing PIN"
                        )
                        
                        Row(horizontalArrangement = Arrangement.spacedBy(16.dp)) {
                            BizButton(text = "Trigger Error", variant = BizButtonVariant.Outline, onClick = { hasError = true; isSuccess = false })
                            BizButton(text = "Trigger Success", variant = BizButtonVariant.Primary, onClick = { isSuccess = true; hasError = false })
                        }
                    }
                }
            ),
            UIComponent(
                name = "BizKeypad",
                description = "A standard numeric keypad for generic input.",
                codeSnippet = "BizKeypad(onPress = { val -> ... })",
                viewFactory = {
                    var input by remember { mutableStateOf("") }
                    Column(modifier = Modifier.fillMaxSize().padding(top = 16.dp)) {
                        Text("Input: $input", style = MaterialTheme.typography.titleLarge, modifier = Modifier.padding(16.dp))
                        Spacer(modifier = Modifier.weight(1f))
                        BizKeypad(
                            onPress = {
                                if (it == "backspace") {
                                    if (input.isNotEmpty()) input = input.dropLast(1)
                                } else {
                                    input += it
                                }
                            }
                        )
                    }
                }
            ),
            UIComponent(
                name = "BizSecureKeypad",
                description = "A randomized numeric keypad for secure PIN entry.",
                codeSnippet = "BizSecureKeypad(onPress = { val -> ... })",
                viewFactory = {
                    var input by remember { mutableStateOf("") }
                    Column(modifier = Modifier.fillMaxSize().padding(top = 16.dp)) {
                        Text("Secure Input: " + "*".repeat(input.length), style = MaterialTheme.typography.titleLarge, modifier = Modifier.padding(16.dp))
                        Spacer(modifier = Modifier.weight(1f))
                        BizSecureKeypad(
                            onPress = {
                                if (it == "backspace") {
                                    if (input.isNotEmpty()) input = input.dropLast(1)
                                } else {
                                    input += it
                                }
                            }
                        )
                    }
                }
            ),
            UIComponent(
                name = "BizSecureKeyboard",
                description = "A full randomized alphanumeric keyboard.",
                codeSnippet = "BizSecureKeyboard(onPress = { val -> ... })",
                viewFactory = {
                    var input by remember { mutableStateOf("") }
                    Column(modifier = Modifier.fillMaxSize().padding(top = 16.dp)) {
                        Text("Input: $input", style = MaterialTheme.typography.titleLarge, modifier = Modifier.padding(16.dp))
                        Spacer(modifier = Modifier.weight(1f))
                        BizSecureKeyboard(
                            onPress = {
                                if (it == "backspace") {
                                    if (input.isNotEmpty()) input = input.dropLast(1)
                                } else if (it == "enter") {
                                    input += "\n"
                                } else if (it != "emoji") {
                                    input += it
                                }
                            }
                        )
                    }
                }
            ),
            UIComponent(
                name = "BizKhmerKeyboard",
                description = "A randomized Khmer keyboard with shift and symbols.",
                codeSnippet = "BizKhmerKeyboard(onPress = { val -> ... })",
                viewFactory = {
                    var input by remember { mutableStateOf("") }
                    Column(modifier = Modifier.fillMaxSize().padding(top = 16.dp)) {
                        Text("Input: $input", style = MaterialTheme.typography.titleLarge, modifier = Modifier.padding(16.dp))
                        Spacer(modifier = Modifier.weight(1f))
                        BizKhmerKeyboard(
                            onPress = {
                                if (it == "backspace") {
                                    if (input.isNotEmpty()) input = input.dropLast(1)
                                } else if (it == "enter") {
                                    input += "\n"
                                } else if (it != "emoji") {
                                    input += it
                                }
                            }
                        )
                    }
                }
            ),
            
            // PHASE 5: Specialized Sheets & Dialogs
            UIComponent(
                name = "Phase 5 Sheets (Batch 1)",
                description = "BizConfirmSheet, BizFilterSheet, BizSortSheet, BizLanguageSheet, BizCountryCodeSheet, BizFeedbackSheet, BizBiometricSheet",
                codeSnippet = "BizConfirmSheet(...) / BizFilterSheet(...)",
                viewFactory = {
                    var showConfirm by remember { mutableStateOf(false) }
                    var showFilter by remember { mutableStateOf(false) }
                    var showSort by remember { mutableStateOf(false) }
                    var showLanguage by remember { mutableStateOf(false) }
                    var showCountryCode by remember { mutableStateOf(false) }
                    var showFeedback by remember { mutableStateOf(false) }
                    var showBiometric by remember { mutableStateOf(false) }
                    
                    var selectedFacilities by remember { mutableStateOf(emptyList<String>()) }
                    var selectedSort by remember { mutableStateOf("distance") }
                    var selectedLanguage by remember { mutableStateOf("en") }
                    var selectedCountryCode by remember { mutableStateOf("+855") }
                    
                    Column(
                        modifier = Modifier.fillMaxSize().padding(16.dp).verticalScroll(rememberScrollState()),
                        verticalArrangement = Arrangement.spacedBy(16.dp)
                    ) {
                        BizButton("Show Confirm Sheet", block = true) { showConfirm = true }
                        BizButton("Show Filter Sheet", block = true) { showFilter = true }
                        BizButton("Show Sort Sheet", block = true) { showSort = true }
                        BizButton("Show Language Sheet", block = true) { showLanguage = true }
                        BizButton("Show Country Code Sheet", block = true) { showCountryCode = true }
                        BizButton("Show Feedback Sheet", block = true) { showFeedback = true }
                        BizButton("Show Biometric Sheet", block = true) { showBiometric = true }
                        
                        Column(modifier = Modifier.padding(top = 24.dp)) {
                            Text("Selected Facilities: ${selectedFacilities.joinToString(", ")}")
                            Text("Selected Sort: $selectedSort")
                            Text("Selected Language: $selectedLanguage")
                            Text("Selected Country Code: $selectedCountryCode")
                        }
                    }
                    
                    BizConfirmSheet(
                        isVisible = showConfirm,
                        onDismissRequest = { showConfirm = false },
                        title = "Are you sure?",
                        subtitle = "This action cannot be undone.",
                        onConfirm = { showConfirm = false }
                    )
                    
                    BizFilterSheet(
                        isVisible = showFilter,
                        onDismissRequest = { showFilter = false },
                        selectedFacilities = selectedFacilities,
                        onApply = { 
                            selectedFacilities = it
                            showFilter = false
                        }
                    )
                    
                    BizSortSheet(
                        isVisible = showSort,
                        onDismissRequest = { showSort = false },
                        selectedSort = selectedSort,
                        onChange = { selectedSort = it }
                    )
                    
                    BizLanguageSheet(
                        isVisible = showLanguage,
                        onDismissRequest = { showLanguage = false },
                        selectedLanguage = selectedLanguage,
                        onChange = { selectedLanguage = it }
                    )
                    
                    BizCountryCodeSheet(
                        isVisible = showCountryCode,
                        onDismissRequest = { showCountryCode = false },
                        selectedCode = selectedCountryCode,
                        onChange = { selectedCountryCode = it }
                    )
                    
                    BizFeedbackSheet(
                        isVisible = showFeedback,
                        onDismissRequest = { showFeedback = false },
                        icon = "error",
                        title = "Action Required",
                        description = "Please check your input and try again.",
                        buttonText = "Okay",
                        onAction = { showFeedback = false }
                    )
                    
                    BizBiometricSheet(
                        isVisible = showBiometric,
                        onDismissRequest = { showBiometric = false },
                        type = "both",
                        onSetup = { showBiometric = false },
                        onLater = { showBiometric = false }
                    )
                }
            ),
            UIComponent(
                name = "Phase 5 Pickers & Calendars (Batch 2)",
                description = "BizCalendarAlert, BizCalendarSheet, BizKhmerCalendarAlert, BizKhmerCalendarSheet, BizMonthPickerAlert, BizMonthPickerSheet, BizTimePickerAlert, BizTimePickerSheet",
                codeSnippet = "BizCalendarAlert(...) / BizTimePickerSheet(...)",
                viewFactory = {
                    var showCalAlert by remember { mutableStateOf(false) }
                    var showCalSheet by remember { mutableStateOf(false) }
                    var showKhmerCalAlert by remember { mutableStateOf(false) }
                    var showKhmerCalSheet by remember { mutableStateOf(false) }
                    var showMonthAlert by remember { mutableStateOf(false) }
                    var showMonthSheet by remember { mutableStateOf(false) }
                    var showTimeAlert by remember { mutableStateOf(false) }
                    var showTimeSheet by remember { mutableStateOf(false) }
                    
                    var timeValue by remember { mutableStateOf("") }
                    
                    Column(
                        modifier = Modifier.fillMaxSize().padding(16.dp).verticalScroll(rememberScrollState()),
                        verticalArrangement = Arrangement.spacedBy(16.dp)
                    ) {
                        BizButton("Calendar Alert", block = true) { showCalAlert = true }
                        BizButton("Calendar Sheet", block = true) { showCalSheet = true }
                        BizButton("Khmer Calendar Alert", block = true) { showKhmerCalAlert = true }
                        BizButton("Khmer Calendar Sheet", block = true) { showKhmerCalSheet = true }
                        BizButton("Month Picker Alert", block = true) { showMonthAlert = true }
                        BizButton("Month Picker Sheet", block = true) { showMonthSheet = true }
                        BizButton("Time Picker Alert", block = true) { showTimeAlert = true }
                        BizButton("Time Picker Sheet", block = true) { showTimeSheet = true }
                        
                        Text("Selected Time: $timeValue", style = MaterialTheme.typography.bodySmall, modifier = Modifier.padding(top = 24.dp))
                    }
                    
                    BizCalendarAlert(
                        isVisible = showCalAlert,
                        onDismissRequest = { showCalAlert = false }
                    )
                    
                    BizCalendarSheet(
                        isVisible = showCalSheet,
                        onDismissRequest = { showCalSheet = false },
                        title = "Select Date"
                    )
                    
                    BizKhmerCalendarAlert(
                        isVisible = showKhmerCalAlert,
                        onDismissRequest = { showKhmerCalAlert = false }
                    )
                    
                    BizKhmerCalendarSheet(
                        isVisible = showKhmerCalSheet,
                        onDismissRequest = { showKhmerCalSheet = false },
                        title = "Select Lunar Date"
                    )
                    
                    BizMonthPickerAlert(
                        isVisible = showMonthAlert,
                        onDismissRequest = { showMonthAlert = false }
                    )
                    
                    BizMonthPickerSheet(
                        isVisible = showMonthSheet,
                        onDismissRequest = { showMonthSheet = false },
                        title = "Select Month"
                    )
                    
                    BizTimePickerAlert(
                        isVisible = showTimeAlert,
                        onDismissRequest = { showTimeAlert = false },
                        timeValue = timeValue,
                        title = "Select Time",
                        onConfirm = { 
                            timeValue = it ?: ""
                            showTimeAlert = false 
                        }
                    )
                    
                    BizTimePickerSheet(
                        isVisible = showTimeSheet,
                        onDismissRequest = { showTimeSheet = false },
                        timeValue = timeValue,
                        title = "Select Time",
                        onChange = { timeValue = it ?: "" },
                        onConfirm = {
                            timeValue = it ?: ""
                            showTimeSheet = false
                        }
                    )
                }
            ),
            
            // PHASE 6: Domain-Specific Cards & Lists
            UIComponent(
                name = "Phase 6 Cards & Lists (Batch 1)",
                description = "BizAccountListCard, BizAccountReorderList, BizAccountSavingCard, BizActionCard, BizUpgradeCard, BizVerificationCard",
                codeSnippet = "BizAccountSavingCard(...) / BizActionCard(...)",
                viewFactory = {
                    var selectedAccountIndex by remember { mutableStateOf(0) }
                    
                    Column(
                        modifier = Modifier.fillMaxSize().padding(16.dp).verticalScroll(rememberScrollState()),
                        verticalArrangement = Arrangement.spacedBy(24.dp)
                    ) {
                        // Section 1: Account List Card
                        Column(verticalArrangement = Arrangement.spacedBy(12.dp)) {
                            Text("Account List", style = MaterialTheme.typography.titleMedium)
                            
                            var isHidden1 by remember { mutableStateOf(false) }
                            BizAccountListCard(
                                accountName = "PPCBank Saving",
                                accountNumber = "99999-999-999",
                                balance = 12500.50,
                                currency = "USD",
                                type = "Savings",
                                isHidden = isHidden1,
                                onUpdateIsHidden = { isHidden1 = it },
                                onClick = {},
                                onActionClick = {}
                            )
                        }
                        
                        // Section 2: Account Saving Card
                        Column(verticalArrangement = Arrangement.spacedBy(12.dp)) {
                            Text("Account Saving Card", style = MaterialTheme.typography.titleMedium)
                            
                            BizAccountSavingCard(
                                accountName = "PPCBank Saving",
                                accountNumber = "99999-999-999",
                                balance = 12500.50,
                                currency = "USD",
                                type = "Savings",
                                isSelected = selectedAccountIndex == 0,
                                onClick = { selectedAccountIndex = 0 }
                            )
                            
                            BizAccountSavingCard(
                                accountName = "Current Account",
                                accountNumber = "11111-111-111",
                                balance = 5000000.0,
                                currency = "KHR",
                                type = "Current",
                                isSelected = selectedAccountIndex == 1,
                                onClick = { selectedAccountIndex = 1 }
                            )
                        }
                        
                        // Section 3: Action Cards
                        Column(verticalArrangement = Arrangement.spacedBy(12.dp)) {
                            Text("Action Cards", style = MaterialTheme.typography.titleMedium)
                            
                            Row(horizontalArrangement = Arrangement.spacedBy(12.dp)) {
                                Box(modifier = Modifier.weight(1f)) {
                                    BizActionCard(
                                        title = "Transfer",
                                        subtitle = "Send money",
                                        badgeColor = "blue",
                                        onClick = {}
                                    )
                                }
                                Box(modifier = Modifier.weight(1f)) {
                                    BizActionCard(
                                        title = "Pay Bills",
                                        subtitle = "Water, Electricity",
                                        badgeCount = "3",
                                        badgeColor = "orange",
                                        onClick = {}
                                    )
                                }
                            }
                        }
                        
                        // Section 4: Upgrade & Verification
                        Column(verticalArrangement = Arrangement.spacedBy(12.dp)) {
                            Text("Info Cards", style = MaterialTheme.typography.titleMedium)
                            
                            BizUpgradeCard(
                                title = "Upgrade to Premium",
                                description = "Get more benefits and higher limits."
                            )
                            
                            BizVerificationCard(
                                title = "Verify your identity",
                                description = "Please upload your ID card."
                            )
                        }
                    }
                }
            ),
            UIComponent(
                name = "Phase 6 Lists & Profiles (Batch 2)",
                description = "BizNotificationItem, BizTransferList, BizUserProfile, BizFabList, BizFabAction",
                codeSnippet = "BizNotificationItem(...) / BizTransferList(...)",
                viewFactory = {
                    var transferListSelection by remember { mutableStateOf(listOf("1")) }
                    val transferOptions = listOf(
                        kh.mcnc.lib.components.TransferOption(key = "1", label = "Option 1"),
                        kh.mcnc.lib.components.TransferOption(key = "2", label = "Option 2"),
                        kh.mcnc.lib.components.TransferOption(key = "3", label = "Option 3"),
                        kh.mcnc.lib.components.TransferOption(key = "4", label = "Option 4 (Disabled)", disabled = true),
                        kh.mcnc.lib.components.TransferOption(key = "5", label = "Option 5")
                    )
                    var isFabActive by remember { mutableStateOf(false) }
                    
                    Column(
                        modifier = Modifier.fillMaxSize().padding(16.dp).verticalScroll(rememberScrollState()),
                        verticalArrangement = Arrangement.spacedBy(24.dp)
                    ) {
                        // Section 1: Notification Item
                        Column(verticalArrangement = Arrangement.spacedBy(12.dp)) {
                            Text("Notification Item", style = MaterialTheme.typography.titleMedium)
                            
                            BizNotificationItem(
                                title = "Transaction Successful",
                                description = "Your transfer of $100.00 to account 1234 was successful.",
                                timestamp = "Today, 10:30 AM",
                                unread = true,
                                onClick = {},
                                onDetailClick = {},
                                icon = {
                                    Icon(
                                        imageVector = Icons.Default.SwapHoriz,
                                        contentDescription = null
                                    )
                                }
                            )
                        }
                        
                        // Section 2: User Profile
                        Column(verticalArrangement = Arrangement.spacedBy(12.dp)) {
                            Text("User Profile", style = MaterialTheme.typography.titleMedium)
                            
                            Box(modifier = Modifier.background(Color(0xFF1A2A5E), RoundedCornerShape(12.dp)).padding(16.dp)) {
                                Column(verticalArrangement = Arrangement.spacedBy(16.dp)) {
                                    BizUserProfile(
                                        userName = "John Doe",
                                        role = "Premium Member",
                                        isVerified = true
                                    )
                                    
                                    BizUserProfile(
                                        userName = "Alice Smith",
                                        role = "User",
                                        isVerified = false
                                    )
                                }
                            }
                        }
                        
                        // Section 3: Transfer List
                        Column(verticalArrangement = Arrangement.spacedBy(12.dp)) {
                            Text("Transfer List (Outlined)", style = MaterialTheme.typography.titleMedium)
                            
                            BizTransferList(
                                modelValue = transferListSelection,
                                data = transferOptions,
                                variant = "outlined",
                                onUpdateModelValue = { transferListSelection = it }
                            )
                        }
                        
                        // Section 4: FAB List & Action
                        Column(verticalArrangement = Arrangement.spacedBy(12.dp)) {
                            Text("FAB List & Actions", style = MaterialTheme.typography.titleMedium)
                            
                            Box(modifier = Modifier.fillMaxWidth().height(200.dp), contentAlignment = Alignment.BottomCenter) {
                                BizFabList(
                                    side = kh.mcnc.lib.components.BizFabSide.Top,
                                    isActive = isFabActive,
                                    modifier = Modifier.padding(bottom = 60.dp)
                                ) {
                                    BizFabAction(color = "light", onClick = {}) {
                                        Icon(imageVector = Icons.Default.Edit, contentDescription = null)
                                    }
                                    BizFabAction(color = "primary", onClick = {}) {
                                        Icon(imageVector = Icons.Default.Folder, contentDescription = null)
                                    }
                                    BizFabAction(color = "danger", onClick = {}) {
                                        Icon(imageVector = Icons.Default.Delete, contentDescription = null)
                                    }
                                }
                                
                                BizFab(
                                    icon = {
                                        Icon(
                                            imageVector = if (isFabActive) Icons.Default.Close else Icons.Default.Add,
                                            contentDescription = null
                                        )
                                    },
                                    onClick = { isFabActive = !isFabActive }
                                )
                            }
                        }
                    }
                }
            )
        )
    }

    var searchQuery by remember { mutableStateOf("") }
    
    val filteredComponents = remember(searchQuery, components) {
        if (searchQuery.isBlank()) {
            components
        } else {
            components.filter { it.name.contains(searchQuery, ignoreCase = true) }
        }
    }

    if (selectedComponent == null) {
        Scaffold(
            topBar = { TopAppBar(title = { Text("UI Framework Components") }) }
        ) { padding ->
            Column(modifier = Modifier.padding(padding).fillMaxSize()) {
                OutlinedTextField(
                    value = searchQuery,
                    onValueChange = { searchQuery = it },
                    modifier = Modifier.fillMaxWidth().padding(horizontal = 16.dp, vertical = 8.dp),
                    placeholder = { Text("Search components...") },
                    leadingIcon = { Icon(Icons.Default.Search, contentDescription = "Search") },
                    singleLine = true
                )
                LazyColumn(modifier = Modifier.fillMaxSize()) {
                    items(filteredComponents) { component ->
                        ListItem(
                            headlineContent = { Text(component.name) },
                            modifier = Modifier.clickable { selectedComponent = component }
                        )
                        HorizontalDivider()
                    }
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