import SwiftUI

public struct BizAccountListCard<ActionContent: View>: View {
    var accountName: String
    var accountNumber: String
    var balance: Double
    var currency: String
    var type: String
    @Binding var isHidden: Bool
    
    var onClick: (() -> Void)?
    var onActionClick: (() -> Void)?
    var actionContent: () -> ActionContent
    
    public init(
        accountName: String,
        accountNumber: String,
        balance: Double,
        currency: String = "USD",
        type: String = "Savings",
        isHidden: Binding<Bool>,
        onClick: (() -> Void)? = nil,
        onActionClick: (() -> Void)? = nil,
        @ViewBuilder actionContent: @escaping () -> ActionContent
    ) {
        self.accountName = accountName
        self.accountNumber = accountNumber
        self.balance = balance
        self.currency = currency
        self.type = type
        self._isHidden = isHidden
        self.onClick = onClick
        self.onActionClick = onActionClick
        self.actionContent = actionContent
    }
    
    public var body: some View {
        Button(action: {
            onClick?()
        }) {
            ZStack(alignment: .leading) {
                // Background Watermark
                GeometryReader { proxy in
                    Text(currency == "USD" ? "$" : "៛")
                        .font(.system(size: 140, weight: .heavy))
                        .foregroundColor(currency == "USD" ? Color(hex: "#EEF3FB") : Color(hex: "#FFF0F5"))
                        .offset(x: -20, y: proxy.size.height / 2 - 70)
                }
                .clipped()
                
                HStack(alignment: .top, spacing: 0) {
                    // Left Column
                    VStack(alignment: .leading, spacing: 6) {
                        Text(type)
                            .font(.system(size: 11, weight: .semibold))
                            .foregroundColor(Color(hex: "#1A2A5E"))
                            .padding(.horizontal, 10)
                            .padding(.vertical, 2)
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color(hex: "#1A2A5E"), lineWidth: 1)
                            )
                            .background(Color.white.cornerRadius(12))
                        
                        Text(accountNumber)
                            .font(.system(size: 12, weight: .medium))
                            .foregroundColor(Color(hex: "#1A2A5E"))
                            .padding(.top, 4)
                        
                        Text(accountName)
                            .font(.system(size: 11, weight: .regular))
                            .foregroundColor(Color(hex: "#1A2A5E"))
                    }
                    
                    Spacer()
                    
                    // Right Column
                    VStack(alignment: .trailing, spacing: 0) {
                        actionContent()
                            .frame(height: 24)
                            .padding(.bottom, 8)
                        
                        Text("Total Balance")
                            .font(.system(size: 11))
                            .foregroundColor(Color(hex: "#777777"))
                            .padding(.bottom, 2)
                        
                        HStack(alignment: .center, spacing: 4) {
                            Button(action: {
                                isHidden.toggle()
                            }) {
                                Image(systemName: isHidden ? "eye.slash" : "eye")
                                    .font(.system(size: 14))
                                    .foregroundColor(Color(hex: "#777777"))
                            }
                            
                            HStack(alignment: .firstTextBaseline, spacing: 2) {
                                Text(currency == "USD" ? "$" : "៛")
                                    .font(.system(size: 14, weight: .bold))
                                    .foregroundColor(Color(hex: "#1A2A5E"))
                                
                                Text(formattedBalance)
                                    .font(.system(size: 18, weight: .bold))
                                    .foregroundColor(Color(hex: "#1A2A5E"))
                            }
                        }
                    }
                }
                .padding(16)
            }
            .background(Color.white)
            .cornerRadius(20)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color(hex: "#F0F2F5"), lineWidth: 1)
            )
            .shadow(color: Color.black.opacity(0.05), radius: 6, x: 0, y: 4)
        }
        .buttonStyle(BizCardButtonStyle())
    }
    
    private var formattedBalance: String {
        if isHidden { return "***,***.**" }
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter.string(from: NSNumber(value: balance)) ?? "\(balance)"
    }
}

public extension BizAccountListCard where ActionContent == AnyView {
    init(
        accountName: String,
        accountNumber: String,
        balance: Double,
        currency: String = "USD",
        type: String = "Savings",
        isHidden: Binding<Bool>,
        onClick: (() -> Void)? = nil,
        onActionClick: (() -> Void)? = nil
    ) {
        self.init(
            accountName: accountName,
            accountNumber: accountNumber,
            balance: balance,
            currency: currency,
            type: type,
            isHidden: isHidden,
            onClick: onClick,
            onActionClick: onActionClick,
            actionContent: {
                AnyView(
                    Button(action: {
                        onActionClick?()
                    }) {
                        Image(systemName: "ellipsis")
                            .font(.system(size: 20))
                            .foregroundColor(Color(hex: "#999999"))
                    }
                )
            }
        )
    }
}

private struct BizCardButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.98 : 1.0)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}
