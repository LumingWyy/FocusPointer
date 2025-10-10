# 9. Testing Requirements

## 单元测试模板

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

## 测试规范

- **单元测试 (Unit Tests)**：仅测试逻辑层（Service、ViewModel）
- **UI 测试 (UI Tests)**：覆盖关键用户流程
- **结构规范**：遵循 “Arrange-Act-Assert” 模式
- **依赖模拟**：通过 Mock 隔离外部依赖（如 UserDefaults）
- **覆盖率目标**：核心逻辑部分 ≥ 80%

---
