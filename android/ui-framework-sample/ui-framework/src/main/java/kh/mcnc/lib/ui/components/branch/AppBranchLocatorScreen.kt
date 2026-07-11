package kh.mcnc.lib.ui.components.branch

import androidx.compose.foundation.background
import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.items
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.ArrowBackIosNew
import androidx.compose.material.icons.filled.FilterList
import androidx.compose.material.icons.filled.KeyboardArrowDown
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.unit.dp

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun AppBranchLocatorScreen(
    branches: List<BranchData>,
    onBackClick: () -> Unit = {},
    modifier: Modifier = Modifier
) {
    var showSortSheet by remember { mutableStateOf(false) }
    var showFilterSheet by remember { mutableStateOf(false) }
    
    var selectedSort by remember { mutableStateOf(SortOption.BY_DISTANCE) }
    var selectedFacilities by remember { mutableStateOf(setOf<String>()) }

    // Sort and filter logic based on selections
    val displayedBranches = remember(branches, selectedSort, selectedFacilities) {
        var filtered = branches
        if (selectedFacilities.isNotEmpty()) {
            filtered = filtered.filter { branch -> 
                branch.facilities.any { it in selectedFacilities }
            }
        }
        
        when (selectedSort) {
            SortOption.BY_DISTANCE -> filtered.sortedBy { it.distance }
            SortOption.BY_NAME -> filtered.sortedBy { it.name }
        }
    }

    // Use BottomSheetScaffold for the map and list
    val scaffoldState = rememberBottomSheetScaffoldState()

    BottomSheetScaffold(
        scaffoldState = scaffoldState,
        topBar = {
            // Top Bar
            Column(
                modifier = Modifier
                    .fillMaxWidth()
                    .clip(RoundedCornerShape(bottomStart = 24.dp, bottomEnd = 24.dp))
                    .background(
                        androidx.compose.ui.graphics.Brush.verticalGradient(
                            colors = listOf(Color(0xFF0E1B34), Color(0xFF3271D5))
                        )
                    )
                    .statusBarsPadding()
                    .padding(top = 8.dp, bottom = 24.dp, start = 16.dp, end = 16.dp)
            ) {
                IconButton(onClick = onBackClick) {
                    Icon(
                        imageVector = Icons.Default.ArrowBackIosNew,
                        contentDescription = "Back",
                        tint = Color.White
                    )
                }
                
                Spacer(modifier = Modifier.height(16.dp))
                
                Text(
                    text = "PPCBank Branch",
                    style = MaterialTheme.typography.headlineMedium,
                    fontWeight = FontWeight.Bold,
                    color = Color.White
                )
                
                Spacer(modifier = Modifier.height(8.dp))
                
                Text(
                    text = "Please find your nearest PPCBank branch with your convenience map and direction.",
                    style = MaterialTheme.typography.bodyMedium,
                    color = Color.White.copy(alpha = 0.8f)
                )
            }
        },
        sheetContainerColor = Color.White,
            sheetShape = RoundedCornerShape(topStart = 24.dp, topEnd = 24.dp),
            sheetPeekHeight = 250.dp,
            sheetContent = {
                Column(
                    modifier = Modifier
                        .fillMaxWidth()
                        .padding(horizontal = 16.dp)
                ) {
                    // Header Row: Sort and Filter
                    Row(
                        modifier = Modifier
                            .fillMaxWidth()
                            .padding(vertical = 16.dp),
                        horizontalArrangement = Arrangement.SpaceBetween,
                        verticalAlignment = Alignment.CenterVertically
                    ) {
                        // Sort Dropdown Trigger
                        Row(
                            verticalAlignment = Alignment.CenterVertically,
                            modifier = Modifier.clickable { showSortSheet = true }
                        ) {
                            val sortText = if (selectedSort == SortOption.BY_DISTANCE) "By Distance" else "By Name"
                            Text(
                                text = sortText,
                                style = MaterialTheme.typography.bodyMedium,
                                color = Color.Gray
                            )
                            Spacer(modifier = Modifier.width(4.dp))
                            Icon(
                                imageVector = Icons.Default.KeyboardArrowDown,
                                contentDescription = "Sort Options",
                                tint = Color.Gray,
                                modifier = Modifier.size(20.dp)
                            )
                        }

                        // Filter Icon
                        Box(
                            modifier = Modifier
                                .size(36.dp)
                                .clip(CircleShape)
                                .background(if (selectedFacilities.isNotEmpty()) Color(0xFFE0E7FF) else Color(0xFFF3F4F6))
                                .clickable { showFilterSheet = true },
                            contentAlignment = Alignment.Center
                        ) {
                            Icon(
                                imageVector = Icons.Default.FilterList,
                                contentDescription = "Filter Options",
                                tint = if (selectedFacilities.isNotEmpty()) Color(0xFF1E3A8A) else Color.Gray,
                                modifier = Modifier.size(20.dp)
                            )
                        }
                    }

                    // List of branches
                    LazyColumn(
                        contentPadding = PaddingValues(bottom = 24.dp),
                        verticalArrangement = Arrangement.spacedBy(16.dp)
                    ) {
                        items(displayedBranches) { branch ->
                            AppBranchCard(branch = branch)
                        }
                    }
                }
            },

        modifier = Modifier
            .fillMaxSize()
    ) { innerPadding ->
        // Map
        val cameraPositionState = com.google.maps.android.compose.rememberCameraPositionState {
            position = com.google.android.gms.maps.model.CameraPosition.fromLatLngZoom(
                com.google.android.gms.maps.model.LatLng(11.5564, 104.9282), 13f
            )
        }
        
        com.google.maps.android.compose.GoogleMap(
            modifier = Modifier.fillMaxSize(),
            contentPadding = innerPadding,
            cameraPositionState = cameraPositionState
        ) {
            displayedBranches.forEach { branch ->
                val position = com.google.android.gms.maps.model.LatLng(branch.latitude, branch.longitude)
                com.google.maps.android.compose.Marker(
                    state = com.google.maps.android.compose.MarkerState(position = position),
                    title = branch.name,
                    snippet = branch.distance
                )
            }
        }
        
        // Modals
        if (showSortSheet) {
            ModalBottomSheet(
                onDismissRequest = { showSortSheet = false },
                containerColor = Color.White
            ) {
                AppSortDialog(
                    selectedOption = selectedSort,
                    onOptionSelected = {
                        selectedSort = it
                        showSortSheet = false
                    }
                )
            }
        }

        if (showFilterSheet) {
            ModalBottomSheet(
                onDismissRequest = { showFilterSheet = false },
                containerColor = Color.White
            ) {
                AppFilterDialog(
                    selectedFacilities = selectedFacilities,
                    onFacilityClick = { facility ->
                        val newFacilities = selectedFacilities.toMutableSet()
                        if (newFacilities.contains(facility)) {
                            newFacilities.remove(facility)
                        } else {
                            newFacilities.add(facility)
                        }
                        selectedFacilities = newFacilities
                    }
                )
            }
        }
    }
}

@androidx.compose.ui.tooling.preview.Preview
@Composable
fun AppBranchLocatorScreenPreview() {
    val sampleBranches = listOf(
        BranchData(
            id = "1",
            name = "Main Branch",
            distance = "0.01 km",
            businessTime = "8am - 4pm",
            facilities = listOf("Coffee", "Korean", "Chinese")
        ),
        BranchData(
            id = "2",
            name = "Koh Pich Branch",
            distance = "1.7 km",
            businessTime = "8am - 4pm",
            facilities = listOf("Coffee", "Korean", "Chinese")
        ),
        BranchData(
            id = "3",
            name = "Toul Kork Branch",
            distance = "2.5 km",
            businessTime = "8am - 4pm",
            facilities = listOf("Coffee", "Korean", "Chinese")
        ),
        BranchData(
            id = "4",
            name = "BKK Branch",
            distance = "500 m",
            businessTime = "8am - 4pm",
            facilities = listOf("Coffee", "Korean", "Chinese")
        )
    )

    MaterialTheme {
        AppBranchLocatorScreen(branches = sampleBranches)
    }
}
