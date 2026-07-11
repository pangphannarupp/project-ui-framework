import SwiftUI

public struct BizCheckboxGroup<T: Hashable>: View {
    @Binding public var selection: Set<T>
    public var options: [(value: T, label: String)]
    public var vertical: Bool
    
    public init(selection: Binding<Set<T>>, options: [(value: T, label: String)], vertical: Bool = false) {
        self._selection = selection
        self.options = options
        self.vertical = vertical
    }
    
    public var body: some View {
        Group {
            if vertical {
                VStack(alignment: .leading, spacing: 12) {
                    checkboxes
                }
            } else {
                // In iOS 16+, we could use FlowLayout (from Layout). For now, we'll use a simple HStack or wrapping depending on iOS target.
                // Assuming simple HStack for now since wrapping requires custom layout or iOS 16 `Layout`.
                HStack(spacing: 16) {
                    checkboxes
                }
            }
        }
    }
    
    @ViewBuilder
    private var checkboxes: some View {
        ForEach(options, id: \.value) { option in
            BizCheckbox(
                isChecked: Binding(
                    get: { selection.contains(option.value) },
                    set: { isSelected in
                        if isSelected {
                            selection.insert(option.value)
                        } else {
                            selection.remove(option.value)
                        }
                    }
                ),
                label: option.label
            )
        }
    }
}
