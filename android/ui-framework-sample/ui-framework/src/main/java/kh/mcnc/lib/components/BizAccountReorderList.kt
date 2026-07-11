package kh.mcnc.lib.components

import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.itemsIndexed
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier

data class Account(
    val id: String = "",
    val name: String,
    val number: String,
    val balance: Double,
    val currency: String = "USD",
    val type: String = "Savings",
    var isHidden: Boolean = false
)

@Composable
fun BizAccountReorderList(
    accounts: List<Account>,
    isReorderMode: Boolean = false,
    onAccountsUpdate: (List<Account>) -> Unit = {},
    onItemClick: (Account) -> Unit = {},
    onActionClick: (Account) -> Unit = {},
    modifier: Modifier = Modifier
) {
    // Note: Reordering logic in Jetpack Compose usually requires pointerInput and dragGestures
    // or a 3rd party library like LazyColumn reorder.
    // Here we provide the standard non-draggable list visualization with simple handlers.
    LazyColumn(modifier = modifier) {
        itemsIndexed(accounts, key = { index, item -> item.id.ifEmpty { item.number } }) { index, item ->
            BizAccountListCard(
                accountName = item.name,
                accountNumber = item.number,
                balance = item.balance,
                currency = item.currency,
                type = item.type,
                isHidden = item.isHidden,
                onClick = { if (!isReorderMode) onItemClick(item) },
                onActionClick = { if (!isReorderMode) onActionClick(item) },
                onUpdateIsHidden = { hidden ->
                    val newAccounts = accounts.toMutableList()
                    newAccounts[index] = item.copy(isHidden = hidden)
                    onAccountsUpdate(newAccounts)
                }
            )
        }
    }
}
