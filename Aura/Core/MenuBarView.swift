import SwiftUI

/// 菜单栏视图组件
/// 提供可复用、可测试的菜单栏UI
struct MenuBarView: View {
    @ObservedObject var appState: AppState

    var body: some View {
        Group {
            Button(MenuBarStrings.toggleHighlight) {
                appState.toggleHighlight()
            }

            Button(MenuBarStrings.settings) {
                appState.showSettings()
            }
            .keyboardShortcut(",")

            Divider()

            Button("调试：闪现高亮一次") {
                appState.debugFlashHighlightOnce()
            }

            Divider()

            Button(MenuBarStrings.quit) {
                appState.quitApplication()
            }
            .keyboardShortcut("q")
        }
    }
}

// MARK: - Localization Strings

/// 菜单栏本地化字符串
/// 集中管理UI文本,便于未来国际化
private enum MenuBarStrings {
    static let toggleHighlight = "启用/禁用高亮"
    static let settings = "设置..."
    static let quit = "退出 Aura"
}

// MARK: - Preview

#Preview {
    MenuBarView(appState: AppState.shared)
}
