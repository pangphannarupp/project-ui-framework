import SwiftUI

public struct BizCheckboxGroupDemo: View {
    @State private var selection: Set<String> = ["1"]
    let options = [
        ("1", "Option A"),
        ("2", "Option B"),
        ("3", "Option C")
    ]
    
    public init() {}
    public var body: some View {
        VStack(alignment: .leading, spacing: 32) {
            Text("Horizontal Checkbox Group").font(.headline)
            BizCheckboxGroup(selection: $selection, options: options, vertical: false)
            
            Text("Vertical Checkbox Group").font(.headline)
            BizCheckboxGroup(selection: $selection, options: options, vertical: true)
        }
        .padding()
    }
}

public struct BizRadioGroupDemo: View {
    @State private var selection: String? = "2"
    let options = [
        ("1", "Option A"),
        ("2", "Option B"),
        ("3", "Option C")
    ]
    
    public init() {}
    public var body: some View {
        VStack(alignment: .leading, spacing: 32) {
            Text("Horizontal Radio Group").font(.headline)
            BizRadioGroup(selection: $selection, options: options, vertical: false)
            
            Text("Vertical Radio Group").font(.headline)
            BizRadioGroup(selection: $selection, options: options, vertical: true)
        }
        .padding()
    }
}

public struct BizPhoneInputDemo: View {
    @State private var phone = ""
    public init() {}
    public var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Phone Input").font(.headline)
            BizPhoneInput(
                text: $phone,
                label: "Phone Number",
                placeholder: "12 345 678"
            )
            Text("Value: \(phone)")
        }
        .padding()
        .background(Color(hex: "#F4F5F8"))
    }
}

public struct BizNumberSpinnerDemo: View {
    @State private var count = 1
    public init() {}
    public var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Number Spinner").font(.headline)
            BizNumberSpinner(value: $count, min: 0, max: 10, step: 1)
            Text("Current Value: \(count)")
        }
        .padding()
    }
}

public struct BizOtpInputDemo: View {
    @State private var otp = ""
    public init() {}
    public var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("OTP Input").font(.headline)
            BizOtpInput(value: $otp, length: 6) { complete in
                print("OTP Complete: \(complete)")
            }
            Text("Value: \(otp)")
        }
        .padding()
    }
}

public struct BizPinDotsDemo: View {
    @State private var pin = ""
    @State private var hasError = false
    @State private var isSuccess = false
    
    public init() {}
    public var body: some View {
        VStack(alignment: .leading, spacing: 32) {
            Text("PIN Dots").font(.headline)
            
            BizPinDots(length: 6, value: pin, error: hasError, success: isSuccess)
            
            BizTextField(text: $pin, placeholder: "Simulate Typing PIN")
                .onChange(of: pin) { newValue in
                    if newValue.count > 6 {
                        pin = String(newValue.prefix(6))
                    }
                    hasError = false
                    isSuccess = false
                }
            
            HStack {
                BizButton("Trigger Error", variant: .outline) {
                    hasError = true
                    isSuccess = false
                }
                BizButton("Trigger Success", variant: .primary) {
                    isSuccess = true
                    hasError = false
                }
            }
        }
        .padding()
    }
}
