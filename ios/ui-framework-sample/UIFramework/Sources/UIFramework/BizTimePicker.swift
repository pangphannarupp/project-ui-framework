import SwiftUI

public struct BizTimePicker: View {
    @Binding public var time: String
    public var title: String?
    public var showActionButtons: Bool
    public var onCancel: (() -> Void)?
    public var onConfirm: ((String) -> Void)?
    
    @State private var date: Date
    
    public init(
        time: Binding<String>,
        title: String? = nil,
        showActionButtons: Bool = false,
        onCancel: (() -> Void)? = nil,
        onConfirm: ((String) -> Void)? = nil
    ) {
        self._time = time
        self.title = title
        self.showActionButtons = showActionButtons
        self.onCancel = onCancel
        self.onConfirm = onConfirm
        
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        if let parsed = formatter.date(from: time.wrappedValue) {
            self._date = State(initialValue: parsed)
        } else {
            self._date = State(initialValue: Date())
        }
    }
    
    public var body: some View {
        VStack(spacing: 16) {
            if let t = title {
                Text(t)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(Color(red: 51/255, green: 51/255, blue: 51/255))
                    .frame(maxWidth: .infinity, alignment: .center)
            }
            
            DatePicker("", selection: Binding(
                get: { date },
                set: { newDate in
                    date = newDate
                    if !showActionButtons {
                        let formatter = DateFormatter()
                        formatter.dateFormat = "HH:mm"
                        time = formatter.string(from: newDate)
                    }
                }
            ), displayedComponents: .hourAndMinute)
            .labelsHidden()
            .datePickerStyle(.wheel)
            .environment(\.locale, Locale(identifier: "en_GB")) // Forces 24-hour time format usually
            
            if showActionButtons {
                HStack(spacing: 12) {
                    Spacer()
                    Button(action: {
                        onCancel?()
                    }) {
                        Text("Cancel")
                            .font(.system(size: 14, weight: .semibold))
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                            .background(Color(red: 244/255, green: 245/255, blue: 248/255))
                            .foregroundColor(Color(red: 102/255, green: 102/255, blue: 102/255))
                            .cornerRadius(8)
                    }
                    
                    Button(action: {
                        let formatter = DateFormatter()
                        formatter.dateFormat = "HH:mm"
                        let formatted = formatter.string(from: date)
                        time = formatted
                        onConfirm?(formatted)
                    }) {
                        Text("Confirm")
                            .font(.system(size: 14, weight: .semibold))
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                            .background(Color(red: 0, green: 51/255, blue: 153/255))
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                }
            }
        }
        .padding(16)
        .background(Color.white)
        .cornerRadius(16)
    }
}
