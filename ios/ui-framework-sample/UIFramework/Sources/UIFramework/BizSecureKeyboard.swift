import SwiftUI

public struct BizSecureKeyboard: View {
    public var onPress: (String) -> Void
    
    @State private var isShifted = false
    @State private var showSymbols = false
    
    @State private var shieldPositions: [Int] = [0, 0, 0, 0]
    
    let defaultNumbers = ["1","2","3","4","5","6","7","8","9","0"]
    let defaultLetters = ["q","w","e","r","t","y","u","i","o","p","a","s","d","f","g","h","j","k","l","z","x","c","v","b","n","m"]
    let defaultSymbols = ["!","@","#","$","%","^","&","*","(",")","-","+","_","=","{","}","[","]",":",";","\"","'","<",">","?","/"]
    
    public init(onPress: @escaping (String) -> Void) {
        self.onPress = onPress
    }
    
    public var body: some View {
        VStack(spacing: 8) {
            // Row 1: Numbers
            HStack(spacing: 6) {
                ForEach(0..<11, id: \.self) { index in
                    if index == shieldPositions[0] {
                        ShieldIndicator()
                    } else {
                        let arrayIndex = index > shieldPositions[0] ? index - 1 : index
                        let char = defaultNumbers[arrayIndex]
                        KeyboardKey(text: char, isShifted: isShifted, action: { emitPress(char) })
                    }
                }
            }
            
            // Row 2
            HStack(spacing: 6) {
                let source = showSymbols ? defaultSymbols : defaultLetters
                ForEach(0..<11, id: \.self) { index in
                    if index == shieldPositions[1] {
                        ShieldIndicator()
                    } else {
                        let arrayIndex = index > shieldPositions[1] ? index - 1 : index
                        let char = source[arrayIndex]
                        KeyboardKey(text: char, isShifted: isShifted, action: { emitPress(char) })
                    }
                }
            }
            
            // Row 3
            HStack(spacing: 6) {
                let source = showSymbols ? defaultSymbols : defaultLetters
                ForEach(0..<10, id: \.self) { index in
                    if index == shieldPositions[2] {
                        ShieldIndicator()
                    } else {
                        let arrayIndex = (index > shieldPositions[2] ? index - 1 : index) + 10
                        let char = source[arrayIndex]
                        KeyboardKey(text: char, isShifted: isShifted, action: { emitPress(char) })
                    }
                }
            }
            .padding(.horizontal, 16)
            
            // Row 4
            HStack(spacing: 6) {
                Button(action: toggleShift) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color(hex: "#202124"))
                        
                        Image(systemName: isShifted ? "shift.fill" : "shift")
                            .foregroundColor(isShifted ? Color(hex: "#3880FF") : Color(hex: "#E8EAED"))
                    }
                }
                .frame(maxWidth: 54, maxHeight: .infinity)
                
                let source = showSymbols ? defaultSymbols : defaultLetters
                ForEach(0..<8, id: \.self) { index in
                    if index == shieldPositions[3] {
                        ShieldIndicator()
                    } else {
                        let arrayIndex = (index > shieldPositions[3] ? index - 1 : index) + 19
                        if arrayIndex < source.count {
                            let char = source[arrayIndex]
                            KeyboardKey(text: char, isShifted: isShifted, action: { emitPress(char) })
                        }
                    }
                }
                
                Button(action: { emitPress("backspace") }) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color(hex: "#202124"))
                        
                        Image(systemName: "delete.left")
                            .foregroundColor(Color(hex: "#E8EAED"))
                    }
                }
                .frame(maxWidth: 54, maxHeight: .infinity)
            }
            .frame(height: 48)
            
            // Row 5: Action Row
            HStack(spacing: 6) {
                Button(action: toggleSymbols) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color(hex: "#202124"))
                        
                        Text(showSymbols ? "ABC" : "$%?")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(Color(hex: "#E8EAED"))
                    }
                }
                .frame(maxWidth: 64, maxHeight: .infinity)
                
                Button(action: { emitPress("emoji") }) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color(hex: "#202124"))
                        Text("😊")
                    }
                }
                .frame(maxWidth: 54, maxHeight: .infinity)
                
                Button(action: { emitPress(" ") }) {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color(hex: "#2C2D31"))
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                
                Button(action: { emitPress(".") }) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color(hex: "#202124"))
                        Text(".")
                            .font(.system(size: 20, weight: .medium))
                            .foregroundColor(Color(hex: "#E8EAED"))
                    }
                }
                .frame(maxWidth: 54, maxHeight: .infinity)
                
                Button(action: { emitPress("enter") }) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color(hex: "#202124"))
                        
                        Image(systemName: "return")
                            .foregroundColor(Color(hex: "#E8EAED"))
                    }
                }
                .frame(maxWidth: 54, maxHeight: .infinity)
            }
            .frame(height: 48)
        }
        .padding(EdgeInsets(top: 8, leading: 4, bottom: 24, trailing: 4))
        .background(Color(hex: "#1A1B1E"))
        .onAppear {
            randomizeKeys()
        }
    }
    
    private func toggleShift() {
        isShifted.toggle()
    }
    
    private func toggleSymbols() {
        showSymbols.toggle()
        if showSymbols {
            isShifted = false
        }
    }
    
    private func emitPress(_ val: String) {
        if val.count == 1 && val.rangeOfCharacter(from: CharacterSet.letters) != nil && !showSymbols && isShifted {
            onPress(val.uppercased())
        } else {
            onPress(val)
        }
    }
    
    public func randomizeKeys() {
        shieldPositions = [
            Int.random(in: 0..<11),
            Int.random(in: 0..<11),
            Int.random(in: 0..<10),
            Int.random(in: 0..<8)
        ]
    }
}

private struct ShieldIndicator: View {
    var body: some View {
        ZStack {
            Color.clear
            Image(systemName: "shield.lefthalf.filled")
                .foregroundColor(Color(hex: "#5F6368"))
                .font(.system(size: 16))
        }
        .frame(maxWidth: 40, maxHeight: .infinity)
    }
}

private struct KeyboardKey: View {
    let text: String
    let isShifted: Bool
    let action: () -> Void
    
    var displayText: String {
        isShifted && text.count == 1 && text.rangeOfCharacter(from: CharacterSet.letters) != nil ? text.uppercased() : text
    }
    
    var body: some View {
        Button(action: action) {
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color(hex: "#2C2D31"))
                    .shadow(color: Color.black.opacity(0.2), radius: 1, x: 0, y: 1)
                
                Text(displayText)
                    .font(.system(size: 20, weight: .medium))
                    .foregroundColor(.white)
            }
        }
        .frame(maxWidth: 40, maxHeight: 48)
    }
}
