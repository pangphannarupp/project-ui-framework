import SwiftUI

/**
 * BizStepper - SwiftUI component matching Web UI-Framework `PPStepper.vue`.
 */
public struct BizStepper: View {
    public var steps: [String]
    public var activeStep: Int
    public var orientation: String
    public var clickable: Bool
    public var action: () -> Void

    public init(
        steps: [String] = [],
        activeStep: Int = 0,
        orientation: String = "horizontal",
        clickable: Bool = false,
        action: @escaping () -> Void = {}
    ) {
        self.steps = steps
        self.activeStep = activeStep
        self.orientation = orientation
        self.clickable = clickable
        self.action = action
    }

    public var body: some View {
        Button(action: action) {
            VStack(alignment: .leading, spacing: 8) {
                Text("Stepper")
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
 * Web UI-Framework parity alias for [BizStepper].
 */
public typealias PPStepper = BizStepper
