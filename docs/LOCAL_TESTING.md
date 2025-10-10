# 🧪 本地测试指南

本文档说明如何在你的 Mac 上本地运行和测试 Aura 应用。

---

## 📋 前置要求

### 必需安装

1. **Xcode** (完整版)
   - 从 App Store 安装,或
   - 使用 `xcodes` 工具安装

2. **XcodeGen**
   ```bash
   brew install xcodegen
   ```

### 检查安装

```bash
# 检查 Xcode
xcodebuild -version

# 检查 Swift
swift --version

# 检查 XcodeGen
xcodegen --version
```

---

## 🚀 方式一: 使用 Xcode GUI (推荐新手)

### 步骤 1: 生成项目

```bash
cd /Users/rokumei_ou/workspace/FocusPointer
xcodegen generate
```

### 步骤 2: 打开 Xcode

```bash
open Aura.xcodeproj
```

或在 Finder 中双击 `Aura.xcodeproj`

### 步骤 3: 运行应用

在 Xcode 中:

1. **选择目标设备**
   - 顶部工具栏: `Aura > My Mac`

2. **运行应用**
   - 点击左上角 ▶️ 按钮
   - 或按快捷键: `⌘ + R`

3. **调试**
   - 查看控制台输出: `View > Debug Area > Activate Console` (⌘ + Shift + Y)
   - 设置断点: 点击代码行号左侧

### 步骤 4: 测试功能

应用启动后:

1. **查看菜单栏**
   - Aura 图标出现在顶部菜单栏(右上角)

2. **启用高亮**
   - 点击菜单栏图标
   - 选择 "启用高亮" (如果有)

3. **测试点击效果**
   - 按住鼠标左键
   - 应该看到高亮边框

4. **打开设置**
   - 点击菜单栏图标
   - 选择 "设置..." (如果实现)

### 常用快捷键

| 快捷键 | 功能 |
|--------|------|
| `⌘ + R` | 运行应用 |
| `⌘ + .` | 停止运行 |
| `⌘ + B` | 构建项目 |
| `⌘ + U` | 运行测试 |
| `⌘ + Shift + K` | 清理构建 |

---

## 💻 方式二: 使用命令行 (开发者)

### 完整构建流程

```bash
# 1. 生成项目
xcodegen generate

# 2. 构建应用
xcodebuild \
  -project Aura.xcodeproj \
  -scheme Aura \
  -configuration Debug \
  -destination 'platform=macOS' \
  build

# 3. 运行应用
open build/Debug/Aura.app
```

### 使用构建脚本

```bash
# 一键构建 (需要完整 Xcode)
./scripts/build.sh

# 构建成功后,应用在:
# build/Export/Aura.app
```

### 快速运行

```bash
# 构建并立即运行
xcodebuild \
  -project Aura.xcodeproj \
  -scheme Aura \
  -configuration Debug \
  build && \
open ~/Library/Developer/Xcode/DerivedData/Aura-*/Build/Products/Debug/Aura.app
```

---

## 🧪 运行测试

### 在 Xcode 中

1. 打开项目: `open Aura.xcodeproj`
2. 按 `⌘ + U` 运行所有测试
3. 查看测试结果: `View > Navigators > Test Navigator` (⌘ + 6)

### 命令行

```bash
xcodebuild test \
  -project Aura.xcodeproj \
  -scheme Aura \
  -destination 'platform=macOS'
```

---

## 🔍 调试技巧

### 1. 查看应用日志

```bash
# 实时查看日志
log stream --predicate 'process == "Aura"' --level debug

# 或在 Xcode Console 查看
```

### 2. 检查权限

```bash
# 检查辅助功能权限
sqlite3 ~/Library/Application\ Support/com.apple.TCC/TCC.db \
  "SELECT service, client FROM access WHERE client LIKE '%Aura%'"
```

### 3. 重置应用数据

```bash
# 删除用户偏好设置
defaults delete com.aura.Aura

# 清理 DerivedData
rm -rf ~/Library/Developer/Xcode/DerivedData/Aura-*
```

### 4. 检查进程

```bash
# 查看 Aura 是否在运行
ps aux | grep Aura

# 强制退出
pkill -f Aura
```

---

## 🐛 常见问题

### Q1: Xcode 无法打开项目

**A**: 重新生成项目
```bash
xcodegen generate
open Aura.xcodeproj
```

### Q2: 编译错误

**A**: 清理构建
```bash
# 在 Xcode 中: Product > Clean Build Folder (⌘ + Shift + K)

# 或命令行:
xcodebuild clean -project Aura.xcodeproj -scheme Aura
```

### Q3: 应用无法启动

**A**: 检查:
1. 是否授予辅助功能权限
   - 系统设置 > 隐私与安全性 > 辅助功能
   - 添加 Aura

2. 是否有其他实例在运行
   ```bash
   pkill -f Aura
   ```

### Q4: 看不到菜单栏图标

**A**: 检查 `Info.plist`:
```bash
# 确认 LSUIElement 为 true (菜单栏应用)
/usr/libexec/PlistBuddy -c "Print :LSUIElement" Aura/Info.plist
```

### Q5: "xcodebuild requires Xcode" 错误

**A**: 需要安装完整的 Xcode
```bash
# 方法 1: App Store 安装

# 方法 2: 使用 xcodes
brew install xcodesorg/made/xcodes
xcodes install --latest

# 设置 Xcode 路径
sudo xcode-select --switch /Applications/Xcode.app/Contents/Developer
```

---

## 📦 创建测试 DMG

### 本地打包

```bash
# 1. 构建应用
./scripts/build.sh

# 2. 创建 DMG
./scripts/create-dmg.sh

# 输出: build/Aura-1.0.0.dmg
```

### 测试 DMG

```bash
# 1. 打开 DMG
open build/Aura-1.0.0.dmg

# 2. 拖动到测试文件夹
cp -R /Volumes/Aura/Aura.app ~/Desktop/Test/

# 3. 运行测试
open ~/Desktop/Test/Aura.app
```

---

## 🔧 开发工作流

### 标准开发流程

```bash
# 1. 创建功能分支
git checkout -b feature/my-feature

# 2. 开发
# - 在 Xcode 中修改代码
# - 按 ⌘ + R 运行测试

# 3. 运行测试
# 在 Xcode 中按 ⌘ + U

# 4. 提交
git add .
git commit -m "feat: 添加新功能"

# 5. 合并
git checkout develop
git merge feature/my-feature
```

### 快速迭代

```bash
# 修改代码后
# 在 Xcode 中: ⌘ + R (自动重新编译)

# 或命令行快速重新编译
xcodebuild -project Aura.xcodeproj -scheme Aura | xcpretty
```

---

## 🎯 性能分析

### 使用 Instruments

1. 在 Xcode: `Product > Profile` (⌘ + I)
2. 选择模板:
   - **Time Profiler**: CPU 使用
   - **Allocations**: 内存使用
   - **Leaks**: 内存泄漏

### 命令行分析

```bash
# CPU 使用
xcrun xctrace record --template 'Time Profiler' \
  --launch build/Debug/Aura.app

# 内存使用
leaks -atExit -- build/Debug/Aura.app/Contents/MacOS/Aura
```

---

## 📊 代码质量检查

### 静态分析

```bash
# 在 Xcode: Product > Analyze (⌘ + Shift + B)

# 或命令行
xcodebuild analyze \
  -project Aura.xcodeproj \
  -scheme Aura
```

### 代码覆盖率

```bash
# 运行测试并生成覆盖率报告
xcodebuild test \
  -project Aura.xcodeproj \
  -scheme Aura \
  -enableCodeCoverage YES
```

---

## 🔗 相关资源

- [Xcode 文档](https://developer.apple.com/xcode/)
- [Swift 文档](https://docs.swift.org/)
- [SwiftUI 教程](https://developer.apple.com/tutorials/swiftui)
- [macOS 开发指南](https://developer.apple.com/macos/)

---

## 💡 开发技巧

### 1. 实时预览 (SwiftUI)

在 Xcode 中启用 Canvas:
- `Editor > Canvas` (⌥ + ⌘ + Enter)
- 实时预览 UI 变化

### 2. 快速重启应用

```bash
# 创建别名
alias restart-aura="pkill -f Aura && open build/Debug/Aura.app"
```

### 3. 监控文件变化

```bash
# 使用 fswatch 自动重新编译
brew install fswatch

fswatch -o Aura/ | while read; do
    xcodebuild -project Aura.xcodeproj -scheme Aura
done
```

---

**祝开发顺利! 🚀**
