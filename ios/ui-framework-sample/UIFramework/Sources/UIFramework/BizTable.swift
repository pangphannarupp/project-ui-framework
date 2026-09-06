import SwiftUI

/**
 * BizTable - SwiftUI component matching Web UI-Framework `PPTable.vue`.
 */
public struct BizTable: View {
    public var columns: [String]
    public var required: String
    public var data: [String]
    public var pagination: Bool
    public var pageSize: Int
    public var striped: Bool
    public var bordered: Bool
    public var hover: Bool
    public var compact: Bool
    public var paginationVariant: String
    public var paginationShape: String
    public var paginationSize: String
    public var showSizeChanger: Bool
    public var pageSizes: [String]
    public var paginationAlign: String
    public var sizeChangerPosition: String
    public var showFirstLast: Bool
    public var selectable: Bool
    public var multiple: Bool
    public var rowKey: String
    public var modelValue: [String]
    public var loading: Bool
    public var skeletonRows: Int
    public var expandable: Bool
    public var spanMethod: String
    public var emptyText: String
    public var emptyIcon: String
    public var action: () -> Void

    public init(
        columns: [String] = [],
        required: String = "",
        data: [String] = [],
        pagination: Bool = false,
        pageSize: Int = 0,
        striped: Bool = false,
        bordered: Bool = false,
        hover: Bool = false,
        compact: Bool = false,
        paginationVariant: String = "",
        paginationShape: String = "",
        paginationSize: String = "",
        showSizeChanger: Bool = false,
        pageSizes: [String] = [],
        paginationAlign: String = "",
        sizeChangerPosition: String = "",
        showFirstLast: Bool = false,
        selectable: Bool = false,
        multiple: Bool = false,
        rowKey: String = "",
        modelValue: [String] = [],
        loading: Bool = false,
        skeletonRows: Int = 0,
        expandable: Bool = false,
        spanMethod: String = "",
        emptyText: String = "",
        emptyIcon: String = "",
        action: @escaping () -> Void = {}
    ) {
        self.columns = columns
        self.required = required
        self.data = data
        self.pagination = pagination
        self.pageSize = pageSize
        self.striped = striped
        self.bordered = bordered
        self.hover = hover
        self.compact = compact
        self.paginationVariant = paginationVariant
        self.paginationShape = paginationShape
        self.paginationSize = paginationSize
        self.showSizeChanger = showSizeChanger
        self.pageSizes = pageSizes
        self.paginationAlign = paginationAlign
        self.sizeChangerPosition = sizeChangerPosition
        self.showFirstLast = showFirstLast
        self.selectable = selectable
        self.multiple = multiple
        self.rowKey = rowKey
        self.modelValue = modelValue
        self.loading = loading
        self.skeletonRows = skeletonRows
        self.expandable = expandable
        self.spanMethod = spanMethod
        self.emptyText = emptyText
        self.emptyIcon = emptyIcon
        self.action = action
    }

    public var body: some View {
        Button(action: action) {
            VStack(alignment: .leading, spacing: 8) {
                Text("Table")
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
 * Web UI-Framework parity alias for [BizTable].
 */
public typealias PPTable = BizTable
