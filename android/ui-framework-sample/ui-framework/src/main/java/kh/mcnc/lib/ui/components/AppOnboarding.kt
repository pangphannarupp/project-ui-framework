package kh.mcnc.lib.ui.components

import androidx.compose.foundation.ExperimentalFoundationApi
import androidx.compose.foundation.background
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.pager.HorizontalPager
import androidx.compose.foundation.pager.rememberPagerState
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.material3.*
import androidx.compose.runtime.Composable
import androidx.compose.runtime.rememberCoroutineScope
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.unit.dp
import kotlinx.coroutines.launch

data class OnboardingPageData(
    val title: String,
    val description: String,
    // Using a placeholder color for the illustration area if no image is provided.
    // In a real app, this would typically be a DrawableRes Int.
    val illustrationColor: Color = Color(0xFFE5E7EB)
)

@OptIn(ExperimentalFoundationApi::class)
@Composable
fun AppOnboarding(
    pages: List<OnboardingPageData>,
    onFinish: () -> Unit,
    onSkip: () -> Unit,
    modifier: Modifier = Modifier
) {
    val pagerState = rememberPagerState(pageCount = { pages.size })
    val coroutineScope = rememberCoroutineScope()
    val isLastPage = pagerState.currentPage == pages.size - 1

    Column(
        modifier = modifier
            .fillMaxSize()
            .background(Color.White)
    ) {
        // Top Bar with Skip button
        Row(
            modifier = Modifier
                .fillMaxWidth()
                .padding(16.dp),
            horizontalArrangement = Arrangement.End
        ) {
            if (!isLastPage) {
                TextButton(onClick = onSkip) {
                    Text(
                        text = "Skip",
                        color = Color.Gray,
                        style = MaterialTheme.typography.labelLarge
                    )
                }
            } else {
                // Placeholder to keep height consistent
                Spacer(modifier = Modifier.height(48.dp))
            }
        }

        // Pager
        HorizontalPager(
            state = pagerState,
            modifier = Modifier.weight(1f)
        ) { pageIndex ->
            val page = pages[pageIndex]
            Column(
                modifier = Modifier
                    .fillMaxSize()
                    .padding(horizontal = 32.dp),
                horizontalAlignment = Alignment.CenterHorizontally,
                verticalArrangement = Arrangement.Center
            ) {
                // Illustration Placeholder
                Box(
                    modifier = Modifier
                        .size(240.dp)
                        .clip(CircleShape)
                        .background(page.illustrationColor),
                    contentAlignment = Alignment.Center
                ) {
                    Text(
                        text = "Illustration",
                        color = Color.DarkGray,
                        style = MaterialTheme.typography.bodyMedium
                    )
                }
                
                Spacer(modifier = Modifier.height(48.dp))
                
                // Text Content
                Text(
                    text = page.title,
                    style = MaterialTheme.typography.headlineSmall,
                    fontWeight = FontWeight.Bold,
                    color = Color.Black,
                    textAlign = TextAlign.Center
                )
                
                Spacer(modifier = Modifier.height(16.dp))
                
                Text(
                    text = page.description,
                    style = MaterialTheme.typography.bodyLarge,
                    color = Color.Gray,
                    textAlign = TextAlign.Center
                )
            }
        }

        // Bottom Controls
        Row(
            modifier = Modifier
                .fillMaxWidth()
                .padding(32.dp),
            horizontalArrangement = Arrangement.SpaceBetween,
            verticalAlignment = Alignment.CenterVertically
        ) {
            // Page Indicators
            Row(
                horizontalArrangement = Arrangement.spacedBy(8.dp),
                verticalAlignment = Alignment.CenterVertically
            ) {
                repeat(pages.size) { iteration ->
                    val color = if (pagerState.currentPage == iteration) {
                        MaterialTheme.colorScheme.primary
                    } else {
                        Color.LightGray
                    }
                    val width = if (pagerState.currentPage == iteration) 24.dp else 8.dp
                    
                    Box(
                        modifier = Modifier
                            .height(8.dp)
                            .width(width)
                            .clip(CircleShape)
                            .background(color)
                    )
                }
            }

            // Next / Get Started Button
            Button(
                onClick = {
                    if (isLastPage) {
                        onFinish()
                    } else {
                        coroutineScope.launch {
                            pagerState.animateScrollToPage(pagerState.currentPage + 1)
                        }
                    }
                },
                shape = CircleShape,
                contentPadding = PaddingValues(horizontal = 24.dp, vertical = 12.dp)
            ) {
                Text(
                    text = if (isLastPage) "Get Started" else "Next",
                    style = MaterialTheme.typography.labelLarge
                )
            }
        }
    }
}

@androidx.compose.ui.tooling.preview.Preview(showBackground = true, backgroundColor = 0xFFFFFFFF)
@Composable
fun AppOnboardingPreview() {
    MaterialTheme {
        AppOnboarding(
            pages = listOf(
                OnboardingPageData(
                    title = "Welcome to LOS",
                    description = "Manage your loan applications easily and efficiently all in one place.",
                    illustrationColor = Color(0xFFDBEAFE) // Light Blue
                ),
                OnboardingPageData(
                    title = "Track Approvals",
                    description = "Stay updated with real-time notifications on your application status.",
                    illustrationColor = Color(0xFFD1FAE5) // Light Green
                ),
                OnboardingPageData(
                    title = "Secure & Fast",
                    description = "Your data is encrypted and secure. Experience lightning fast processing.",
                    illustrationColor = Color(0xFFFEF3C7) // Light Yellow
                )
            ),
            onFinish = {},
            onSkip = {}
        )
    }
}
