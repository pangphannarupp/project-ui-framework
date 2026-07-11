import SwiftUI

public enum BizFileUploadStatus: String {
    case pending
    case uploading
    case success
    case error
}

public struct BizFileItem: Identifiable, Equatable {
    public let id: String
    public let name: String
    public let size: Int
    public var progress: Double // 0 to 100
    public var status: BizFileUploadStatus
    public var errorMessage: String?
    
    public init(id: String = UUID().uuidString, name: String, size: Int, progress: Double = 0, status: BizFileUploadStatus = .pending, errorMessage: String? = nil) {
        self.id = id
        self.name = name
        self.size = size
        self.progress = progress
        self.status = status
        self.errorMessage = errorMessage
    }
}

public struct BizFileUpload: View {
    public var multiple: Bool
    public var accept: String?
    public var maxSize: Int?
    public var disabled: Bool
    public var files: [BizFileItem]
    
    public var onSelect: () -> Void
    public var onRemove: (String) -> Void
    public var onRetry: (String) -> Void
    
    public init(
        multiple: Bool = false,
        accept: String? = nil,
        maxSize: Int? = nil,
        disabled: Bool = false,
        files: [BizFileItem] = [],
        onSelect: @escaping () -> Void,
        onRemove: @escaping (String) -> Void = { _ in },
        onRetry: @escaping (String) -> Void = { _ in }
    ) {
        self.multiple = multiple
        self.accept = accept
        self.maxSize = maxSize
        self.disabled = disabled
        self.files = files
        self.onSelect = onSelect
        self.onRemove = onRemove
        self.onRetry = onRetry
    }
    
    public var body: some View {
        VStack(spacing: 16) {
            // Dropzone Button (Tappable area)
            Button(action: {
                if !disabled {
                    onSelect()
                }
            }) {
                VStack(spacing: 12) {
                    Image(systemName: "square.and.arrow.up")
                        .font(.system(size: 32, weight: .regular))
                        .foregroundColor(disabled ? Color.gray : Color.gray)
                        // Note: To match web colors precisely, we would use custom colors, 
                        // but sticking to semantic colors here for simplicity.
                    
                    (Text("Click to upload").bold().foregroundColor(Color(hex: "#1a2a5e") ?? .blue) + Text(" or tap to browse").foregroundColor(.gray))
                        .font(.system(size: 15))
                    
                    if accept != nil || maxSize != nil {
                        HStack(spacing: 0) {
                            if let a = accept {
                                Text(a.replacingOccurrences(of: ",", with: ", "))
                            }
                            if accept != nil && maxSize != nil {
                                Text(" (")
                            }
                            if let max = maxSize {
                                Text("Max: \(formatBytes(max))")
                            }
                            if accept != nil && maxSize != nil {
                                Text(")")
                            }
                        }
                        .font(.system(size: 13))
                        .foregroundColor(.gray)
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 32)
                .padding(.horizontal, 16)
                .background(Color(white: 0.98))
                .cornerRadius(12)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(style: StrokeStyle(lineWidth: 2, dash: [6]))
                        .foregroundColor(Color(white: 0.8))
                )
                .opacity(disabled ? 0.6 : 1.0)
            }
            .buttonStyle(PlainButtonStyle())
            
            // File List
            if !files.isEmpty {
                VStack(spacing: 12) {
                    ForEach(files) { file in
                        HStack(spacing: 16) {
                            // File Icon
                            ZStack {
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(Color(white: 0.95))
                                    .frame(width: 40, height: 40)
                                Image(systemName: "doc")
                                    .font(.system(size: 20))
                                    .foregroundColor(.gray)
                            }
                            
                            // File Details
                            VStack(alignment: .leading, spacing: 4) {
                                HStack {
                                    Text(file.name)
                                        .font(.system(size: 14, weight: .medium))
                                        .foregroundColor(Color(white: 0.2))
                                        .lineLimit(1)
                                        .truncationMode(.tail)
                                    Spacer()
                                    if file.status != .uploading {
                                        Text(formatBytes(file.size))
                                            .font(.system(size: 12))
                                            .foregroundColor(.gray)
                                    } else {
                                        Text("\(Int(round(file.progress)))%")
                                            .font(.system(size: 12))
                                            .foregroundColor(.gray)
                                    }
                                }
                                
                                if file.status == .uploading {
                                    GeometryReader { geo in
                                        ZStack(alignment: .leading) {
                                            Capsule()
                                                .fill(Color(white: 0.93))
                                                .frame(height: 4)
                                            Capsule()
                                                .fill(Color(hex: "#3880ff") ?? .blue)
                                                .frame(width: max(0, geo.size.width * CGFloat(file.progress) / 100), height: 4)
                                        }
                                    }
                                    .frame(height: 4)
                                } else if file.status == .error {
                                    Text(file.errorMessage ?? "Upload failed")
                                        .font(.system(size: 12))
                                        .foregroundColor(.red)
                                }
                            }
                            
                            // Actions
                            HStack(spacing: 8) {
                                if file.status == .error {
                                    Button(action: {
                                        onRetry(file.id)
                                    }) {
                                        Image(systemName: "arrow.counterclockwise")
                                            .font(.system(size: 16))
                                            .foregroundColor(.gray)
                                            .frame(width: 32, height: 32)
                                    }
                                }
                                
                                if file.status == .success {
                                    Image(systemName: "checkmark.circle.fill")
                                        .font(.system(size: 20))
                                        .foregroundColor(.green)
                                        .frame(width: 32, height: 32)
                                }
                                
                                Button(action: {
                                    onRemove(file.id)
                                }) {
                                    Image(systemName: "xmark")
                                        .font(.system(size: 16))
                                        .foregroundColor(.gray)
                                        .frame(width: 32, height: 32)
                                }
                            }
                        }
                        .padding(.vertical, 12)
                        .padding(.horizontal, 16)
                        .background(Color.white)
                        .cornerRadius(8)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(file.status == .error ? Color.red.opacity(0.3) : (file.status == .success ? Color.green.opacity(0.3) : Color(white: 0.93)), lineWidth: 1)
                        )
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .fill(file.status == .error ? Color.red.opacity(0.05) : Color.clear)
                        )
                    }
                }
            }
        }
    }
    
    private func formatBytes(_ bytes: Int) -> String {
        let formatter = ByteCountFormatter()
        formatter.allowedUnits = [.useBytes, .useKB, .useMB, .useGB]
        formatter.countStyle = .file
        return formatter.string(fromByteCount: Int64(bytes))
    }
}
