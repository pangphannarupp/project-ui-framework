import SwiftUI

public struct BizBottomSheetModifier<SheetContent: View, Header: View, Footer: View>: ViewModifier {
    @Binding var isPresented: Bool
    var header: (() -> Header)?
    var footer: (() -> Footer)?
    var sheetContent: () -> SheetContent
    
    @State private var dragOffset: CGFloat = 0
    
    public init(
        isPresented: Binding<Bool>,
        @ViewBuilder header: @escaping () -> Header,
        @ViewBuilder footer: @escaping () -> Footer,
        @ViewBuilder sheetContent: @escaping () -> SheetContent
    ) {
        self._isPresented = isPresented
        self.header = header
        self.footer = footer
        self.sheetContent = sheetContent
    }
    
    public func body(content: Content) -> some View {
        ZStack {
            content
            
            if isPresented {
                Color.black.opacity(0.4)
                    .ignoresSafeArea()
                    .onTapGesture {
                        withAnimation {
                            isPresented = false
                        }
                    }
                    .transition(.opacity)
                    .zIndex(1)
                
                VStack(spacing: 0) {
                    Spacer()
                    
                    VStack(spacing: 0) {
                        Capsule()
                            .fill(Color(red: 224/255, green: 224/255, blue: 224/255))
                            .frame(width: 40, height: 4)
                            .padding(.vertical, 16)
                        
                        if let header = header {
                            header()
                                .padding(.bottom, 16)
                        }
                        
                        sheetContent()
                            .frame(maxWidth: .infinity)
                        
                        if let footer = footer {
                            footer()
                                .padding(.top, 24)
                                .padding(.bottom, UIApplication.shared.windows.first?.safeAreaInsets.bottom ?? 0)
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.bottom, header == nil && footer == nil ? (UIApplication.shared.windows.first?.safeAreaInsets.bottom ?? 0) : 0)
                    .background(Color.white)
                    .cornerRadius(24, corners: [.topLeft, .topRight])
                    .offset(y: max(0, dragOffset))
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                if value.translation.height > 0 {
                                    dragOffset = value.translation.height
                                }
                            }
                            .onEnded { value in
                                if dragOffset > 100 {
                                    withAnimation {
                                        isPresented = false
                                        dragOffset = 0
                                    }
                                } else {
                                    withAnimation(.spring()) {
                                        dragOffset = 0
                                    }
                                }
                            }
                    )
                }
                .ignoresSafeArea(.all, edges: .bottom)
                .transition(.move(edge: .bottom))
                .zIndex(2)
            }
        }
    }
}

public extension View {
    func bizBottomSheet<Content: View, Header: View, Footer: View>(
        isPresented: Binding<Bool>,
        @ViewBuilder header: @escaping () -> Header,
        @ViewBuilder footer: @escaping () -> Footer,
        @ViewBuilder content: @escaping () -> Content
    ) -> some View {
        self.modifier(BizBottomSheetModifier(isPresented: isPresented, header: header, footer: footer, sheetContent: content))
    }
    
    func bizBottomSheet<Content: View>(
        isPresented: Binding<Bool>,
        @ViewBuilder content: @escaping () -> Content
    ) -> some View {
        self.modifier(BizBottomSheetModifier(isPresented: isPresented, header: { EmptyView() }, footer: { EmptyView() }, sheetContent: content))
    }
}
