import SwiftUI

public struct BizAccountModel: Identifiable, Equatable {
    public let id = UUID()
    public var accountName: String
    public var accountNumber: String
    public var balance: Double
    public var currency: String
    public var type: String
    public var isHidden: Bool
    
    public init(accountName: String, accountNumber: String, balance: Double, currency: String, type: String, isHidden: Bool) {
        self.accountName = accountName
        self.accountNumber = accountNumber
        self.balance = balance
        self.currency = currency
        self.type = type
        self.isHidden = isHidden
    }
}

public struct BizAccountReorderList: View {
    @Binding var accounts: [BizAccountModel]
    var isReorderMode: Bool
    var onItemClick: ((BizAccountModel) -> Void)?
    var onActionClick: ((BizAccountModel) -> Void)?
    
    public init(
        accounts: Binding<[BizAccountModel]>,
        isReorderMode: Bool = false,
        onItemClick: ((BizAccountModel) -> Void)? = nil,
        onActionClick: ((BizAccountModel) -> Void)? = nil
    ) {
        self._accounts = accounts
        self.isReorderMode = isReorderMode
        self.onItemClick = onItemClick
        self.onActionClick = onActionClick
    }
    
    public var body: some View {
        if isReorderMode {
            // Reorderable list
            List {
                ForEach($accounts) { $account in
                    BizAccountListCard(
                        accountName: account.accountName,
                        accountNumber: account.accountNumber,
                        balance: account.balance,
                        currency: account.currency,
                        type: account.type,
                        isHidden: $account.isHidden,
                        actionContent: {
                            Image(systemName: "line.3.horizontal")
                                .font(.system(size: 20))
                                .foregroundColor(Color(hex: "#999999"))
                        }
                    )
                    .hideListRowSeparator()
                    .listRowBackground(Color.clear)
                    .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 12, trailing: 0))
                }
                .onMove { indices, newOffset in
                    accounts.move(fromOffsets: indices, toOffset: newOffset)
                }
            }
            .listStyle(.plain)
            .environment(\.editMode, .constant(.active))
        } else {
            // Normal display
            VStack(spacing: 12) {
                ForEach($accounts) { $account in
                    BizAccountListCard(
                        accountName: account.accountName,
                        accountNumber: account.accountNumber,
                        balance: account.balance,
                        currency: account.currency,
                        type: account.type,
                        isHidden: $account.isHidden,
                        onClick: { onItemClick?(account) },
                        onActionClick: { onActionClick?(account) }
                    )
                }
            }
        }
    }
}
