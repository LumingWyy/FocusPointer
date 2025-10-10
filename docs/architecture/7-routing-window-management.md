# 7. Routing / Window Management

## 窗口管理策略

本工具为单功能应用，因此不使用传统路由。
我们将通过 SwiftUI 的 `Settings` scene 管理设置窗口。

## 示例代码

```swift
import SwiftUI

@main
struct AuraApp: App {
    var body: some Scene {
        MenuBarExtra("Aura", systemImage: "sparkles") {
            Button("Settings...") {
                // SwiftUI 自动打开设置窗口
            }
            .keyboardShortcut(",")

            Divider()

            Button("Quit Aura") {
                NSApplication.shared.terminate(nil)
            }
            .keyboardShortcut("q")
        }

        Settings {
            SettingsView()
        }
    }
}
```

---
