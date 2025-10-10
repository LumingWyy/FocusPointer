# 5. State Management

## 状态管理策略

本项目将使用 SwiftUI 原生状态管理机制：

- **局部状态（Local View State）**：使用 `@State`
- **全局共享状态（Shared State）**：使用 `ObservableObject` 模式，由服务类管理（例如 `SettingsService`）

## 示例代码

```swift
import SwiftUI

struct AppSettings: Codable {
    var thickness: Double = 20.0
    var colorTheme: String = "Default"
}

class SettingsService: ObservableObject {
    @Published var settings: AppSettings

    init() {
        self.settings = AppSettings() // 实际实现中将加载保存的配置
    }
}
```

---
