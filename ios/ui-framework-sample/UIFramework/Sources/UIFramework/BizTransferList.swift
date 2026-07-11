import SwiftUI

public struct BizTransferOption: Identifiable, Equatable {
    public let id: String
    public var key: String
    public var label: String
    public var disabled: Bool
    
    public init(key: String, label: String, disabled: Bool = false) {
        self.id = key
        self.key = key
        self.label = label
        self.disabled = disabled
    }
}

public struct BizTransferList: View {
    @Binding var modelValue: [String]
    var data: [BizTransferOption]
    var titles: [String]
    var variant: Variant
    var disabled: Bool
    var onChange: (([String], String, [String]) -> Void)?
    
    public enum Variant {
        case outlined
        case filled
        case underlined
    }
    
    @State private var leftChecked: Set<String> = []
    @State private var rightChecked: Set<String> = []
    
    public init(
        modelValue: Binding<[String]>,
        data: [BizTransferOption],
        titles: [String] = ["Source", "Target"],
        variant: Variant = .outlined,
        disabled: Bool = false,
        onChange: (([String], String, [String]) -> Void)? = nil
    ) {
        self._modelValue = modelValue
        self.data = data
        self.titles = titles
        self.variant = variant
        self.disabled = disabled
        self.onChange = onChange
    }
    
    public var body: some View {
        HStack(alignment: .center, spacing: 16) {
            // Left Panel
            transferPanel(
                title: titles[0],
                items: leftData,
                checkedSet: $leftChecked
            )
            
            // Actions
            VStack(spacing: 12) {
                Button(action: moveToRight) {
                    Image(systemName: "chevron.right")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(
                            (disabled || leftChecked.isEmpty) ? Color(hex: "#CCCCCC") : Color(hex: "#333333")
                        )
                        .frame(width: 36, height: 36)
                        .background((disabled || leftChecked.isEmpty) ? Color(hex: "#F5F5F5") : Color.white)
                        .cornerRadius(4)
                        .overlay(
                            RoundedRectangle(cornerRadius: 4)
                                .stroke((disabled || leftChecked.isEmpty) ? Color(hex: "#EEEEEE") : Color(hex: "#CCCCCC"), lineWidth: 1)
                        )
                }
                .disabled(disabled || leftChecked.isEmpty)
                
                Button(action: moveToLeft) {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(
                            (disabled || rightChecked.isEmpty) ? Color(hex: "#CCCCCC") : Color(hex: "#333333")
                        )
                        .frame(width: 36, height: 36)
                        .background((disabled || rightChecked.isEmpty) ? Color(hex: "#F5F5F5") : Color.white)
                        .cornerRadius(4)
                        .overlay(
                            RoundedRectangle(cornerRadius: 4)
                                .stroke((disabled || rightChecked.isEmpty) ? Color(hex: "#EEEEEE") : Color(hex: "#CCCCCC"), lineWidth: 1)
                        )
                }
                .disabled(disabled || rightChecked.isEmpty)
            }
            
            // Right Panel
            transferPanel(
                title: titles.count > 1 ? titles[1] : "Target",
                items: rightData,
                checkedSet: $rightChecked
            )
        }
        .opacity(disabled ? 0.6 : 1.0)
    }
    
    private var leftData: [BizTransferOption] {
        data.filter { !modelValue.contains($0.key) }
    }
    
    private var rightData: [BizTransferOption] {
        data.filter { modelValue.contains($0.key) }
    }
    
    private func transferPanel(
        title: String,
        items: [BizTransferOption],
        checkedSet: Binding<Set<String>>
    ) -> some View {
        VStack(spacing: 0) {
            // Header
            HStack {
                Button(action: {
                    let allEnabled = items.filter { !$0.disabled }
                    if checkedSet.wrappedValue.count > 0 && checkedSet.wrappedValue.count == allEnabled.count {
                        checkedSet.wrappedValue.removeAll()
                    } else {
                        checkedSet.wrappedValue = Set(allEnabled.map { $0.key })
                    }
                }) {
                    HStack(spacing: 8) {
                        Image(systemName: (checkedSet.wrappedValue.count > 0 && checkedSet.wrappedValue.count == items.filter { !$0.disabled }.count) ? "checkmark.square.fill" : "square")
                            .foregroundColor(
                                (checkedSet.wrappedValue.count > 0 && checkedSet.wrappedValue.count == items.filter { !$0.disabled }.count) ? Color(hex: "#1A2A5E") : Color(hex: "#CCCCCC")
                            )
                        
                        Text(title)
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(Color(hex: "#333333"))
                    }
                }
                .disabled(disabled)
                
                Spacer()
                
                Text("\(checkedSet.wrappedValue.count)/\(items.count)")
                    .font(.system(size: 12))
                    .foregroundColor(Color(hex: "#999999"))
            }
            .padding(.horizontal, variant == .underlined ? 8 : 16)
            .padding(.vertical, 12)
            .background(headerBackground)
            .overlay(
                Rectangle().frame(height: 1).foregroundColor(headerBorder),
                alignment: .bottom
            )
            
            // Body
            ScrollView {
                if items.isEmpty {
                    Text("No Data")
                        .font(.system(size: 14))
                        .foregroundColor(Color(hex: "#CCCCCC"))
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .padding(.top, 40)
                } else {
                    LazyVStack(spacing: 0) {
                        ForEach(items) { item in
                            Button(action: {
                                if !disabled && !item.disabled {
                                    if checkedSet.wrappedValue.contains(item.key) {
                                        checkedSet.wrappedValue.remove(item.key)
                                    } else {
                                        checkedSet.wrappedValue.insert(item.key)
                                    }
                                }
                            }) {
                                HStack(spacing: 8) {
                                    Image(systemName: checkedSet.wrappedValue.contains(item.key) ? "checkmark.square.fill" : "square")
                                        .foregroundColor(
                                            checkedSet.wrappedValue.contains(item.key) ? Color(hex: "#1A2A5E") : Color(hex: "#CCCCCC")
                                        )
                                    
                                    Text(item.label)
                                        .font(.system(size: 14))
                                        .foregroundColor(Color(hex: "#333333"))
                                    
                                    Spacer()
                                }
                                .padding(.horizontal, variant == .underlined ? 8 : 16)
                                .padding(.vertical, 8)
                                .background(checkedSet.wrappedValue.contains(item.key) ? Color(hex: "#1A2A5E").opacity(0.05) : Color.clear)
                            }
                            .buttonStyle(PlainButtonStyle())
                            .disabled(disabled || item.disabled)
                            .opacity(item.disabled ? 0.5 : 1.0)
                        }
                    }
                    .padding(.vertical, 8)
                }
            }
        }
        .frame(minWidth: 150, maxWidth: .infinity)
        .frame(height: 250)
        .background(panelBackground)
        .cornerRadius(variant == .outlined || variant == .filled ? 8 : 0)
        .overlay(panelBorder)
    }
    
    private var panelBackground: Color {
        switch variant {
        case .outlined: return Color.white
        case .filled: return Color(hex: "#F5F5F5")
        case .underlined: return Color.clear
        }
    }
    
    private var headerBackground: Color {
        switch variant {
        case .outlined: return Color(hex: "#FAFAFA")
        case .filled: return Color(hex: "#E8E8E8")
        case .underlined: return Color.clear
        }
    }
    
    private var headerBorder: Color {
        switch variant {
        case .outlined: return Color(hex: "#EEEEEE")
        case .filled: return Color(hex: "#DDDDDD")
        case .underlined: return Color.clear
        }
    }
    
    @ViewBuilder
    private var panelBorder: some View {
        switch variant {
        case .outlined:
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color(hex: "#CCCCCC"), lineWidth: 1)
        case .filled:
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color(hex: "#999999"), lineWidth: 0)
                .overlay(
                    Rectangle().frame(height: 2).foregroundColor(Color(hex: "#999999")),
                    alignment: .bottom
                )
        case .underlined:
            Rectangle()
                .frame(height: 2)
                .foregroundColor(Color(hex: "#CCCCCC"))
                .frame(maxHeight: .infinity, alignment: .bottom)
        }
    }
    
    private func moveToRight() {
        let moved = Array(leftChecked)
        modelValue.append(contentsOf: moved)
        onChange?(modelValue, "right", moved)
        leftChecked.removeAll()
    }
    
    private func moveToLeft() {
        let moved = Array(rightChecked)
        modelValue.removeAll { moved.contains($0) }
        onChange?(modelValue, "left", moved)
        rightChecked.removeAll()
    }
}
