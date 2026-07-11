import SwiftUI

public struct BizSheetsBatch1Demo: View {
    @State private var showConfirm = false
    @State private var showFilter = false
    @State private var showSort = false
    @State private var showLanguage = false
    @State private var showCountryCode = false
    @State private var showFeedback = false
    @State private var showBiometric = false
    
    @State private var selectedFacilities: [String] = []
    @State private var selectedSort = "distance"
    @State private var selectedLanguage = "en"
    @State private var selectedCountryCode = "+855"
    
    public init() {}
    
    public var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                BizButton("Show Confirm Sheet", isBlock: true) { showConfirm = true }
                BizButton("Show Filter Sheet", isBlock: true) { showFilter = true }
                BizButton("Show Sort Sheet", isBlock: true) { showSort = true }
                BizButton("Show Language Sheet", isBlock: true) { showLanguage = true }
                BizButton("Show Country Code Sheet", isBlock: true) { showCountryCode = true }
                BizButton("Show Feedback Sheet", isBlock: true) { showFeedback = true }
                BizButton("Show Biometric Sheet", isBlock: true) { showBiometric = true }
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Selected Facilities: \(selectedFacilities.joined(separator: ", "))")
                    Text("Selected Sort: \(selectedSort)")
                    Text("Selected Language: \(selectedLanguage)")
                    Text("Selected Country Code: \(selectedCountryCode)")
                }
                .font(.caption)
                .padding(.top, 24)
            }
            .padding(20)
        }
        .bizConfirmSheet(
            isPresented: $showConfirm,
            title: "Are you sure?",
            subtitle: "This action cannot be undone.",
            onConfirm: { print("Confirmed") }
        )
        .bizFilterSheet(
            isPresented: $showFilter,
            selectedFacilities: $selectedFacilities
        )
        .bizSortSheet(
            isPresented: $showSort,
            selectedSort: $selectedSort
        )
        .bizLanguageSheet(
            isPresented: $showLanguage,
            selectedLanguage: $selectedLanguage
        )
        .bizCountryCodeSheet(
            isPresented: $showCountryCode,
            selectedCode: $selectedCountryCode
        )
        .bizFeedbackSheet(
            isPresented: $showFeedback,
            icon: "error",
            title: "Action Required",
            description: "Please check your input and try again.",
            buttonText: "Okay"
        )
        .bizBiometricSheet(
            isPresented: $showBiometric,
            type: "both",
            onSetup: { type in print("Setup \(type)") },
            onLater: { print("Maybe Later") }
        )
    }
}
