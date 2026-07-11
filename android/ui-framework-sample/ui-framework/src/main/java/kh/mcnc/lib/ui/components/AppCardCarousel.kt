package kh.mcnc.lib.ui.components

import androidx.compose.foundation.ExperimentalFoundationApi
import androidx.compose.foundation.background
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.pager.HorizontalPager
import androidx.compose.foundation.pager.PagerState
import androidx.compose.foundation.pager.rememberPagerState
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.Card
import androidx.compose.material3.CardDefaults
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.graphics.Brush
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.graphics.graphicsLayer
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.unit.dp
import kotlin.math.absoluteValue

data class CarouselCardData(
    val title: String,
    val subtitle: String,
    val amount: String,
    val gradientColors: List<Color>
)

@OptIn(ExperimentalFoundationApi::class)
@Composable
fun AppCardCarousel(
    cards: List<CarouselCardData>,
    modifier: Modifier = Modifier
) {
    val pagerState = rememberPagerState(pageCount = { cards.size })
    
    Column(
        modifier = modifier.fillMaxWidth(),
        horizontalAlignment = Alignment.CenterHorizontally
    ) {
        HorizontalPager(
            state = pagerState,
            contentPadding = PaddingValues(horizontal = 32.dp),
            modifier = Modifier.height(220.dp)
        ) { page ->
            val card = cards[page]
            val pageOffset = (pagerState.currentPage - page) + pagerState.currentPageOffsetFraction
            
            Card(
                modifier = Modifier
                    .fillMaxSize()
                    .padding(horizontal = 8.dp)
                    .graphicsLayer {
                        // Subtle 3D effect
                        val scale = 1f - (pageOffset.absoluteValue * 0.15f).coerceIn(0f, 0.2f)
                        scaleX = scale
                        scaleY = scale
                        alpha = 1f - (pageOffset.absoluteValue * 0.3f).coerceIn(0f, 0.5f)
                    },
                elevation = CardDefaults.cardElevation(
                    defaultElevation = if (pageOffset.absoluteValue < 0.1f) 8.dp else 2.dp
                ),
                shape = RoundedCornerShape(16.dp)
            ) {
                Box(
                    modifier = Modifier
                        .fillMaxSize()
                        .background(
                            brush = Brush.linearGradient(colors = card.gradientColors)
                        )
                        .padding(24.dp)
                ) {
                    Column(
                        modifier = Modifier.fillMaxSize(),
                        verticalArrangement = Arrangement.SpaceBetween
                    ) {
                        Column {
                            Text(
                                text = card.title,
                                style = MaterialTheme.typography.titleLarge,
                                color = Color.White,
                                fontWeight = FontWeight.Bold
                            )
                            Spacer(modifier = Modifier.height(4.dp))
                            Text(
                                text = card.subtitle,
                                style = MaterialTheme.typography.bodyMedium,
                                color = Color.White.copy(alpha = 0.8f)
                            )
                        }
                        
                        Text(
                            text = card.amount,
                            style = MaterialTheme.typography.headlineMedium,
                            color = Color.White,
                            fontWeight = FontWeight.Black
                        )
                    }
                }
            }
        }
        
        Spacer(modifier = Modifier.height(16.dp))
        
        // Pager Indicators
        Row(
            horizontalArrangement = Arrangement.Center,
            modifier = Modifier.fillMaxWidth()
        ) {
            repeat(cards.size) { iteration ->
                val color = if (pagerState.currentPage == iteration) 
                    MaterialTheme.colorScheme.primary 
                else 
                    Color.LightGray
                
                Box(
                    modifier = Modifier
                        .padding(4.dp)
                        .clip(RoundedCornerShape(percent = 50))
                        .background(color)
                        .size(if (pagerState.currentPage == iteration) 10.dp else 8.dp)
                )
            }
        }
    }
}
