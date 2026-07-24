import SwiftUI

public struct BizPhase6Batch1Demo: View {
    @State private var accounts = [
        BizAccountModel(accountName: "Saving Account", accountNumber: "99999-999-999", balance: 12500.50, currency: "USD", type: "Savings", isHidden: false),
        BizAccountModel(accountName: "Current Account", accountNumber: "11111-111-111", balance: 5000000.00, currency: "KHR", type: "Current", isHidden: false)
    ]
    
    @State private var isReorderMode = false
    @State private var selectedAccountIndex = 0
    
    public init() {}
    
    public var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                // Section 1: Account List Card & Reorder List
                VStack(alignment: .leading, spacing: 12) {
                    HStack {
                        Text("Account List")
                            .font(.headline)
                        Spacer()
                        Button(action: { isReorderMode.toggle() }) {
                            Text(isReorderMode ? "Done" : "Reorder")
                                .font(.subheadline)
                        }
                    }
                    
                    BizAccountReorderList(
                        accounts: $accounts,
                        isReorderMode: isReorderMode,
                        onItemClick: { acc in print("Clicked \(acc.accountName)") },
                        onActionClick: { acc in print("Action on \(acc.accountName)") }
                    )
                }
                
                // Section 2: Account Saving Card
                VStack(alignment: .leading, spacing: 12) {
                    Text("Account Saving Card")
                        .font(.headline)
                    
                    ForEach(0..<accounts.count, id: \.self) { index in
                        BizAccountSavingCard(
                            accountName: accounts[index].accountName,
                            accountNumber: accounts[index].accountNumber,
                            balance: accounts[index].balance,
                            currency: accounts[index].currency,
                            type: accounts[index].type,
                            isSelected: index == selectedAccountIndex,
                            onSelect: { selectedAccountIndex = index }
                        )
                    }
                }
                
                // Section 3: Action Cards
                VStack(alignment: .leading, spacing: 12) {
                    Text("Action Cards")
                        .font(.headline)
                    
                    HStack(spacing: 12) {
                        BizActionCard(
                            title: "Transfer",
                            subtitle: "Send money",
                            badgeColor: .blue,
                            iconName: "arrow.right.arrow.left"
                        )
                        
                        BizActionCard(
                            title: "Pay Bills",
                            subtitle: "Water, Electricity",
                            badgeCount: "3",
                            badgeColor: .orange
                        )
                    }
                }
                
                // Section 4: Upgrade & Verification
                VStack(alignment: .leading, spacing: 12) {
                    Text("Info Cards")
                        .font(.headline)
                    
                    BizUpgradeCard(
                        title: "Upgrade to Premium",
                        description: "Get more benefits and higher limits.",
                        iconContent: { Image(systemName: "star.fill") }
                    )
                    
                    BizVerificationCard(
                        title: "Verify your identity",
                        description: "Please upload your ID card.",
                        iconContent: { Image(systemName: "person.text.rectangle") }
                    )
                }
            }
            .padding(20)
        }
    }
}
