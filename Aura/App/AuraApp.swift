import SwiftUI

/// Aura 主应用入口
/// 菜单栏应用,提供鼠标高亮功能
@main
struct AuraApp: App {
    /// 应用状态管理
    @StateObject private var appState = AppState.shared

    var body: some Scene {
        MenuBarExtra("Aura", systemImage: "sparkles") {
            MenuBarView(appState: appState)
        }
    }
}
