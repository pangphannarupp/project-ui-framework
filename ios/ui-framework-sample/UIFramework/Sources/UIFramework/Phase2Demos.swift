import SwiftUI

public struct BizBottomSheetDemo: View {
    @State private var showSheet = false
    public init() {}
    public var body: some View {
        VStack {
            BizButton("Show Bottom Sheet") {
                showSheet = true
            }
            Spacer()
        }
        .padding()
        .bizBottomSheet(
            isPresented: $showSheet,
            header: {
                Text("Header Title").font(.headline)
            },
            footer: {
                BizButton("Confirm") { showSheet = false }
            },
            content: {
                VStack {
                    Text("This is the bottom sheet content.")
                    Spacer().frame(height: 100)
                }
                .padding()
            }
        )
    }
}

public struct BizHideAppBarDemo: View {
    public init() {}
    public var body: some View {
        BizHideAppBar(headerHeight: 60) {
            Text("Auto-Hiding App Bar")
                .font(.headline)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        } content: {
            VStack(spacing: 20) {
                ForEach(0..<30, id: \.self) { i in
                    Text("List Item \(i)")
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(Color.white)
                        .cornerRadius(8)
                        .padding(.horizontal)
                }
            }
            .padding(.vertical)
        }
    }
}

public struct BizUserCardDemo: View {
    public init() {}
    public var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                BizUserCard(
                    name: "John Doe",
                    phone: "012 345 678",
                    status: .active,
                    isMaster: true,
                    hasSmartPay: true
                )
                
                BizUserCard(
                    name: "Alice Smith",
                    phone: "098 765 432",
                    status: .pending,
                    isMaster: false,
                    hasSmartPay: true
                )
            }
            .padding()
        }
        .background(Color(red: 244/255, green: 245/255, blue: 248/255))
    }
}

public struct BizSwipeItemDemo: View {
    public init() {}
    public var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                BizSwipeItem {
                    HStack {
                        Text("Swipe Me Left or Right")
                        Spacer()
                    }
                    .padding()
                    .background(Color.white)
                } leftActions: {
                    Button("Approve") {}
                        .padding(.horizontal, 20)
                        .frame(maxHeight: .infinity)
                        .background(Color.green)
                        .foregroundColor(.white)
                } rightActions: {
                    Button("Delete") {}
                        .padding(.horizontal, 20)
                        .frame(maxHeight: .infinity)
                        .background(Color.red)
                        .foregroundColor(.white)
                }
            }
            .padding()
        }
        .background(Color(red: 244/255, green: 245/255, blue: 248/255))
    }
}

public struct BizPullToRefreshDemo: View {
    @State private var items = ["Item 1", "Item 2", "Item 3"]
    public init() {}
    public var body: some View {
        BizPullToRefresh {
            try? await Task.sleep(nanoseconds: 1_500_000_000)
            items.insert("New Item \(items.count + 1)", at: 0)
        } content: {
            VStack(spacing: 12) {
                ForEach(items, id: \.self) { item in
                    Text(item)
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(Color.white)
                        .cornerRadius(8)
                }
            }
            .padding()
        }
    }
}
