import SwiftUI

public struct BizPhase6Batch2Demo: View {
    @State private var transferListSelection: [String] = ["1"]
    
    private let transferOptions = [
        BizTransferOption(key: "1", label: "Option 1"),
        BizTransferOption(key: "2", label: "Option 2"),
        BizTransferOption(key: "3", label: "Option 3"),
        BizTransferOption(key: "4", label: "Option 4 (Disabled)", disabled: true),
        BizTransferOption(key: "5", label: "Option 5"),
    ]
    
    @State private var isFabActive = false
    
    public init() {}
    
    public var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                // Section 1: Notification Item
                VStack(alignment: .leading, spacing: 12) {
                    Text("Notification Item")
                        .font(.headline)
                    
                    BizNotificationItem(
                        title: "Transaction Successful",
                        description: "Your transfer of $100.00 to account 1234 was successful.",
                        timestamp: "Today, 10:30 AM",
                        unread: true,
                        onClick: { print("Notification Clicked") },
                        onDetailClick: { print("Detail Clicked") },
                        iconContent: { Image(systemName: "arrow.right.arrow.left") }
                    )
                    
                    BizNotificationItem(
                        title: "System Update",
                        description: "The system will be down for maintenance.",
                        timestamp: "Yesterday, 11:00 PM",
                        unread: false,
                        iconContent: { Image(systemName: "gear") }
                    )
                }
                
                // Section 2: User Profile
                VStack(alignment: .leading, spacing: 12) {
                    Text("User Profile")
                        .font(.headline)
                    
                    VStack(spacing: 16) {
                        BizUserProfile(
                            userName: "John Doe",
                            role: "Premium Member",
                            isVerified: true
                        )
                        
                        BizUserProfile(
                            userName: "Alice Smith",
                            role: "User",
                            isVerified: false
                        )
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color(hex: "#1A2A5E"))
                    .cornerRadius(12)
                }
                
                // Section 3: Transfer List
                VStack(alignment: .leading, spacing: 12) {
                    Text("Transfer List (Outlined)")
                        .font(.headline)
                    
                    BizTransferList(
                        modelValue: $transferListSelection,
                        data: transferOptions,
                        variant: .outlined,
                        onChange: { newValue, direction, moved in
                            print("TransferList changed: \(direction) moved \(moved)")
                        }
                    )
                    
                    Text("Transfer List (Filled)")
                        .font(.headline)
                        .padding(.top, 12)
                    
                    BizTransferList(
                        modelValue: $transferListSelection,
                        data: transferOptions,
                        variant: .filled
                    )
                }
                
                // Section 4: FAB List & Action
                VStack(alignment: .leading, spacing: 12) {
                    Text("FAB List & Actions")
                        .font(.headline)
                    
                    HStack {
                        Spacer()
                        
                        ZStack(alignment: .bottom) {
                            BizFabList(side: .top, isActive: isFabActive) {
                                BizFabAction(color: .light) { Image(systemName: "pencil") }
                                BizFabAction(color: .primary) { Image(systemName: "folder") }
                                BizFabAction(color: .danger) { Image(systemName: "trash") }
                            }
                            .padding(.bottom, 60)
                            
                            BizFab(iconName: isFabActive ? "xmark" : "plus") {
                                isFabActive.toggle()
                            }
                        }
                        .frame(height: 200)
                        
                        Spacer()
                    }
                }
            }
            .padding(20)
        }
    }
}
