import Foundation
import SwiftUI

/// 应用全局状态管理
/// 遵循 MVVM 架构模式,提供集中式状态管理
@MainActor
final class AppState: ObservableObject {
    /// 单例实例
    static let shared = AppState()

    /// 私有初始化确保单例模式
    private init() {}

    // MARK: - Application Actions

    /// 退出应用程序
    /// - Note: 调用 NSApplication.terminate 完全关闭应用
    func quitApplication() {
        NSApplication.shared.terminate(nil)
    }

    /// 显示设置窗口 (占位)
    /// - Note: 将在 Story 1.4 中实现
    func showSettings() {
        // 占位 - 功能将在故事 1.4 实现
        print("Settings menu item clicked - implementation pending")
    }

    /// 切换高亮功能 (占位)
    /// - Note: 将在 Story 1.3 中实现
    func toggleHighlight() {
        // 占位 - 功能将在故事 1.3 实现
        print("Toggle highlight clicked - implementation pending")
    }
}
