import SwiftUI
import AppKit
import PlaygroundSupport

/// App 图标生成器 - Playground 版本
/// 运行此 Playground 将在桌面生成所有尺寸的图标
struct IconGenerator {
    /// 生成所有尺寸的图标
    static func generateAllIcons() {
        print("🎨 开始生成 Aura App 图标...")

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

        print("\n✅ 所有图标已生成到桌面 ~/Desktop/AuraIcons/")
        print("📋 请将生成的图标复制到: Aura/Resources/Assets.xcassets/AppIcon.appiconset/")
    }

    /// 生成单个图标
    static func generateIcon(size: Int) -> NSImage? {
        // 小尺寸使用简化版本
        let view = size <= 64 ? AnyView(AuraIconViewSimple(size: size)) : AnyView(AuraIconView(size: size))
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

/// Aura 图标视图 - 完整版本
struct AuraIconView: View {
    let size: Int

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
                        startRadius: CGFloat(size) * 0.1,
                        endRadius: CGFloat(size) * 0.4
                    )
                )
                .blur(radius: CGFloat(size) * 0.02)

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
                    lineWidth: CGFloat(size) * 0.078
                )
                .frame(width: CGFloat(size) * 0.5, height: CGFloat(size) * 0.5)
                .shadow(color: .white.opacity(0.3), radius: CGFloat(size) * 0.02, x: 0, y: 0)

            // 中心白色圆点
            Circle()
                .fill(Color.white)
                .frame(width: CGFloat(size) * 0.137, height: CGFloat(size) * 0.137)
                .shadow(color: .white.opacity(0.8), radius: CGFloat(size) * 0.03, x: 0, y: 0)
                .shadow(color: .white.opacity(0.5), radius: CGFloat(size) * 0.05, x: 0, y: 0)

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
                        endRadius: CGFloat(size) * 0.068
                    )
                )
                .frame(width: CGFloat(size) * 0.137, height: CGFloat(size) * 0.137)
        }
        .frame(width: CGFloat(size), height: CGFloat(size))
        .cornerRadius(CGFloat(size) * 0.2227)  // macOS Big Sur 圆角比例
    }
}

/// 简化版图标 (用于小尺寸)
struct AuraIconViewSimple: View {
    let size: Int

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
                    lineWidth: CGFloat(size) * 0.25
                )
                .frame(width: CGFloat(size) * 0.75, height: CGFloat(size) * 0.75)

            // 中心点
            Circle()
                .fill(Color.white)
                .frame(width: CGFloat(size) * 0.1875, height: CGFloat(size) * 0.1875)
        }
        .frame(width: CGFloat(size), height: CGFloat(size))
        .cornerRadius(CGFloat(size) * 0.21875)
    }
}

// 运行图标生成
IconGenerator.generateAllIcons()

// 显示预览
PlaygroundPage.current.setLiveView(
    NSHostingView(
        rootView: VStack(spacing: 20) {
            Text("Aura App 图标预览")
                .font(.title)
                .bold()

            HStack(spacing: 20) {
                VStack {
                    AuraIconView(size: 256)
                        .frame(width: 256, height: 256)
                    Text("256x256 - 完整版")
                }

                VStack {
                    AuraIconViewSimple(size: 64)
                        .frame(width: 64, height: 64)
                    Text("64x64 - 简化版")
                }
            }

            Text("✅ 图标已生成到桌面 ~/Desktop/AuraIcons/")
                .foregroundColor(.green)
        }
        .padding(40)
        .frame(width: 700, height: 500)
    )
)
