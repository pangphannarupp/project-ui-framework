import SwiftUI

public struct BizKhmerKeyboard: View {
    public var onPress: (String) -> Void
    
    @State private var isShifted = false
    @State private var showSymbols = false
    
    @State private var shieldPositions: [Int] = [0, 0, 0, 0]
    
    let khmerRow0 = ["១","២","៣","៤","៥","៦","៧","៨","៩","០"]
    let khmerRow0Shift = ["!","@","#","$","%","^","&","*","(",")"]
    
    let khmerDefaultLetters = ["ឆ","វ","េ","រ","ត","យ","ុ","ិ","ោ","ផ","ា","ស","ឌ","ថ","ង","ហ","្","ក","ល","ឋ","ខ","ច","វ","ប","ន","ម"]
    let khmerShiftedLetters = ["ឈ","ឺ","ែ","ឫ","ទ","យ","ូ","ី","ៅ","ភ","ាំ","ស្ស","ធ","ញ","ង","ះ","្រ","គ","ឡ","ឍ","ឃ","ជ","ឈ","ព","ណ","ំ"]
    
    let defaultSymbols = ["!","@","#","$","%","^","&","*","(",")","-","+","_","=","{","}","[","]",":",";","\"","'","<",">","?","/"]
    
    public init(onPress: @escaping (String) -> Void) {
        self.onPress = onPress
    }
    
    public var body: some View {
        VStack(spacing: 8) {
            // Row 1
            HStack(spacing: 6) {
                let source = isShifted ? khmerRow0Shift : khmerRow0
                ForEach(0..<11, id: \.self) { index in
                    if index == shieldPositions[0] {
                        ShieldIndicator()
                    } else {
                        let arrayIndex = index > shieldPositions[0] ? index - 1 : index
                        let char = source[arrayIndex]
                        KeyboardKey(text: char, isShifted: false, action: { emitPress(char) })
                    }
                }
            }
            
            // Row 2
            HStack(spacing: 6) {
                let source = showSymbols ? defaultSymbols : (isShifted ? khmerShiftedLetters : khmerDefaultLetters)
                ForEach(0..<11, id: \.self) { index in
                    if index == shieldPositions[1] {
                        ShieldIndicator()
                    } else {
                        let arrayIndex = index > shieldPositions[1] ? index - 1 : index
                        let char = source[arrayIndex]
                        KeyboardKey(text: char, isShifted: false, action: { emitPress(char) })
                    }
                }
            }
            
            // Row 3
            HStack(spacing: 6) {
                let source = showSymbols ? defaultSymbols : (isShifted ? khmerShiftedLetters : khmerDefaultLetters)
                ForEach(0..<10, id: \.self) { index in
                    if index == shieldPositions[2] {
                        ShieldIndicator()
                    } else {
                        let arrayIndex = (index > shieldPositions[2] ? index - 1 : index) + 10
                        let char = source[arrayIndex]
                        KeyboardKey(text: char, isShifted: false, action: { emitPress(char) })
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
                
                let source = showSymbols ? defaultSymbols : (isShifted ? khmerShiftedLetters : khmerDefaultLetters)
                ForEach(0..<8, id: \.self) { index in
                    if index == shieldPositions[3] {
                        ShieldIndicator()
                    } else {
                        let arrayIndex = (index > shieldPositions[3] ? index - 1 : index) + 19
                        if arrayIndex < source.count {
                            let char = source[arrayIndex]
                            KeyboardKey(text: char, isShifted: false, action: { emitPress(char) })
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
            
            // Row 5
            HStack(spacing: 6) {
                Button(action: toggleSymbols) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color(hex: "#202124"))
                        
                        Text(showSymbols ? "កខគ" : "$%?")
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
        if showSymbols {
            showSymbols = false
        }
    }
    
    private func toggleSymbols() {
        showSymbols.toggle()
        if showSymbols {
            isShifted = false
        }
    }
    
    private func emitPress(_ val: String) {
        onPress(val)
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
    
    var body: some View {
        Button(action: action) {
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color(hex: "#2C2D31"))
                    .shadow(color: Color.black.opacity(0.2), radius: 1, x: 0, y: 1)
                
                Text(text)
                    .font(.system(size: 20, weight: .medium))
                    .foregroundColor(.white)
            }
        }
        .frame(maxWidth: 40, maxHeight: 48)
    }
}
