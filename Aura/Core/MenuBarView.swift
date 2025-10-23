import SwiftUI

/// 菜单栏视图组件
/// 提供可复用、可测试的菜单栏UI
struct MenuBarView: View {
    @ObservedObject var appState: AppState
    @ObservedObject var highlightManager: HighlightManager

    var body: some View {
        Group {
            // Show a checkmark to indicate current state directly in menu
            Toggle(
                isOn: Binding(
                    get: { highlightManager.isEnabled },
                    set: { highlightManager.isEnabled = $0 }
                )
            ) {
                Text(MenuBarStrings.highlight)
            }
            // Keyboard shortcut for toggling is handled globally (Ctrl+Option+Cmd+H)

            Button(MenuBarStrings.settings) {
                appState.showSettings()
            }
            .keyboardShortcut(",")

            Divider()

            Button("Debug: Flash Highlight Once") {
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
    static let highlight = "Highlight"
    static let settings = "Settings..."
    static let quit = "Quit Aura"
}

// MARK: - Preview

#Preview {
    MenuBarView(appState: AppState.shared, highlightManager: AppState.shared.highlightManager)
}
