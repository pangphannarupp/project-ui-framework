import SwiftUI

public struct BizPhase5PickersDemo: View {
    @State private var showCalAlert = false
    @State private var showCalSheet = false
    @State private var showKhmerCalAlert = false
    @State private var showKhmerCalSheet = false
    @State private var showMonthAlert = false
    @State private var showMonthSheet = false
    @State private var showTimeAlert = false
    @State private var showTimeSheet = false
    
    @State private var timeValue = ""
    
    public init() {}
    
    public var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                BizButton("Calendar Alert", isBlock: true) { showCalAlert = true }
                BizButton("Calendar Sheet", isBlock: true) { showCalSheet = true }
                BizButton("Khmer Calendar Alert", isBlock: true) { showKhmerCalAlert = true }
                BizButton("Khmer Calendar Sheet", isBlock: true) { showKhmerCalSheet = true }
                BizButton("Month Picker Alert", isBlock: true) { showMonthAlert = true }
                BizButton("Month Picker Sheet", isBlock: true) { showMonthSheet = true }
                BizButton("Time Picker Alert", isBlock: true) { showTimeAlert = true }
                BizButton("Time Picker Sheet", isBlock: true) { showTimeSheet = true }
                
                Text("Selected Time: \(timeValue)")
                    .font(.caption)
                    .padding(.top, 24)
            }
            .padding(20)
        }
        .bizCalendarAlert(isPresented: $showCalAlert)
        .bizCalendarSheet(isPresented: $showCalSheet, title: "Select Date")
        .bizKhmerCalendarAlert(isPresented: $showKhmerCalAlert)
        .bizKhmerCalendarSheet(isPresented: $showKhmerCalSheet, title: "Select Lunar Date")
        .bizMonthPickerAlert(isPresented: $showMonthAlert)
        .bizMonthPickerSheet(isPresented: $showMonthSheet, title: "Select Month")
        .bizTimePickerAlert(isPresented: $showTimeAlert, timeValue: $timeValue, title: "Select Time")
        .bizTimePickerSheet(isPresented: $showTimeSheet, timeValue: $timeValue, title: "Select Time")
    }
}
