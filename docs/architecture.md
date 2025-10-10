
# 前端架构文档：macOS 点击高亮工具

## 1. 模板和框架选择

根据 PRD 中的技术假设，我们已确认本项目将 **不使用任何现有的启动模板**。  
我们将从零开始构建一个原生的 macOS 应用程序，以确保最佳的性能和与系统的最深度集成。

---

## 2. 前端技术栈

这是指导我们开发工作的最终技术选型。所有组件都将基于苹果官方推荐的现代 macOS 开发技术。

| 类别 | 技术 | 版本/说明 | 用途 | 理由 |
| :--- | :--- | :--- | :--- | :--- |
| **语言** | Swift | 最新稳定版 | 主要开发语言 | 苹果官方推荐，类型安全，性能高 |
| **框架** | SwiftUI | 最新稳定版 | UI 构建与状态管理 | 现代化的声明式 UI 框架，能快速构建原生界面 |
| **UI 库** | 原生 SwiftUI 组件 | 系统内置 | 构成应用界面的基础元素 | 确保 100% 原生外观和体验，自动支持深色模式等 |
| **构建工具** | Xcode Build System | Xcode 内置 | 编译、打包和签名应用 | 官方工具链，集成度最高，无需额外配置 |
| **测试** | XCTest | Xcode 内置 | 单元测试和集成测试 | 苹果官方测试框架，与 Swift/SwiftUI 无缝集成 |

---

## 3. Project Structure

```plaintext
Aura/
├── Aura.xcodeproj
└── Aura/
    ├── App/
    │   └── AuraApp.swift           # Main application entry point
    ├── Core/
    │   ├── EventHandler/           # Global mouse event listener logic
    │   └── HighlightView/          # The SwiftUI View that draws the gradient border
    ├── Features/
    │   └── Settings/
    │       ├── SettingsView.swift        # The UI for the settings panel
    │       └── SettingsViewModel.swift   # State and logic for the settings view
    ├── Models/
    │   └── AppSettings.swift             # Data model for all user-configurable settings
    ├── Services/
    │   ├── PermissionsManager.swift      # Logic for checking/requesting Accessibility permissions
    │   └── SettingsService.swift         # Logic for saving and loading settings to disk
    └── Resources/
        └── Assets.xcassets               # To store the menu bar icon and other assets
```



## 4. Component Standards

### Component Template

所有新的 SwiftUI View 必须遵循以下模板以保持一致性：

```swift
import SwiftUI

struct YourViewName: View {
    // MARK: - Properties
  
    // MARK: - View Body
  
    var body: some View {
        Text("Hello, World!")
    }
  
    // MARK: - Private Helpers
}

// MARK: - Preview

#Preview {
    YourViewName()
}
```

### Naming Conventions


| 类型              | 命名规则                               | 示例                      |
| :---------------- | :------------------------------------- | :------------------------ |
| Views             | PascalCase +`View` 后缀                | `SettingsView.swift`      |
| ViewModels        | PascalCase +`ViewModel` 后缀           | `SettingsViewModel.swift` |
| Models            | PascalCase 无后缀                      | `AppSettings.swift`       |
| Services/Managers | PascalCase +`Service` / `Manager` 后缀 | `SettingsService.swift`   |

---

## 5. State Management

### 状态管理策略

本项目将使用 SwiftUI 原生状态管理机制：

- **局部状态（Local View State）**：使用 `@State`
- **全局共享状态（Shared State）**：使用 `ObservableObject` 模式，由服务类管理（例如 `SettingsService`）

### 示例代码

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

## 6. API Integration

### API 集成策略

该应用是一个完全本地的桌面工具。
在当前 MVP 范围内，不依赖任何远程服务器或网络 API。
**此部分暂不适用。**

---

## 7. Routing / Window Management

### 窗口管理策略

本工具为单功能应用，因此不使用传统路由。
我们将通过 SwiftUI 的 `Settings` scene 管理设置窗口。

### 示例代码

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

## 8. Styling Guidelines

### 样式定义策略

我们将完全使用 SwiftUI 的声明式修饰符定义外观，所有样式均直接在 Swift 代码中定义。

### 复用样式与主题

- 使用自定义 `ButtonStyle` 等组件以保证视觉一致性
- 颜色与字体遵循系统语义化方案 (`system semantic colors`, `dynamic fonts`)
- 全局主题遵循品牌风格指南

---

## 9. Testing Requirements

### 单元测试模板

```swift
import XCTest
@testable import Aura

final class SettingsServiceTests: XCTestCase {
    var settingsService: SettingsService!

    override func setUpWithError() throws {
        settingsService = SettingsService()
    }

    override func tearDownWithError() throws {
        settingsService = nil
    }

    func testUpdateThickness() {
        // Arrange
        let newThickness = 40.0
        // Act
        settingsService.settings.thickness = newThickness
        // Assert
        XCTAssertEqual(settingsService.settings.thickness, newThickness)
    }
}
```

### 测试规范

- **单元测试 (Unit Tests)**：仅测试逻辑层（Service、ViewModel）
- **UI 测试 (UI Tests)**：覆盖关键用户流程
- **结构规范**：遵循 “Arrange-Act-Assert” 模式
- **依赖模拟**：通过 Mock 隔离外部依赖（如 UserDefaults）
- **覆盖率目标**：核心逻辑部分 ≥ 80%

---

## 10. Environment Configuration / Build Settings

### 构建配置

使用 Xcode 标准的两种构建模式：


| 模式        | 用途       | 特性                       |
| :---------- | :--------- | :------------------------- |
| **Debug**   | 开发与调试 | 启用调试符号，无优化       |
| **Release** | 发布分发   | 移除调试符号，启用性能优化 |

---

## 11. Frontend Developer Standards

### 核心开发规范

1. **状态不可变性**：不要直接在 View 内修改共享状态，必须通过 Service 方法更新
2. **纯净视图 (Pure View)**：View 的 `body` 中禁止执行副作用（如文件访问、复杂计算）
3. **优先使用原生组件**：除非必要，否则不自定义 UI
4. **权限优先**：使用系统特性前，必须检查并请求权限（如 Accessibility）
5. **服务层抽象**：所有持久化逻辑统一通过 Service 层实现（如 `SettingsService`）

---

### 快捷键参考


| 操作     | 快捷键 |
| :------- | :----- |
| 运行应用 | ⌘R    |
| 构建项目 | ⌘B    |
| 运行测试 | ⌘U    |

```

```
