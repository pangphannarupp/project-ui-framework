package kh.mcnc.lib.ui

import androidx.activity.compose.BackHandler
import androidx.compose.foundation.background
import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.items
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.ArrowBack
import androidx.compose.material.icons.filled.Description
import androidx.compose.material.icons.filled.HelpOutline
import androidx.compose.material.icons.filled.PersonAdd
import androidx.compose.material.icons.filled.PostAdd
import androidx.compose.material.icons.filled.Search
import androidx.compose.material.icons.filled.Settings
import androidx.compose.material.icons.filled.Star
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.dp
import kh.mcnc.lib.ui.components.*
import kh.mcnc.lib.ui.components.calendar.AppKhmerCalendar
import kh.mcnc.lib.ui.components.calendar.CalendarConfig
import kh.mcnc.lib.ui.components.calendar.SelectionMode
import kh.mcnc.lib.ui.components.picker.*
import kh.mcnc.lib.ui.theme.AppSpacing
import kh.mcnc.lib.ui.theme.AppTheme
import kh.mcnc.lib.ui.theme.AppTypography
import kotlinx.coroutines.launch
import java.util.Calendar

data class GalleryItem(
    val title: String,
    val category: String,
    val content: @Composable (SnackbarHostState, () -> Unit) -> Unit
)

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun ComponentGalleryScreen(initialSelection: String? = null) {
    var selectedItem by remember { mutableStateOf<GalleryItem?>(null) }
    var searchQuery by remember { mutableStateOf("") }
    val snackbarHostState = remember { SnackbarHostState() }
    val scope = rememberCoroutineScope()

    var showPinScreen by remember { mutableStateOf(false) }
    var pinIsError by remember { mutableStateOf(false) }
    var pinErrorMsg by remember { mutableStateOf<String?>(null) }

    val allItems = remember {
        listOf(
            GalleryItem("Buttons", "Basic") { _, _ ->
                Column(verticalArrangement = Arrangement.spacedBy(16.dp)) {
                    AppPrimaryButton(text = "Primary Button", onClick = { })
                    AppSecondaryButton(text = "Secondary Button", onClick = { })
                    AppOutlinedButton(text = "Outlined Button", onClick = { })
                    AppPrimaryButton(text = "Loading Button", onClick = { }, isLoading = true)
                }
            },
            GalleryItem("Text Fields", "Basic") { _, _ ->
                var text by remember { mutableStateOf("") }
                Column(verticalArrangement = Arrangement.spacedBy(16.dp)) {
                    AppTextField(
                        value = text,
                        onValueChange = { text = it },
                        label = "Standard Input",
                        placeholder = "Enter text here"
                    )
                    AppTextField(
                        value = text,
                        onValueChange = { text = it },
                        label = "Error Input",
                        isError = true,
                        errorMessage = "This field is required"
                    )
                }
            },
            GalleryItem("Khmer Calendar (Dynamic Rows)", "Calendar") { _, _ ->
                AppKhmerCalendar(
                    config = CalendarConfig(
                        firstDayOfWeek = Calendar.SUNDAY,
                        selectionMode = SelectionMode.Single,
                        fixedWeekCount = 3,
                        showAdjacentMonths = true
                    )
                )
            },
            GalleryItem("Khmer Calendar (Range Select)", "Calendar") { _, _ ->
                val cal = Calendar.getInstance()
                val minD = cal.time
                cal.add(Calendar.MONTH, 2)
                val maxD = cal.time

                AppKhmerCalendar(
                    config = CalendarConfig(
                        firstDayOfWeek = Calendar.MONDAY,
                        selectionMode = SelectionMode.Range,
                        minDate = minD,
                        maxDate = maxD,
                        fixedWeekCount = 7
                    )
                )
            },
            GalleryItem("Currency Input", "Inputs") { _, _ ->
                var amount by remember { mutableStateOf("") }
                AppCurrencyTextField(
                    value = amount,
                    onValueChange = { amount = it },
                    label = "Loan Amount",
                    currencySymbol = "$"
                )
            },
            GalleryItem("Progress Stepper", "Navigation") { _, _ ->
                var currentStep by remember { mutableStateOf(1) }
                AppStepper(
                    steps = listOf("Personal", "Employment", "Loan", "Review"),
                    currentStepIndex = currentStep,
                    onStepClicked = { currentStep = it }
                )
            },
            GalleryItem("Searchable Bottom Sheet", "Sheets") { _, _ ->
                var showSearchSheet by remember { mutableStateOf(false) }
                var selectedProvince by remember { mutableStateOf("Select Province") }
                val provinces = listOf("Phnom Penh", "Siem Reap", "Battambang", "Kampot", "Kep", "Takeo", "Kandal")

                Column {
                    AppPrimaryButton(text = selectedProvince, onClick = { showSearchSheet = true })
                    AppSearchableBottomSheet(
                        isVisible = showSearchSheet,
                        onDismiss = { showSearchSheet = false },
                        title = "Select Province",
                        items = provinces,
                        itemLabel = { it },
                        onItemSelected = { selectedProvince = it }
                    )
                }
            },
            GalleryItem("Expandable Accordion", "Layout") { _, _ ->
                AppAccordion(
                    title = "Loan Schedule Details",
                    initiallyExpanded = true
                ) {
                    Text("Interest Rate: 1.5% per month")
                    Text("Tenor: 24 Months")
                    Text("Monthly Repayment: $500.00")
                }
            },
            GalleryItem("Swipe-to-Action Item", "Lists") { hostState, _ ->
                AppSwipeableItem(
                    onDelete = { scope.launch { hostState.showSnackbar("Deleted item") } },
                    onEdit = { scope.launch { hostState.showSnackbar("Edit item") } }
                ) {
                    ListItem(
                        headlineContent = { Text("Applicant Document.pdf") },
                        supportingContent = { Text("Swipe left to delete, right to edit") }
                    )
                }
            },
            GalleryItem("Custom Snackbar", "Feedback") { hostState, _ ->
                AppPrimaryButton(
                    text = "Show Success Snackbar",
                    onClick = {
                        scope.launch {
                            hostState.showSnackbar(
                                message = "Application submitted successfully!",
                                actionLabel = "Dismiss"
                            )
                        }
                    }
                )
            },
            GalleryItem("File Uploader", "Media") { _, _ ->
                var uploaderState by remember { mutableStateOf<UploaderState>(UploaderState.Empty) }
                AppFileUploader(
                    state = uploaderState,
                    onUploadClick = {
                        uploaderState = UploaderState.Loading
                        scope.launch {
                            kotlinx.coroutines.delay(1500)
                            uploaderState = UploaderState.Uploaded("National_ID_Card.pdf")
                        }
                    },
                    onRemoveClick = { uploaderState = UploaderState.Empty }
                )
            },
            GalleryItem("Timeline View", "Data") { _, _ ->
                val timelineItems = listOf(
                    TimelineItemData("Application Submitted", "By John Doe", "10:00 AM", isCompleted = true),
                    TimelineItemData("Under Review", "Checking documents", "11:30 AM", isCurrent = true),
                    TimelineItemData("Approved", "Pending final sign-off", null, isCompleted = false),
                    TimelineItemData("Disbursed", null, null, isCompleted = false)
                )
                AppTimeline(items = timelineItems)
            },
            GalleryItem("OTP Input", "Inputs") { _, _ ->
                var otpValue by remember { mutableStateOf("") }
                AppOtpInput(
                    otpValue = otpValue,
                    onOtpValueChange = { otpValue = it },
                    otpLength = 6
                )
            },
            GalleryItem("Skeleton Loading", "Feedback") { _, _ ->
                Row(verticalAlignment = Alignment.CenterVertically) {
                    Box(modifier = Modifier.size(48.dp).clip(CircleShape).appSkeleton())
                    Spacer(modifier = Modifier.width(16.dp))
                    Column {
                        Box(modifier = Modifier.width(120.dp).height(16.dp).appSkeleton())
                        Spacer(modifier = Modifier.height(8.dp))
                        Box(modifier = Modifier.width(80.dp).height(12.dp).appSkeleton())
                    }
                }
            },
            GalleryItem("Data Table", "Data") { _, _ ->
                data class DummyLoan(val id: String, val amount: String, val status: String)
                val dummyLoans = listOf(
                    DummyLoan("LN-001", "$5,000", "Active"),
                    DummyLoan("LN-002", "$12,000", "Pending"),
                    DummyLoan("LN-003", "$2,500", "Closed")
                )
                val columns = listOf(
                    DataColumn<DummyLoan>("Loan ID", width = 100.dp) { Text(it.id) },
                    DataColumn<DummyLoan>("Amount", width = 100.dp) { Text(it.amount) },
                    DataColumn<DummyLoan>("Status", width = 100.dp) { Text(it.status) }
                )
                AppDataTable(items = dummyLoans, columns = columns, modifier = Modifier.height(200.dp))
            },
            GalleryItem("Range Slider", "Inputs") { _, _ ->
                var sliderPosition by remember { mutableStateOf(1000f..5000f) }
                AppRangeSlider(
                    value = sliderPosition,
                    onValueChange = { sliderPosition = it },
                    valueRange = 0f..10000f,
                    title = "Filter Loan Amount",
                    formatValue = { "$${it.toInt()}" }
                )
            },
            GalleryItem("Digital Signature Pad", "Media") { _, _ ->
                AppSignaturePad()
            },
            GalleryItem("Interactive Line Chart", "Data") { _, _ ->
                AppLineChart(data = listOf(20f, 40f, 30f, 70f, 50f, 90f, 60f))
            },
            GalleryItem("Document Scanner Viewfinder", "Media") { _, _ ->
                Box(modifier = Modifier.fillMaxWidth().height(300.dp)) {
                    Spacer(modifier = Modifier.fillMaxSize().background(Color.Gray))
                    AppDocumentScannerView()
                }
            },
            GalleryItem("Expandable FAB Menu", "Navigation") { _, _ ->
                Box(modifier = Modifier.fillMaxWidth().height(200.dp)) {
                    AppExpandableFab(
                        actions = listOf(
                            FabAction(Icons.Default.PostAdd, "New Loan") {},
                            FabAction(Icons.Default.PersonAdd, "New Customer") {},
                            FabAction(Icons.Default.Description, "Scan Document") {}
                        ),
                        modifier = Modifier.align(Alignment.BottomEnd).padding(16.dp)
                    )
                }
            },
            GalleryItem("Circular Progress / Donut", "Data") { _, _ ->
                Row(modifier = Modifier.fillMaxWidth(), horizontalArrangement = Arrangement.Center) {
                    AppCircularProgress(progress = 0.75f, centerText = "750\nScore")
                }
            },
            GalleryItem("PDF Viewer Wrapper", "Media") { _, _ ->
                AppPdfViewer(fileDescriptor = null)
            },
            GalleryItem("Currency Keypad", "Inputs") { _, _ ->
                var keypadAmount by remember { mutableStateOf("") }
                Column {
                    Text(
                        text = if (keypadAmount.isEmpty()) "$0.00" else "$$keypadAmount",
                        style = AppTypography.headlineLarge,
                        color = MaterialTheme.colorScheme.primary,
                        modifier = Modifier.fillMaxWidth().padding(16.dp),
                        textAlign = androidx.compose.ui.text.style.TextAlign.Center
                    )
                    AppCurrencyKeypad(
                        onKeyPress = { keypadAmount += it },
                        onBackspace = { if (keypadAmount.isNotEmpty()) keypadAmount = keypadAmount.dropLast(1) }
                    )
                }
            },
            GalleryItem("Passcode Lock Screen", "Security") { _, _ ->
                AppPasscodePad(onPasscodeComplete = { }, isError = false)
            },
            GalleryItem("Interactive Card Carousel", "Lists") { _, _ ->
                AppCardCarousel(
                    cards = listOf(
                        CarouselCardData("Premium Account", "**** 1234", "$12,450.00", listOf(Color(0xFF1E3C72), Color(0xFF2A5298))),
                        CarouselCardData("Savings Account", "**** 5678", "$4,200.50", listOf(Color(0xFF00B4DB), Color(0xFF0083B0))),
                        CarouselCardData("Credit Card", "**** 9012", "-$340.20", listOf(Color(0xFFED213A), Color(0xFF93291E)))
                    )
                )
            },
            GalleryItem("Loan Comparison Table", "Data") { _, _ ->
                AppComparisonTable(
                    featureNames = listOf("Interest Rate", "Max Amount", "Term", "No Collateral"),
                    plans = listOf(
                        ComparisonPlan("Basic", "Free", false, listOf("8%", "$5K", "12 mo", false)),
                        ComparisonPlan("Premium", "$5/mo", true, listOf("5%", "$50K", "36 mo", true)),
                        ComparisonPlan("Business", "$15/mo", false, listOf("4%", "$250K", "60 mo", true))
                    )
                )
            },
            GalleryItem("Interactive Scratch Card", "Gamification") { _, _ ->
                AppScratchCard(
                    modifier = Modifier.fillMaxWidth().height(200.dp),
                    overlayColor = Color.LightGray
                ) {
                    Box(
                        modifier = Modifier.fillMaxSize().background(MaterialTheme.colorScheme.primaryContainer),
                        contentAlignment = Alignment.Center
                    ) {
                        Text(
                            text = "YOU WON 5% OFF!",
                            style = MaterialTheme.typography.headlineMedium,
                            color = MaterialTheme.colorScheme.onPrimaryContainer,
                            fontWeight = FontWeight.Bold
                        )
                    }
                }
            },
            GalleryItem("Biometric Prompt Overlay", "Security") { _, _ ->
                AppBiometricPrompt(onCancel = { })
            },
            GalleryItem("Draggable Grid Dashboard", "Layout") { _, _ ->
                val gridWidgets = remember {
                    mutableStateListOf(
                        DashboardWidget("1", "Overview", Color(0xFFE2B714)),
                        DashboardWidget("2", "Activity", Color(0xFF328332)),
                        DashboardWidget("3", "Stats", Color(0xFF8B2252)),
                        DashboardWidget("4", "Alerts", Color(0xFF4A708B))
                    )
                }
                AppDraggableGrid(
                    widgets = gridWidgets,
                    onReorder = { from, to ->
                        val item = gridWidgets.removeAt(from)
                        gridWidgets.add(to, item)
                    }
                )
            },
            GalleryItem("Pulsing Radar Animation", "Feedback") { _, _ ->
                Box(modifier = Modifier.fillMaxWidth().height(150.dp), contentAlignment = Alignment.Center) {
                    AppPulseAnimation {
                        Icon(imageVector = Icons.Default.Star, contentDescription = "Star", tint = Color.White)
                    }
                }
            },
            GalleryItem("Assistive Floating Menu", "Navigation") { _, _ ->
                Box(modifier = Modifier.fillMaxWidth().height(300.dp).background(Color.LightGray.copy(alpha = 0.2f))) {
                    AppFloatingMenu(
                        actions = listOf(
                            FloatingMenuAction(Icons.Default.Settings, "Settings") {},
                            FloatingMenuAction(Icons.Default.HelpOutline, "Help") {}
                        )
                    )
                }
            },
            GalleryItem("Animated Rating Bar", "Inputs") { _, _ ->
                var currentRating by remember { mutableStateOf(3) }
                Row(modifier = Modifier.fillMaxWidth(), horizontalArrangement = Arrangement.Center) {
                    AppRatingBar(rating = currentRating, onRatingChange = { currentRating = it })
                }
            },
            GalleryItem("Custom Video Player Wrapper", "Media") { _, _ ->
                AppVideoPlayer(title = "App Tutorial")
            },
            GalleryItem("Confetti Particle System", "Gamification") { _, _ ->
                Box(modifier = Modifier.fillMaxWidth().height(300.dp).background(Color.Black)) {
                    AppConfetti()
                    Text(
                        text = "LOAN APPROVED!",
                        style = MaterialTheme.typography.headlineLarge,
                        color = Color.White,
                        fontWeight = FontWeight.Black,
                        modifier = Modifier.align(Alignment.Center)
                    )
                }
            },
            GalleryItem("Gauge / Speedometer Chart", "Data") { _, _ ->
                AppGaugeChart(value = 750f, maxValue = 850f, title = "Credit Score")
            },
            GalleryItem("Rich Text Editor UI", "Inputs") { _, _ ->
                AppRichTextEditor()
            },
            GalleryItem("Scrolling Stock Ticker", "Data") { _, _ ->
                AppStockTicker(
                    items = listOf(
                        TickerItem("USD/KHR", "4,100", true),
                        TickerItem("EUR/USD", "1.09", false),
                        TickerItem("Prime Rate", "8.5%", false),
                        TickerItem("System", "All Systems Operational", true)
                    )
                )
            },
            GalleryItem("Hierarchical Tree Selector", "Sheets") { _, _ ->
                val treeNodes = listOf(
                    TreeNode("1", "Commercial", listOf(
                        TreeNode("1-1", "Real Estate"),
                        TreeNode("1-2", "Agriculture", listOf(
                            TreeNode("1-2-1", "Farming"),
                            TreeNode("1-2-2", "Livestock")
                        ))
                    )),
                    TreeNode("2", "Retail", listOf(
                        TreeNode("2-1", "Auto Loan"),
                        TreeNode("2-2", "Personal Loan")
                    ))
                )
                var selectedNode by remember { mutableStateOf<TreeNode?>(null) }
                Column {
                    AppTreeSelect(nodes = treeNodes, onNodeSelected = { selectedNode = it })
                    if (selectedNode != null) {
                        Text("Selected: ${selectedNode!!.label}", color = MaterialTheme.colorScheme.primary, modifier = Modifier.padding(start = 16.dp))
                    }
                }
            },
            GalleryItem("Data Heat Map (Activity)", "Data") { _, _ ->
                val heatMapData = List(60) { HeatMapData("Day $it", (0..15).random()) }
                AppHeatMap(data = heatMapData, columns = 10)
            },
            GalleryItem("Animated Network Status", "Feedback") { _, _ ->
                var networkState by remember { mutableStateOf(NetworkState.ONLINE) }
                Column {
                    Row(horizontalArrangement = Arrangement.spacedBy(8.dp), modifier = Modifier.padding(16.dp)) {
                        Button(onClick = { networkState = NetworkState.ONLINE }) { Text("Online") }
                        Button(onClick = { networkState = NetworkState.OFFLINE }) { Text("Offline") }
                        Button(onClick = { networkState = NetworkState.SYNCING }) { Text("Syncing") }
                    }
                    Box(modifier = Modifier.fillMaxWidth().height(50.dp)) {
                        AppNetworkStatus(state = networkState, autoHideOnline = false)
                    }
                }
            },
            GalleryItem("ID/Document Camera Capture UI", "Media") { _, _ ->
                AppCameraCapture()
            },
            GalleryItem("3D Credit Card Flip", "Gamification") { _, _ ->
                AppCardFlip()
            },
            GalleryItem("Animated Audio Recorder", "Media") { _, _ ->
                AppAudioRecorder()
            },
            GalleryItem("Document Cropper UI", "Media") { _, _ ->
                AppImageCropper()
            },
            GalleryItem("Custom Pull-to-Refresh Indicator", "Feedback") { _, _ ->
                Box(modifier = Modifier.fillMaxWidth().height(200.dp).background(Color.LightGray)) {
                    AppPullToRefresh(onRefresh = { kotlinx.coroutines.delay(2000) }) {
                        Column(
                            modifier = Modifier.fillMaxSize().padding(16.dp),
                            horizontalAlignment = Alignment.CenterHorizontally,
                            verticalArrangement = Arrangement.Center
                        ) {
                            Text("Pull down to refresh", style = MaterialTheme.typography.bodyLarge)
                        }
                    }
                }
            },
            GalleryItem("Approval Line UI", "Data") { _, _ ->
                val approvalNodes = listOf(
                    ApprovalNodeData(
                        dateText = "25 Jun, 2026 14:41:13",
                        name = "Phanna Pang",
                        role = "Credit Officer",
                        statusText = "Requested",
                        statusContainerColor = Color(0xFF3B82F6),
                        isCompleted = true,
                        remark = "No remark..."
                    ),
                    ApprovalNodeData(
                        dateText = "28 Jun, 2026 (Optional)",
                        name = "Bun Mit",
                        role = "Manager",
                        statusText = "Skipped",
                        statusContainerColor = Color(0xFF9CA3AF),
                        isCompleted = true
                    ),
                    ApprovalNodeData(
                        dateText = "28 Jun, 2026 (Optional)",
                        name = "Sopheak Thy",
                        role = "Director",
                        statusText = "Approved",
                        statusContainerColor = Color(0xFF10B981),
                        isCompleted = false,
                    )
                )
                AppApprovalLine(nodes = approvalNodes)
            },
            GalleryItem("Profile UI", "Layout") { _, _ ->
                AppProfile(
                    profileData = ProfileData(
                        name = "Phanna Pang",
                        title = "Manager",
                        infoItems = listOf(
                            ProfileInfoItem("User ID", "phanna"),
                            ProfileInfoItem("Mobile Number", "096 666 999"),
                            ProfileInfoItem("Email Address", "staff0028@gmail.com")
                        )
                    )
                )
            },
            GalleryItem("Onboarding UI", "Navigation") { _, _ ->
                Box(modifier = Modifier.fillMaxWidth().height(600.dp).clip(RoundedCornerShape(16.dp)).background(Color.White)) {
                    AppOnboarding(
                        pages = listOf(
                            OnboardingPageData("Welcome to LOS", "Manage your loan applications easily.", Color(0xFFDBEAFE)),
                            OnboardingPageData("Track Approvals", "Stay updated with real-time notifications.", Color(0xFFD1FAE5))
                        ),
                        onFinish = {},
                        onSkip = {}
                    )
                }
            },
            GalleryItem("Branch Locator Feature", "Layout") { _, _ ->
                Box(modifier = Modifier.fillMaxWidth().height(700.dp).clip(RoundedCornerShape(16.dp))) {
                    val sampleBranches = listOf(
                        kh.mcnc.lib.ui.components.branch.BranchData("1", "Main Branch", "0.01 km", "8am - 4pm", listOf("Coffee", "Korean")),
                        kh.mcnc.lib.ui.components.branch.BranchData("2", "Koh Pich Branch", "1.7 km", "8am - 4pm", listOf("Chinese"))
                    )
                    kh.mcnc.lib.ui.components.branch.AppBranchLocatorScreen(branches = sampleBranches)
                }
            },
            GalleryItem("Date Picker Bottom Sheet", "Sheets") { _, _ ->
                var showDatePicker by remember { mutableStateOf(false) }
                var selectionMode by remember { mutableStateOf(DatePickerSelectionMode.SINGLE) }
                var selectedSingleDate by remember { mutableStateOf<java.time.LocalDate?>(null) }
                var selectedRange by remember { mutableStateOf<Pair<java.time.LocalDate, java.time.LocalDate>?>(null) }

                Column(verticalArrangement = Arrangement.spacedBy(16.dp)) {
                    Row(modifier = Modifier.fillMaxWidth(), horizontalArrangement = Arrangement.SpaceEvenly) {
                        AppPrimaryButton(text = "Single", onClick = { selectionMode = DatePickerSelectionMode.SINGLE; showDatePicker = true })
                        AppPrimaryButton(text = "Range", onClick = { selectionMode = DatePickerSelectionMode.RANGE; showDatePicker = true })
                    }
                    val resultText = when (selectionMode) {
                        DatePickerSelectionMode.SINGLE -> "Result: ${selectedSingleDate ?: "None"}"
                        else -> "Result: ${selectedRange?.first ?: "..."} to ${selectedRange?.second ?: "..."}"
                    }
                    Text(resultText, style = MaterialTheme.typography.bodyMedium)
                }

                AppDatePickerBottomSheet(
                    showSheet = showDatePicker,
                    selectionMode = selectionMode,
                    minDate = java.time.LocalDate.now().minusDays(10),
                    maxDate = java.time.LocalDate.now().plusDays(20),
                    onDismissRequest = { showDatePicker = false },
                    onDateSelected = { selectedSingleDate = it },
                    onRangeSelected = { start, end -> selectedRange = Pair(start, end) }
                )
            },
            GalleryItem("PIN Entry Screen", "Security") { _, launchPin ->
                AppPrimaryButton(text = "Launch Full PIN Screen", onClick = launchPin)
            }
        )
    }

    LaunchedEffect(initialSelection, allItems) {
        if (initialSelection != null) {
            selectedItem = allItems.find { it.title == initialSelection }
        }
    }

    val filteredItems = remember(searchQuery, allItems) {
        if (searchQuery.isBlank()) allItems else allItems.filter {
            it.title.contains(searchQuery, ignoreCase = true) || it.category.contains(searchQuery, ignoreCase = true)
        }
    }

    // Handle system back button when a component is selected
    BackHandler(enabled = selectedItem != null) {
        selectedItem = null
    }

    AppTheme {
        Box(modifier = Modifier.fillMaxSize()) {
            Scaffold(
                snackbarHost = {
                    SnackbarHost(hostState = snackbarHostState) { data ->
                        AppSnackbar(snackbarData = data, type = AppSnackbarType.Success)
                    }
                },
                topBar = {
                    TopAppBar(
                        title = { Text(selectedItem?.title ?: "Component Gallery") },
                        navigationIcon = {
                            if (selectedItem != null) {
                                IconButton(onClick = { selectedItem = null }) {
                                    Icon(Icons.Default.ArrowBack, contentDescription = "Back")
                                }
                            }
                        },
                        colors = TopAppBarDefaults.topAppBarColors(
                            containerColor = MaterialTheme.colorScheme.primary,
                            titleContentColor = MaterialTheme.colorScheme.onPrimary,
                            navigationIconContentColor = MaterialTheme.colorScheme.onPrimary
                        )
                    )
                }
            ) { paddingValues ->
                if (selectedItem == null) {
                    Column(
                        modifier = Modifier
                            .fillMaxSize()
                            .padding(paddingValues)
                            .background(MaterialTheme.colorScheme.surfaceVariant.copy(alpha = 0.3f))
                    ) {
                        OutlinedTextField(
                            value = searchQuery,
                            onValueChange = { searchQuery = it },
                            placeholder = { Text("Search components...") },
                            modifier = Modifier
                                .fillMaxWidth()
                                .padding(16.dp),
                            leadingIcon = { Icon(Icons.Default.Search, null) },
                            singleLine = true,
                            colors = OutlinedTextFieldDefaults.colors(
                                focusedContainerColor = MaterialTheme.colorScheme.surface,
                                unfocusedContainerColor = MaterialTheme.colorScheme.surface
                            ),
                            shape = RoundedCornerShape(12.dp)
                        )

                        LazyColumn(
                            contentPadding = PaddingValues(horizontal = 16.dp, vertical = 8.dp),
                            verticalArrangement = Arrangement.spacedBy(8.dp)
                        ) {
                            items(filteredItems) { item ->
                                Card(
                                    modifier = Modifier
                                        .fillMaxWidth()
                                        .clickable { selectedItem = item },
                                    elevation = CardDefaults.cardElevation(defaultElevation = 2.dp),
                                    colors = CardDefaults.cardColors(containerColor = MaterialTheme.colorScheme.surface)
                                ) {
                                    Column(modifier = Modifier.padding(16.dp)) {
                                        Text(item.title, style = AppTypography.titleMedium, fontWeight = FontWeight.SemiBold)
                                        Spacer(modifier = Modifier.height(4.dp))
                                        Text(item.category, style = AppTypography.bodySmall, color = MaterialTheme.colorScheme.onSurfaceVariant)
                                    }
                                }
                            }
                        }
                    }
                } else {
                    Box(
                        modifier = Modifier
                            .fillMaxSize()
                            .padding(paddingValues)
                            .padding(16.dp),
                        contentAlignment = Alignment.Center
                    ) {
                        selectedItem?.content?.invoke(snackbarHostState) {
                            showPinScreen = true
                            pinIsError = false
                            pinErrorMsg = null
                        }
                    }
                }
            }

            if (showPinScreen) {
                kh.mcnc.lib.ui.components.pin.AppPinScreen(
                    title = "Enter PIN Again",
                    subtitle = "Pin will be used for transactions authorization. Never share your PIN.",
                    isError = pinIsError,
                    errorMessage = pinErrorMsg,
                    onPasscodeComplete = { pin ->
                        if (pin == "123456") {
                            showPinScreen = false
                        } else {
                            pinIsError = true
                            pinErrorMsg = "PIN does not match. Please try again."
                        }
                    },
                    onBack = { showPinScreen = false }
                )
            }
        }
    }
}

@Preview(showBackground = true)
@Composable
fun ComponentGalleryScreenPreview() {
    ComponentGalleryScreen()
}
