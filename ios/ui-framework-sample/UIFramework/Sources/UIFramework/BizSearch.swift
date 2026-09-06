import SwiftUI

/**
 * BizSearch - SwiftUI component matching Web UI-Framework `PPSearch.vue`.
 */
public struct BizSearch: View {
    public var modelValue: String
    public var placeholder: String
    public var results: [String]
    public var history: [String]
    public var loading: Bool
    public var itemLabel: String
    public var action: () -> Void

    public init(
        modelValue: String = "",
        placeholder: String = "Search...",
        results: [String] = [],
        history: [String] = [],
        loading: Bool = false,
        itemLabel: String = "label",
        action: @escaping () -> Void = {}
    ) {
        self.modelValue = modelValue
        self.placeholder = placeholder
        self.results = results
        self.history = history
        self.loading = loading
        self.itemLabel = itemLabel
        self.action = action
    }

    public var body: some View {
        Button(action: action) {
            VStack(alignment: .leading, spacing: 8) {
                Text("Search")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(Color(hex: "#1A2A5E"))
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(16)
            .background(Color.white)
            .cornerRadius(12)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color(hex: "#CBD5E1"), lineWidth: 1)
            )
        }
        .buttonStyle(PlainButtonStyle())
    }
}

/**
 * Web UI-Framework parity alias for [BizSearch].
 */
public typealias PPSearch = BizSearch
