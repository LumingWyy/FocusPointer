import SwiftUI
import AppKit

/// 设置窗口控制器
/// 管理设置窗口的生命周期
final class SettingsWindowController: NSObject {
    // MARK: - Properties

    /// 窗口实例
    private var window: NSWindow?

    /// 设置管理器
    private let settingsManager: SettingsManager

    // MARK: - Initialization

    init(settingsManager: SettingsManager) {
        self.settingsManager = settingsManager
    }

    // MARK: - Public Methods

    /// 显示设置窗口
    func show() {
        // 如果窗口已存在,直接显示
        if let existingWindow = window {
            existingWindow.makeKeyAndOrderFront(nil)
            NSApp.activate(ignoringOtherApps: true)
            return
        }

        // 创建新窗口
        let settingsView = SettingsView(settingsManager: settingsManager)
        let hostingView = NSHostingView(rootView: settingsView)

        let window = NSWindow(
            contentRect: NSRect(x: 0, y: 0, width: 500, height: 600),
            styleMask: [.titled, .closable, .miniaturizable],
            backing: .buffered,
            defer: false
        )

        window.center()
        window.title = "Aura 设置"
        window.contentView = hostingView
        window.isReleasedWhenClosed = false
        window.makeKeyAndOrderFront(nil)

        // 设置窗口委托以处理关闭事件
        window.delegate = self

        self.window = window

        // 激活应用
        NSApp.activate(ignoringOtherApps: true)
    }

    /// 关闭设置窗口
    func close() {
        window?.close()
    }
}

// MARK: - NSWindowDelegate

extension SettingsWindowController: NSWindowDelegate {
    func windowWillClose(_ notification: Notification) {
        // 窗口关闭时不释放,保持引用
        print("⚙️ 设置窗口已关闭")
    }
}
