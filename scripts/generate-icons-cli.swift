#!/usr/bin/env swift

import Foundation
import AppKit
import SwiftUI

// 简化版图标生成脚本 - 命令行版本
// 使用方法: swift scripts/generate-icons-cli.swift

print("🎨 开始生成 Aura App 图标...")

// 创建输出目录
let desktop = FileManager.default.urls(for: .desktopDirectory, in: .userDomainMask).first!
let outputFolder = desktop.appendingPathComponent("AuraIcons")
try? FileManager.default.createDirectory(at: outputFolder, withIntermediateDirectories: true)

// 图标尺寸配置
let iconSizes: [(Int, String)] = [
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

// 颜色定义
let purpleBlue = NSColor(red: 0.4, green: 0.49, blue: 0.92, alpha: 1.0)
let deepPurple = NSColor(red: 0.46, green: 0.29, blue: 0.64, alpha: 1.0)

// 彩虹颜色
let rainbowColors: [NSColor] = [
    NSColor(red: 1.0, green: 0.23, blue: 0.19, alpha: 1.0),  // 红
    NSColor(red: 1.0, green: 0.58, blue: 0.0, alpha: 1.0),   // 橙
    NSColor(red: 1.0, green: 0.8, blue: 0.0, alpha: 1.0),    // 黄
    NSColor(red: 0.2, green: 0.78, blue: 0.35, alpha: 1.0),  // 绿
    NSColor(red: 0.0, green: 0.48, blue: 1.0, alpha: 1.0),   // 蓝
    NSColor(red: 0.69, green: 0.32, blue: 0.87, alpha: 1.0), // 紫
    NSColor(red: 1.0, green: 0.23, blue: 0.19, alpha: 1.0)   // 红
]

// 生成单个图标
func generateIcon(size: Int, name: String) {
    let image = NSImage(size: NSSize(width: size, height: size))

    image.lockFocus()

    let rect = NSRect(x: 0, y: 0, width: size, height: size)
    let cornerRadius = CGFloat(size) * 0.2227
    let path = NSBezierPath(roundedRect: rect, xRadius: cornerRadius, yRadius: cornerRadius)
    path.addClip()

    // 渐变背景
    let gradient = NSGradient(starting: purpleBlue, ending: deepPurple)
    gradient?.draw(in: rect, angle: 135)

    // 彩虹光环
    let ringSize = CGFloat(size) * 0.5
    let ringRect = NSRect(
        x: (CGFloat(size) - ringSize) / 2,
        y: (CGFloat(size) - ringSize) / 2,
        width: ringSize,
        height: ringSize
    )
    let lineWidth = CGFloat(size) * 0.078

    // 绘制彩虹环 (简化版 - 使用多个扇形)
    let segmentCount = rainbowColors.count - 1
    for i in 0..<segmentCount {
        let startAngle = CGFloat(i) * 360.0 / CGFloat(segmentCount)
        let endAngle = CGFloat(i + 1) * 360.0 / CGFloat(segmentCount)

        let arcPath = NSBezierPath()
        arcPath.appendArc(
            withCenter: NSPoint(x: CGFloat(size) / 2, y: CGFloat(size) / 2),
            radius: ringSize / 2,
            startAngle: startAngle,
            endAngle: endAngle,
            clockwise: false
        )

        arcPath.lineWidth = lineWidth
        rainbowColors[i].setStroke()
        arcPath.stroke()
    }

    // 中心白色圆点
    let dotSize = CGFloat(size) * 0.137
    let dotRect = NSRect(
        x: (CGFloat(size) - dotSize) / 2,
        y: (CGFloat(size) - dotSize) / 2,
        width: dotSize,
        height: dotSize
    )

    // 发光效果 (简化)
    NSColor.white.withAlphaComponent(0.3).setFill()
    let glowPath = NSBezierPath(ovalIn: dotRect.insetBy(dx: -10, dy: -10))
    glowPath.fill()

    NSColor.white.setFill()
    let dotPath = NSBezierPath(ovalIn: dotRect)
    dotPath.fill()

    image.unlockFocus()

    // 保存 PNG
    if let tiffData = image.tiffRepresentation,
       let bitmapRep = NSBitmapImageRep(data: tiffData),
       let pngData = bitmapRep.representation(using: .png, properties: [:]) {
        let fileURL = outputFolder.appendingPathComponent("\(name).png")
        try? pngData.write(to: fileURL)
        print("✅ 已生成: \(name).png (\(size)x\(size))")
    } else {
        print("❌ 生成失败: \(name).png")
    }
}

// 生成所有图标
for (size, name) in iconSizes {
    generateIcon(size: size, name: name)
}

print("\n✅ 所有图标已生成到: \(outputFolder.path)")
print("📋 下一步: 复制图标到项目")
print("   cp ~/Desktop/AuraIcons/*.png Aura/Resources/Assets.xcassets/AppIcon.appiconset/")
