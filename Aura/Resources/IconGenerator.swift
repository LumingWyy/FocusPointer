import SwiftUI
import AppKit

/// App 图标生成器
/// 使用 SwiftUI 程序化生成 App 图标
struct IconGenerator {
    /// 生成所有尺寸的图标
    static func generateAllIcons() {
        let sizes: [(Int, String)] = [
            (16, "icon_16x16"),
            (32, "icon_16x16@2x"),
            (32, "icon_32x32"),
            (64, "icon_32x32@2x"),
            (128, "icon_128x128"),
            (256, "icon_128x128@2x"),
            (256, "icon_256x256"),
            (512, "icon_256x256@2x"),
            (512, "icon_512x512"),
            (1024, "icon_512x512@2x")
        ]

        for (size, name) in sizes {
            if let image = generateIcon(size: size) {
                saveImage(image, name: name, size: size)
            }
        }

        print("✅ 所有图标已生成")
    }

    /// 生成单个图标
    /// - Parameter size: 图标尺寸
    /// - Returns: NSImage
    static func generateIcon(size: Int) -> NSImage? {
        let view = AuraIconView()
        let hosting = NSHostingView(rootView: view)
        hosting.frame = CGRect(x: 0, y: 0, width: size, height: size)

        guard let bitmapRep = hosting.bitmapImageRepForCachingDisplay(in: hosting.bounds) else {
            return nil
        }

        hosting.cacheDisplay(in: hosting.bounds, to: bitmapRep)

        let image = NSImage(size: CGSize(width: size, height: size))
        image.addRepresentation(bitmapRep)

        return image
    }

    /// 保存图标到文件
    private static func saveImage(_ image: NSImage, name: String, size: Int) {
        guard let tiffData = image.tiffRepresentation,
              let bitmapRep = NSBitmapImageRep(data: tiffData),
              let pngData = bitmapRep.representation(using: .png, properties: [:]) else {
            print("❌ 无法生成 \(name).png")
            return
        }

        let desktop = FileManager.default.urls(for: .desktopDirectory, in: .userDomainMask).first!
        let iconFolder = desktop.appendingPathComponent("AuraIcons")

        try? FileManager.default.createDirectory(at: iconFolder, withIntermediateDirectories: true)

        let fileURL = iconFolder.appendingPathComponent("\(name).png")

        do {
            try pngData.write(to: fileURL)
            print("✅ 已生成: \(name).png (\(size)x\(size))")
        } catch {
            print("❌ 保存失败: \(error)")
        }
    }
}

/// Aura 图标视图
struct AuraIconView: View {
    var body: some View {
        ZStack {
            // 渐变背景
            LinearGradient(
                gradient: Gradient(colors: [
                    Color(red: 0.4, green: 0.49, blue: 0.92),  // 紫蓝
                    Color(red: 0.46, green: 0.29, blue: 0.64)  // 深紫
                ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )

            // 外层光晕
            Circle()
                .fill(
                    RadialGradient(
                        gradient: Gradient(colors: [
                            Color.white.opacity(0.1),
                            Color.clear
                        ]),
                        center: .center,
                        startRadius: 100,
                        endRadius: 400
                    )
                )
                .blur(radius: 20)

            // 彩虹光环
            Circle()
                .strokeBorder(
                    AngularGradient(
                        gradient: Gradient(colors: [
                            Color(red: 1.0, green: 0.23, blue: 0.19),  // 红
                            Color(red: 1.0, green: 0.58, blue: 0.0),   // 橙
                            Color(red: 1.0, green: 0.8, blue: 0.0),    // 黄
                            Color(red: 0.2, green: 0.78, blue: 0.35),  // 绿
                            Color(red: 0.0, green: 0.48, blue: 1.0),   // 蓝
                            Color(red: 0.69, green: 0.32, blue: 0.87), // 紫
                            Color(red: 1.0, green: 0.23, blue: 0.19)   // 红
                        ]),
                        center: .center,
                        startAngle: .degrees(0),
                        endAngle: .degrees(360)
                    ),
                    lineWidth: 80
                )
                .frame(width: 512, height: 512)
                .shadow(color: .white.opacity(0.3), radius: 20, x: 0, y: 0)

            // 中心白色圆点
            Circle()
                .fill(Color.white)
                .frame(width: 140, height: 140)
                .shadow(color: .white.opacity(0.8), radius: 30, x: 0, y: 0)
                .shadow(color: .white.opacity(0.5), radius: 50, x: 0, y: 0)

            // 内圈渐变
            Circle()
                .fill(
                    RadialGradient(
                        gradient: Gradient(colors: [
                            Color.white,
                            Color.white.opacity(0.9)
                        ]),
                        center: .center,
                        startRadius: 0,
                        endRadius: 70
                    )
                )
                .frame(width: 140, height: 140)
        }
        .frame(width: 1024, height: 1024)
        .cornerRadius(228)  // macOS Big Sur 圆角
    }
}

/// 简化版图标 (用于小尺寸)
struct AuraIconViewSimple: View {
    var body: some View {
        ZStack {
            // 渐变背景
            LinearGradient(
                gradient: Gradient(colors: [
                    Color(red: 0.4, green: 0.49, blue: 0.92),
                    Color(red: 0.46, green: 0.29, blue: 0.64)
                ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )

            // 简化彩虹环
            Circle()
                .strokeBorder(
                    AngularGradient(
                        gradient: Gradient(colors: [
                            .red, .orange, .yellow, .green, .blue, .purple, .red
                        ]),
                        center: .center
                    ),
                    lineWidth: 8
                )
                .frame(width: 24, height: 24)

            // 中心点
            Circle()
                .fill(Color.white)
                .frame(width: 6, height: 6)
        }
        .frame(width: 32, height: 32)
        .cornerRadius(7)
    }
}

// MARK: - Preview

#Preview("1024x1024") {
    AuraIconView()
}

#Preview("32x32") {
    AuraIconViewSimple()
}
