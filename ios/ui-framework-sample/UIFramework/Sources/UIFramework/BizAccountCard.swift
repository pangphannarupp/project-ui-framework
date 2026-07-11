import SwiftUI

public enum BizAccountCardType {
    case deposit
    case loan
}

public struct BizAccountCard: View {
    public var count: Int
    public var balance: Double
    public var currency: String
    public var type: BizAccountCardType
    public var action: () -> Void
    
    @State private var isHidden = false
    
    public init(
        count: Int,
        balance: Double,
        currency: String = "KHR",
        type: BizAccountCardType = .deposit,
        action: @escaping () -> Void = {}
    ) {
        self.count = count
        self.balance = balance
        self.currency = currency
        self.type = type
        self.action = action
    }
    
    public var body: some View {
        let colors = type == .deposit
            ? [Color(hex: "#1A75FF"), Color(hex: "#4DA6FF")]
            : [Color(hex: "#FF3366"), Color(hex: "#FF809F")]
            
        ZStack(alignment: .topLeading) {
            LinearGradient(gradient: Gradient(colors: colors), startPoint: .topLeading, endPoint: .bottomTrailing)
            
            Text("$")
                .font(.system(size: 200, weight: .black))
                .foregroundColor(Color.white.opacity(0.15))
                .offset(x: -20, y: -20)
            
            VStack(alignment: .trailing, spacing: 0) {
                // Header
                HStack {
                    HStack(spacing: 8) {
                        Text("\(count)")
                            .font(.system(size: 12, weight: .bold))
                            .foregroundColor(colors[0])
                            .frame(width: 20, height: 20)
                            .background(Color.white)
                            .clipShape(Circle())
                        
                        Text("Account(s)")
                            .font(.system(size: 13, weight: .semibold))
                            .foregroundColor(.white)
                    }
                    Spacer()
                    Image(systemName: "chevron.right")
                        .foregroundColor(Color.white.opacity(0.8))
                }
                
                Spacer().frame(height: 24)
                
                // Body
                Text("Total Balance")
                    .font(.system(size: 13))
                    .foregroundColor(Color.white.opacity(0.9))
                    .padding(.bottom, 4)
                
                HStack(alignment: .center, spacing: 6) {
                    Text(currency)
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.white)
                    
                    Text(isHidden ? "***,***.**" : formatBalance(balance))
                        .font(.system(size: 28, weight: .bold))
                        .foregroundColor(.white)
                        .tracking(-0.5)
                }
            }
            .padding(.horizontal, 20)
            .padding(.top, 16)
            .padding(.bottom, 24)
        }
        .frame(height: 120)
        .cornerRadius(20)
        .shadow(color: Color.black.opacity(0.1), radius: 8, x: 0, y: 8)
        .onTapGesture {
            action()
        }
    }
    
    private func formatBalance(_ amount: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter.string(from: NSNumber(value: amount)) ?? "0.00"
    }
}
