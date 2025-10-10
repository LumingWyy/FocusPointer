import Cocoa
import SwiftUI

/// 高亮效果窗口
/// 在鼠标光标周围显示彩色渐变边框
final class HighlightWindow: NSWindow {
    // MARK: - Properties

    /// 当前设置
    private var settings: HighlightSettings

    /// 边框尺寸
    private var borderSize: CGFloat {
        settings.borderThickness.circleSize
    }

    // MARK: - Initialization

    init(settings: HighlightSettings = .default) {
        self.settings = settings

        // 创建一个覆盖全屏的透明窗口
        super.init(
            contentRect: .zero,
            styleMask: [.borderless],
            backing: .buffered,
            defer: false
        )

        setupWindow()
    }

    // MARK: - Setup

    private func setupWindow() {
        // 窗口配置
        self.isOpaque = false
        self.backgroundColor = .clear
        self.level = .screenSaver  // 显示在所有窗口之上
        self.collectionBehavior = [.canJoinAllSpaces, .stationary, .ignoresCycle]
        self.ignoresMouseEvents = true  // 不拦截鼠标事件

        updateContent()
    }

    /// 更新窗口内容
    private func updateContent() {
        let hostingView = NSHostingView(
            rootView: HighlightView(
                colors: settings.colorTheme.colors,
                lineWidth: settings.borderThickness.lineWidth
            )
        )
        self.contentView = hostingView
    }

    /// 更新设置
    /// - Parameter settings: 新的设置
    func updateSettings(_ settings: HighlightSettings) {
        self.settings = settings
        updateContent()
    }

    // MARK: - Public Methods

    /// 在指定位置显示高亮效果
    /// - Parameter location: 鼠标位置 (屏幕坐标)
    func show(at location: CGPoint) {
        // 计算窗口位置 (以鼠标为中心)
        let windowOrigin = CGPoint(
            x: location.x - borderSize / 2,
            y: location.y - borderSize / 2
        )

        let windowSize = CGSize(width: borderSize, height: borderSize)

        setFrame(
            NSRect(origin: windowOrigin, size: windowSize),
            display: true
        )

        // 显示窗口并添加淡入动画
        self.alphaValue = 0
        self.orderFront(nil)

        NSAnimationContext.runAnimationGroup { context in
            context.duration = 0.1
            self.animator().alphaValue = 1.0
        }
    }

    /// 隐藏高亮效果
    /// - Parameter completion: 隐藏完成回调
    func hide(completion: (() -> Void)? = nil) {
        NSAnimationContext.runAnimationGroup(
            { context in
                context.duration = 0.3
                self.animator().alphaValue = 0
            },
            completionHandler: {
                self.orderOut(nil)
                completion?()
            }
        )
    }

    /// 更新位置
    /// - Parameter location: 新的鼠标位置
    func updatePosition(_ location: CGPoint) {
        let windowOrigin = CGPoint(
            x: location.x - borderSize / 2,
            y: location.y - borderSize / 2
        )

        setFrameOrigin(windowOrigin)
    }
}

// MARK: - HighlightView

/// 高亮效果的 SwiftUI 视图
private struct HighlightView: View {
    let colors: [Color]
    let lineWidth: CGFloat

    var body: some View {
        Circle()
            .strokeBorder(
                AngularGradient(
                    gradient: Gradient(colors: colors),
                    center: .center,
                    startAngle: .degrees(0),
                    endAngle: .degrees(360)
                ),
                lineWidth: lineWidth
            )
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding(8)
    }
}
