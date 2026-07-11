import SwiftUI

public struct BizRadioGroup<T: Hashable>: View {
    @Binding public var selection: T?
    public var options: [(value: T, label: String)]
    public var vertical: Bool
    
    public init(selection: Binding<T?>, options: [(value: T, label: String)], vertical: Bool = false) {
        self._selection = selection
        self.options = options
        self.vertical = vertical
    }
    
    public var body: some View {
        Group {
            if vertical {
                VStack(alignment: .leading, spacing: 12) {
                    radios
                }
            } else {
                HStack(spacing: 16) {
                    radios
                }
            }
        }
    }
    
    @ViewBuilder
    private var radios: some View {
        ForEach(options, id: \.value) { option in
            BizRadio(
                isSelected: selection == option.value,
                label: option.label,
                action: {
                    selection = option.value
                }
            )
        }
    }
}
