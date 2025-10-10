import Foundation
import SwiftUI

/// 应用全局状态管理
/// 遵循 MVVM 架构模式,提供集中式状态管理
@MainActor
final class AppState: ObservableObject {
    /// 单例实例
    static let shared = AppState()

    /// 设置管理器
    @Published var settingsManager = SettingsManager()

    /// 高亮管理器
    @Published var highlightManager: HighlightManager

    /// 设置窗口控制器
    private var settingsWindowController: SettingsWindowController?

    /// 私有初始化确保单例模式
    private init() {
        self.highlightManager = HighlightManager(settingsManager: settingsManager)
        self.settingsWindowController = SettingsWindowController(settingsManager: settingsManager)
    }

    // MARK: - Application Actions

    /// 退出应用程序
    /// - Note: 调用 NSApplication.terminate 完全关闭应用
    func quitApplication() {
        NSApplication.shared.terminate(nil)
    }

    /// 显示设置窗口
    /// - Note: Story 1.4 & 1.5 实现
    func showSettings() {
        settingsWindowController?.show()
        print("⚙️ 打开设置窗口")
    }

    /// 切换高亮功能
    /// - Note: Story 1.2 & 1.3 实现
    func toggleHighlight() {
        highlightManager.toggle()

        let status = highlightManager.isEnabled ? "已启用" : "已禁用"
        print("✨ 高亮效果\(status)")
    }
}
