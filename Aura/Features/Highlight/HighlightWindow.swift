import Cocoa
import SwiftUI

/// 高亮效果窗口
/// 支持拖拽绘制矩形边框的全屏覆盖层
final class HighlightWindow: NSWindow {
    // MARK: - Properties

    /// 当前设置
    private var settings: HighlightSettings

    /// 边框尺寸（用于调试闪现预览）
    private var borderSize: CGFloat {
        settings.borderThickness.circleSize
    }

    /// 拖拽起点（屏幕坐标）
    private var dragStart: CGPoint?

    /// 供 SwiftUI 视图绑定的矩形模型
    private let rectModel = RectModel()

    /// 当前活动屏幕（用于多显示器）
    private var activeScreen: NSScreen?

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
            rootView: HighlightRectView(
                rectModel: rectModel,
                colors: settings.colorTheme.colors,
                lineWidth: settings.borderThickness.lineWidth
            )
        )

        // 使用容器视图和自动布局，确保内容始终充满窗口
        let container = NSView(frame: NSRect(origin: .zero, size: self.frame.size))
        container.translatesAutoresizingMaskIntoConstraints = false

        hostingView.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(hostingView)

        NSLayoutConstraint.activate([
            hostingView.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            hostingView.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            hostingView.topAnchor.constraint(equalTo: container.topAnchor),
            hostingView.bottomAnchor.constraint(equalTo: container.bottomAnchor)
        ])

        self.contentView = container
    }

    /// 更新设置
    /// - Parameter settings: 新的设置
    func updateSettings(_ settings: HighlightSettings) {
        self.settings = settings
        updateContent()
    }

    // MARK: - Public Methods

    /// 开始拖拽矩形（左键按下）
    /// - Parameter start: 起点（屏幕坐标）
    func beginDrag(at start: CGPoint) {
        self.dragStart = start
        self.activeScreen = screen(containing: start) ?? NSScreen.main
        if let screen = activeScreen {
            setFrame(screen.frame, display: true)
        }
        updateDrag(to: start)

        // 显示窗口并添加淡入动画
        self.alphaValue = 0
        self.orderFront(nil)

        NSAnimationContext.runAnimationGroup { context in
            context.duration = 0.1
            self.animator().alphaValue = 1.0
        }
    }

    /// 拖拽更新（移动中）
    func updateDrag(to current: CGPoint) {
        guard let start = dragStart, let screen = activeScreen ?? NSScreen.main else { return }
        let startLocalX = start.x - screen.frame.minX
        let startLocalY = start.y - screen.frame.minY
        let currLocalX = current.x - screen.frame.minX
        let currLocalY = current.y - screen.frame.minY

        let minX = min(startLocalX, currLocalX)
        let minY = min(startLocalY, currLocalY)
        // 保证最小尺寸，避免点击不拖动时不可见
        let minSize: CGFloat = max(settings.borderThickness.lineWidth, 2)
        let width = max(abs(currLocalX - startLocalX), minSize)
        let height = max(abs(currLocalY - startLocalY), minSize)
        let rect = CGRect(x: minX, y: minY, width: width, height: height)

        #if DEBUG
        print("🧭 activeScreen=\(screen.frame) start=\(start) current=\(current) localRect=\(rect)")
        #endif

        rectModel.rect = rect
    }

    /// 隐藏高亮效果
    /// - Parameter completion: 隐藏完成回调
    func hide(completion: (() -> Void)? = nil) {
        NSAnimationContext.runAnimationGroup(
            { context in
                context.duration = 0.8
                context.timingFunction = CAMediaTimingFunction(name: .easeOut)
                self.animator().alphaValue = 0
            },
            completionHandler: {
                self.orderOut(nil)
                self.dragStart = nil
                self.activeScreen = nil
                self.rectModel.rect = nil
                completion?()
            }
        )
    }

    /// 更新位置（兼容旧接口）
    func updatePosition(_ location: CGPoint) {
        updateDrag(to: location)
    }

    /// 兼容：在某点显示固定尺寸的预览矩形（用于调试闪现）
    func show(at location: CGPoint) {
        self.activeScreen = screen(containing: location) ?? NSScreen.main
        if let screen = activeScreen {
            setFrame(screen.frame, display: true)
            let size = borderSize
            let originX = location.x - size / 2 - screen.frame.minX
            let originY = location.y - size / 2 - screen.frame.minY
            rectModel.rect = CGRect(x: originX, y: originY, width: size, height: size)
        }

        self.alphaValue = 0
        self.orderFront(nil)
        NSAnimationContext.runAnimationGroup { context in
            context.duration = 0.1
            self.animator().alphaValue = 1.0
        }
    }

    // MARK: - Helpers
    private func screen(containing point: CGPoint) -> NSScreen? {
        NSScreen.screens.first { $0.frame.contains(point) }
    }
}

// MARK: - SwiftUI 视图与模型

/// 供视图绑定的矩形模型
@MainActor
private final class RectModel: ObservableObject {
    @Published var rect: CGRect? = nil
}

/// 矩形高亮视图（全屏），仅描边
private struct HighlightRectView: View {
    @ObservedObject var rectModel: RectModel
    let colors: [Color]
    let lineWidth: CGFloat

    var body: some View {
        TimelineView(.animation(minimumInterval: 1.0/30.0)) { timeline in
            // 动态旋转渐变方向
            let seconds = timeline.date.timeIntervalSinceReferenceDate
            let period: Double = 2.0
            let t = (seconds.truncatingRemainder(dividingBy: period)) / period
            let theta = 2 * .pi * t

            // 根据角度计算起止点
            let sx = 0.5 + 0.5 * cos(theta)
            let sy = 0.5 + 0.5 * sin(theta)
            let ex = 0.5 - 0.5 * cos(theta)
            let ey = 0.5 - 0.5 * sin(theta)
            let start = UnitPoint(x: sx, y: sy)
            let end = UnitPoint(x: ex, y: ey)

            GeometryReader { proxy in
                ZStack {
                    if let rect = rectModel.rect {
                        // rect 的坐标以屏幕底边为 0，SwiftUI 在 macOS 中容器通常为翻转坐标
                        // 因此需要将 y 轴翻转到视图坐标：y' = H - midY
                        let flippedMidY = proxy.size.height - rect.midY

                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                            .strokeBorder(
                                LinearGradient(
                                    gradient: Gradient(colors: colors),
                                    startPoint: start,
                                    endPoint: end
                                ),
                                lineWidth: lineWidth
                            )
                            .frame(width: rect.width, height: rect.height)
                            .position(x: rect.midX, y: flippedMidY)
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.clear)
                .ignoresSafeArea()
            }
        }
    }
}
