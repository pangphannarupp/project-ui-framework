import SwiftUI

public struct BizSkeletonDemo: View {
    public init() {}
    public var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                Text("Skeleton Items").font(.headline)
                HStack(spacing: 16) {
                    BizSkeletonItem(variant: .circle, width: 48, height: 48)
                    VStack(alignment: .leading, spacing: 8) {
                        BizSkeletonItem(variant: .text, width: 150, height: 16)
                        BizSkeletonItem(variant: .text, width: 100, height: 12)
                    }
                    Spacer()
                }
                
                Text("Skeleton List").font(.headline)
                BizSkeletonList(count: 3)
                
                Text("Skeleton Detail").font(.headline)
                BizSkeletonDetail(paragraphs: 2)
            }
            .padding()
        }
    }
}

public struct BizNoResultDemo: View {
    public init() {}
    public var body: some View {
        VStack {
            BizNoResult(title: "No Transactions", graphic: {
                BizButton("Go Home", variant: .outline) {}
            })
        }
    }
}

public struct BizToastDemo: View {
    @State private var showToast = false
    public init() {}
    public var body: some View {
        VStack {
            BizButton("Show Toast") {
                showToast = true
            }
            .bizToast(isPresented: $showToast, message: "Action successful!")
        }
        .padding()
    }
}

public struct BizProgressGaugeDemo: View {
    @State private var progress: Double = 65
    public init() {}
    public var body: some View {
        VStack(spacing: 32) {
            BizProgressGauge(value: progress)
            
            BizSlider(value: $progress)
        }
        .padding()
    }
}

public struct BizRatingDemo: View {
    @State private var rating: Int = 3
    public init() {}
    public var body: some View {
        VStack(spacing: 16) {
            Text("Rate your experience").font(.headline)
            BizRating(rating: $rating)
            Text("Selected: \(rating) stars")
        }
        .padding()
    }
}

public struct BizChartsDemo: View {
    public init() {}
    public var body: some View {
        ScrollView {
            VStack(spacing: 32) {
                Text("Bar Chart").font(.headline)
                BizBarChart(data: [
                    BizBarChartData(label: "Mon", value: 10),
                    BizBarChartData(label: "Tue", value: 45),
                    BizBarChartData(label: "Wed", value: 30),
                    BizBarChartData(label: "Thu", value: 80),
                    BizBarChartData(label: "Fri", value: 50)
                ])
                .frame(height: 200)
                
                Text("Line Chart").font(.headline)
                BizLineChart(data: [10, 45, 30, 80, 50], labels: ["Mon", "Tue", "Wed", "Thu", "Fri"])
                    .frame(height: 200)
                
                Text("Pie Chart").font(.headline)
                BizPieChart(data: [
                    BizPieSegment(value: 30, color: .red),
                    BizPieSegment(value: 50, color: .green),
                    BizPieSegment(value: 20, color: .blue)
                ])
                .frame(height: 200)
            }
            .padding()
        }
    }
}
