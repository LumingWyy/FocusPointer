# 4. Component Standards

## Component Template

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

## Naming Conventions


| 类型              | 命名规则                               | 示例                      |
| :---------------- | :------------------------------------- | :------------------------ |
| Views             | PascalCase +`View` 后缀                | `SettingsView.swift`      |
| ViewModels        | PascalCase +`ViewModel` 后缀           | `SettingsViewModel.swift` |
| Models            | PascalCase 无后缀                      | `AppSettings.swift`       |
| Services/Managers | PascalCase +`Service` / `Manager` 后缀 | `SettingsService.swift`   |

---
