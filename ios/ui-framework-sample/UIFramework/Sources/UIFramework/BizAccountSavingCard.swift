import SwiftUI

public struct BizAccountSavingCard: View {
    var accountName: String
    var accountNumber: String
    var balance: Double
    var currency: String
    var type: String
    var isSelected: Bool
    var onSelect: (() -> Void)?
    
    public init(
        accountName: String,
        accountNumber: String,
        balance: Double,
        currency: String = "USD",
        type: String = "Savings",
        isSelected: Bool = false,
        onSelect: (() -> Void)? = nil
    ) {
        self.accountName = accountName
        self.accountNumber = accountNumber
        self.balance = balance
        self.currency = currency
        self.type = type
        self.isSelected = isSelected
        self.onSelect = onSelect
    }
    
    public var body: some View {
        Button(action: {
            onSelect?()
        }) {
            HStack(spacing: 0) {
                ZStack(alignment: .leading) {
                    // Background Watermark
                    GeometryReader { proxy in
                        Text(currency == "USD" ? "$" : "៛")
                            .font(.system(size: 140, weight: .heavy))
                            .foregroundColor(currency == "USD" ? Color(hex: "#EEF3FB") : Color(hex: "#FFF0F5"))
                            .offset(x: proxy.size.width * 0.8, y: proxy.size.height / 2 - 70)
                    }
                    .clipped()
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text(type)
                            .font(.system(size: 10))
                            .foregroundColor(Color(hex: "#666666"))
                            .padding(.horizontal, 8)
                            .padding(.vertical, 2)
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color(hex: "#D0D0D0"), lineWidth: 1)
                            )
                            .background(Color.white.cornerRadius(12))
                        
                        VStack(alignment: .leading, spacing: 2) {
                            Text(accountName)
                                .font(.system(size: 13, weight: .bold))
                                .foregroundColor(Color(hex: "#1A2A5E"))
                            
                            Text(accountNumber)
                                .font(.system(size: 11))
                                .foregroundColor(Color(hex: "#777777"))
                        }
                        
                        VStack(alignment: .leading, spacing: 2) {
                            Text("Total Balance")
                                .font(.system(size: 11))
                                .foregroundColor(Color(hex: "#777777"))
                            
                            HStack(alignment: .firstTextBaseline, spacing: 4) {
                                Text(currency == "USD" ? "$" : "៛")
                                    .font(.system(size: 16, weight: .heavy))
                                    .foregroundColor(Color(hex: "#1A2A5E"))
                                
                                Text(formattedBalance)
                                    .font(.system(size: 16, weight: .heavy))
                                    .foregroundColor(Color(hex: "#1A2A5E"))
                            }
                        }
                        .padding(.top, 4)
                    }
                    .padding(16)
                }
                
                Spacer()
                
                // Radio Button
                ZStack {
                    Circle()
                        .stroke(isSelected ? Color(hex: "#1A2A5E") : Color(hex: "#E0E0E0"), lineWidth: isSelected ? 3 : 2)
                        .frame(width: 22, height: 22)
                        .background(Circle().fill(Color.white))
                }
                .padding(.trailing, 16)
            }
            .background(isSelected ? Color.white : Color(hex: "#FCFCFC"))
            .cornerRadius(12)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(isSelected ? Color(hex: "#1A2A5E") : Color(hex: "#F0F0F0"), lineWidth: isSelected ? 1.5 : 1)
            )
        }
        .buttonStyle(BizCardButtonStyle())
    }
    
    private var formattedBalance: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        let digits = currency == "USD" ? 2 : 0
        formatter.minimumFractionDigits = digits
        formatter.maximumFractionDigits = digits
        return formatter.string(from: NSNumber(value: balance)) ?? "\(balance)"
    }
}

private struct BizCardButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.98 : 1.0)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}
