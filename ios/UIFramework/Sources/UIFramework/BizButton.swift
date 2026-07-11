import SwiftUI
import UIKit

// MARK: - SwiftUI Implementation
public struct BizButton: View {
    public var title: String
    public var action: () -> Void
    
    public init(title: String, action: @escaping () -> Void) {
        self.title = title
        self.action = action
    }
    
    public var body: some View {
        Button(action: action) {
            Text(title)
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.blue)
                .cornerRadius(8)
        }
    }
}

// MARK: - UIKit Implementation
public class BizUIButton: UIButton {
    
    public init(title: String) {
        super.init(frame: .zero)
        setupView(title: title)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView(title: "Button")
    }
    
    private func setupView(title: String) {
        setTitle(title, for: .normal)
        setTitleColor(.white, for: .normal)
        backgroundColor = .systemBlue
        layer.cornerRadius = 8
        titleLabel?.font = .preferredFont(forTextStyle: .headline)
    }
}
