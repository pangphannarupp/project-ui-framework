import SwiftUI

public struct BizKeypadDemo: View {
    @State private var input = ""
    public init() {}
    public var body: some View {
        VStack {
            Spacer()
            Text("Input: \(input)")
                .font(.title)
                .padding()
            Spacer()
            BizKeypad(onPress: { val in
                if val == "backspace" {
                    if !input.isEmpty { input.removeLast() }
                } else {
                    input += val
                }
            })
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}

public struct BizSecureKeypadDemo: View {
    @State private var input = ""
    public init() {}
    public var body: some View {
        VStack {
            Spacer()
            Text("Secure Input: \(String(repeating: "*", count: input.count))")
                .font(.title)
                .padding()
            Spacer()
            BizSecureKeypad(onPress: { val in
                if val == "backspace" {
                    if !input.isEmpty { input.removeLast() }
                } else {
                    input += val
                }
            })
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}

public struct BizSecureKeyboardDemo: View {
    @State private var input = ""
    public init() {}
    public var body: some View {
        VStack {
            Spacer()
            Text("Input: \(input)")
                .font(.title)
                .padding()
            Spacer()
            BizSecureKeyboard(onPress: { val in
                if val == "backspace" {
                    if !input.isEmpty { input.removeLast() }
                } else if val == "enter" {
                    input += "\n"
                } else if val != "emoji" {
                    input += val
                }
            })
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}

public struct BizKhmerKeyboardDemo: View {
    @State private var input = ""
    public init() {}
    public var body: some View {
        VStack {
            Spacer()
            Text("Input: \(input)")
                .font(.title)
                .padding()
            Spacer()
            BizKhmerKeyboard(onPress: { val in
                if val == "backspace" {
                    if !input.isEmpty { input.removeLast() }
                } else if val == "enter" {
                    input += "\n"
                } else if val != "emoji" {
                    input += val
                }
            })
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}
