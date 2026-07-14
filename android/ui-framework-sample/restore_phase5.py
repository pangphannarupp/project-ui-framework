import os

file_path = '/Volumes/SSD/Projects/GitHub/project-ui-framework/android/ui-framework-sample/app/src/main/java/mcnc/app/ui_framework_sample/MainActivity.kt'

with open(file_path, 'r') as f:
    content = f.read()

# We need to find the "Phase 5 Pickers & Calendars (Batch 2)" UIComponent block
# The script auto_fix.py replaced it with Text("Temporarily disabled due to compiler error")
# Let's find it.
start_str = 'name = "Phase 5 Pickers & Calendars (Batch 2)",'
end_str = '            UIComponent(\n                name = "Phase 6'

if start_str in content and end_str in content:
    start_idx = content.find(start_str)
    # The viewFactory is right after this
    vf_start = content.find('viewFactory = {', start_idx)
    # find the matching brace for viewFactory
    open_braces = 0
    vf_end = -1
    for i in range(vf_start, len(content)):
        if content[i] == '{': open_braces += 1
        elif content[i] == '}':
            open_braces -= 1
            if open_braces == 0:
                vf_end = i
                break
                
    replacement_code = """viewFactory = {
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
                        visible = showCalAlert,
                        onDismissRequest = { showCalAlert = false }
                    )
                    
                    BizCalendarSheet(
                        visible = showCalSheet,
                        onDismissRequest = { showCalSheet = false },
                        title = "Select Date"
                    )
                    
                    BizKhmerCalendarAlert(
                        visible = showKhmerCalAlert,
                        onDismissRequest = { showKhmerCalAlert = false }
                    )
                    
                    BizKhmerCalendarSheet(
                        visible = showKhmerCalSheet,
                        onDismissRequest = { showKhmerCalSheet = false },
                        title = "Select Lunar Date"
                    )
                    
                    BizMonthPickerAlert(
                        visible = showMonthAlert,
                        onDismissRequest = { showMonthAlert = false }
                    )
                    
                    BizMonthPickerSheet(
                        visible = showMonthSheet,
                        onDismissRequest = { showMonthSheet = false },
                        title = "Select Month"
                    )
                    
                    BizTimePickerAlert(
                        visible = showTimeAlert,
                        onDismissRequest = { showTimeAlert = false },
                        timeValue = timeValue,
                        title = "Select Time",
                        onTimeUpdate = { 
                            timeValue = it ?: ""
                        }
                    )
                    
                    BizTimePickerSheet(
                        visible = showTimeSheet,
                        onDismissRequest = { showTimeSheet = false },
                        timeValue = timeValue,
                        title = "Select Time",
                        onTimeUpdate = {
                            timeValue = it ?: ""
                        }
                    )
                }"""
                
    content = content[:vf_start] + replacement_code + content[vf_end+1:]
    with open(file_path, 'w') as f:
        f.write(content)
    print("Successfully restored Phase 5 block.")
else:
    print("Could not find the block boundaries.")
