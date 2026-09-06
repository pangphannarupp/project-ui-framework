import SwiftUI

/**
 * BizPagination - SwiftUI component matching Web UI-Framework `PPPagination.vue`.
 */
public struct BizPagination: View {
    public var total: Int
    public var pageSize: Int
    public var currentPage: Int
    public var variant: String
    public var shape: String
    public var size: String
    public var showSizeChanger: Bool
    public var pageSizes: [String]
    public var sizeChangerPosition: String
    public var showFirstLast: Bool
    public var action: () -> Void

    public init(
        total: Int = 0,
        pageSize: Int = 0,
        currentPage: Int = 0,
        variant: String = "",
        shape: String = "",
        size: String = "",
        showSizeChanger: Bool = false,
        pageSizes: [String] = [],
        sizeChangerPosition: String = "",
        showFirstLast: Bool = false,
        action: @escaping () -> Void = {}
    ) {
        self.total = total
        self.pageSize = pageSize
        self.currentPage = currentPage
        self.variant = variant
        self.shape = shape
        self.size = size
        self.showSizeChanger = showSizeChanger
        self.pageSizes = pageSizes
        self.sizeChangerPosition = sizeChangerPosition
        self.showFirstLast = showFirstLast
        self.action = action
    }

    public var body: some View {
        Button(action: action) {
            VStack(alignment: .leading, spacing: 8) {
                Text("Pagination")
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
 * Web UI-Framework parity alias for [BizPagination].
 */
public typealias PPPagination = BizPagination
