package kh.mcnc.lib.ui.components

import androidx.compose.foundation.background
import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.Edit
import androidx.compose.material.icons.filled.Person
import androidx.compose.material3.*
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp

data class ProfileInfoItem(
    val label: String,
    val value: String
)

data class ProfileData(
    val name: String,
    val title: String,
    val imageUrl: String? = null,
    val infoItems: List<ProfileInfoItem>
)

@Composable
fun AppProfile(
    profileData: ProfileData,
    onEditClick: () -> Unit = {},
    modifier: Modifier = Modifier
) {
    Column(
        modifier = modifier
            .fillMaxWidth()
            .background(Color(0xFFF2F2F2))
            .padding(top = 32.dp, bottom = 16.dp),
        horizontalAlignment = Alignment.CenterHorizontally
    ) {
        // Avatar Section
        Box(
            contentAlignment = Alignment.BottomEnd,
            modifier = Modifier.padding(bottom = 16.dp)
        ) {
            // Avatar Background
            Box(
                modifier = Modifier
                    .size(100.dp)
                    .clip(CircleShape)
                    .background(Color(0xFFD1D5DB)), // Light gray for avatar placeholder
                contentAlignment = Alignment.Center
            ) {
                Icon(
                    imageVector = Icons.Default.Person,
                    contentDescription = "Avatar",
                    tint = Color.White,
                    modifier = Modifier.size(60.dp)
                )
            }
            
            // Edit Icon
            Box(
                modifier = Modifier
                    .size(32.dp)
                    .offset(x = 4.dp, y = 4.dp)
                    .clip(CircleShape)
                    .background(Color.White)
                    .clickable { onEditClick() }
                    .padding(6.dp),
                contentAlignment = Alignment.Center
            ) {
                Icon(
                    imageVector = Icons.Default.Edit,
                    contentDescription = "Edit Profile",
                    tint = Color.Black,
                    modifier = Modifier.size(16.dp)
                )
            }
        }
        
        // Name & Title
        Text(
            text = profileData.name,
            style = MaterialTheme.typography.titleLarge,
            fontWeight = FontWeight.Bold,
            color = Color.Black,
            modifier = Modifier.padding(bottom = 4.dp)
        )
        Text(
            text = profileData.title,
            style = MaterialTheme.typography.bodyMedium,
            color = Color.Gray,
            modifier = Modifier.padding(bottom = 24.dp)
        )
        
        // Info Card
        Card(
            shape = RoundedCornerShape(topStart = 16.dp, topEnd = 16.dp), // The screenshot looks like the card connects to the bottom, but we'll round it nicely
            colors = CardDefaults.cardColors(containerColor = Color.White),
            elevation = CardDefaults.cardElevation(defaultElevation = 0.dp),
            modifier = Modifier
                .fillMaxWidth()
                .padding(horizontal = 0.dp)
        ) {
            Column(
                modifier = Modifier
                    .fillMaxWidth()
                    .padding(24.dp)
            ) {
                profileData.infoItems.forEachIndexed { index, item ->
                    ProfileInfoRow(
                        item = item,
                        isLast = index == profileData.infoItems.size - 1
                    )
                }
            }
        }
    }
}

@Composable
private fun ProfileInfoRow(
    item: ProfileInfoItem,
    isLast: Boolean
) {
    Column(
        modifier = Modifier.fillMaxWidth()
    ) {
        Text(
            text = item.label,
            style = MaterialTheme.typography.bodyMedium,
            color = Color.Gray,
            modifier = Modifier.padding(bottom = 4.dp)
        )
        Text(
            text = item.value,
            style = MaterialTheme.typography.bodyLarge,
            fontWeight = FontWeight.SemiBold,
            color = Color.Black,
            lineHeight = 22.sp
        )
        
        if (!isLast) {
            Spacer(modifier = Modifier.height(16.dp))
        }
    }
}

@androidx.compose.ui.tooling.preview.Preview(showBackground = true, backgroundColor = 0xFFF2F2F2)
@Composable
fun AppProfilePreview() {
    MaterialTheme {
        AppProfile(
            profileData = ProfileData(
                name = "Phanna Pang",
                title = "Manager",
                infoItems = listOf(
                    ProfileInfoItem("User ID", "phanna"),
                    ProfileInfoItem("Role", "Default Role, Credit Officer, System Admin"),
                    ProfileInfoItem("Mobile Number", "096 666 999"),
                    ProfileInfoItem("Email Address", "staff0028@gmail.com"),
                    ProfileInfoItem("Branch Code", "KH0010001"),
                    ProfileInfoItem("Branch Name", "Head Office 1"),
                    ProfileInfoItem("Team", "Phanna\nPhanna\nPhanna"),
                    ProfileInfoItem("Home Address", "Phnom Penh")
                )
            )
        )
    }
}
