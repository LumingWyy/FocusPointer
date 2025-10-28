# Aura - macOS Mouse Click Highlighter

<div align="center">

![Aura Logo](docs/images/logo.png)

**Elegant visual feedback for mouse clicks - Make your presentations crystal clear**

[![Build Status](https://github.com/YOUR_USERNAME/FocusPointer/workflows/Build%20and%20Test/badge.svg)](https://github.com/YOUR_USERNAME/FocusPointer/actions)
[![Release](https://img.shields.io/github/v/release/YOUR_USERNAME/FocusPointer)](https://github.com/YOUR_USERNAME/FocusPointer/releases)
[![License](https://img.shields.io/github/license/YOUR_USERNAME/FocusPointer)](LICENSE)
[![macOS](https://img.shields.io/badge/macOS-13.0+-blue.svg)](https://www.apple.com/macos/)

[English](#english) • [中文](#中文)

</div>

---

<a name="english"></a>
## 📖 Introduction

Aura is a lightweight mouse click highlighter designed specifically for macOS. During screen presentations, online teaching, and remote collaboration, it displays an elegant colored gradient border around mouse clicks, making it easy for your audience to follow your actions.

### Why Choose Aura?

- 🎯 **Precise Tracking**: Never lose your cursor in complex interfaces
- 🎨 **Beautiful & Comfortable**: Smooth gradient animations that don't disrupt your workflow
- ⚡ **High Performance**: Minimal resource usage with zero impact on system performance
- 🛠️ **Highly Customizable**: Multiple color themes and size options
- 🔒 **Privacy First**: Runs completely locally, collects no data

---

## ✨ Features

### Core Features

- **🖱️ Real-time Highlighting**: Display colored gradient border when holding left mouse button
- **🎨 Multiple Themes**: 5+ preset color themes to choose from
- **📏 Adjustable Size**: Small, medium, and large border thickness options
- **⚙️ Global Toggle**: Enable/disable with one click from menu bar
- **💾 Remember Settings**: Automatically save your preferences

### Technical Features

- ✅ Native macOS application (Swift + SwiftUI)
- ✅ Supports macOS 13.0 (Ventura) and above
- ✅ Menu bar resident, doesn't occupy Dock space
- ✅ Fully open source, MIT license

---

## 💾 Installation

### Method: Download DMG (Recommended)

1. Go to [Releases page](https://github.com/LumingWyy/FocusPointer/releases)
2. Download the latest `Aura-x.x.x.dmg`
3. Open the DMG file
4. Drag **Aura** to **Applications** folder

---

## 🚀 Usage

### Quick Start

1. **Launch app**: Aura appears in menu bar (top right corner)
2. **Click menu bar icon**, select **"Enable Highlighting"**
3. **Hold left mouse button**, see the highlighting effect immediately!

### Customize Settings

Click menu bar icon → **"Settings..."** → Adjust:

- **Border Thickness**: Small / Medium / Large
- **Color Theme**:
  - 🌈 Rainbow Gradient (Default)
  - 🔵 Blue Theme
  - 💚 Green Theme
  - 🔴 Red Theme
  - 🟣 Purple Theme

### Keyboard Shortcuts (Planned)

- `⌘ + Shift + H`: Toggle enable/disable
- `⌘ + Shift + ,`: Open settings

---

## 🛠️ Development

### Requirements

- macOS 13.0+
- Xcode 15.0+
- Swift 5.9+
- [XcodeGen](https://github.com/yonaskolb/XcodeGen)

### Clone Repository

```bash
git clone https://github.com/YOUR_USERNAME/FocusPointer.git
cd FocusPointer
```

### Install Dependencies

```bash
brew install xcodegen
```

### Generate Project

```bash
xcodegen generate
```

### Open in Xcode

```bash
open Aura.xcodeproj
```

### Build and Run

**Method 1: Xcode**
- Select `Aura` scheme
- Press `⌘ + R` to run

**Method 2: Command Line**
```bash
# Development build
./scripts/build.sh

# Create DMG
./scripts/create-dmg.sh

# Full release workflow
./scripts/release.sh
```

---

## 📦 Packaging and Release

### Local Packaging

```bash
# 1. Build application
./scripts/build.sh

# 2. Create DMG
./scripts/create-dmg.sh

# Output: build/Aura-x.x.x.dmg
```

### Code Signing and Notarization (Optional)

If you have an Apple Developer account:

```bash
# Edit scripts/sign-and-notarize.sh configuration
# Then run:
./scripts/sign-and-notarize.sh
```

### Auto-publish to GitHub

GitHub Actions automation is configured:

```bash
# 1. Create version tag
git tag v1.0.0
git push origin v1.0.0

# 2. GitHub Actions will automatically:
#    - Build application
#    - Create DMG
#    - Publish Release
```

---

## 📁 Project Structure

```
FocusPointer/
├── Aura/                   # Main application code
│   ├── App/               # Application entry point
│   ├── Core/              # Core functionality
│   ├── Features/          # Feature modules
│   ├── Models/            # Data models
│   └── Services/          # Service layer
├── scripts/               # Build scripts
│   ├── build.sh          # Build script
│   ├── create-dmg.sh     # DMG packaging
│   ├── release.sh        # Release workflow
│   └── sign-and-notarize.sh  # Signing and notarization
├── .github/
│   └── workflows/        # GitHub Actions
├── docs/                 # Documentation
├── project.yml           # XcodeGen configuration
└── README.md
```

---

## 🤝 Contributing

Contributions welcome! Please check [CONTRIBUTING.md](CONTRIBUTING.md)

### Roadmap

- [x] Basic highlighting functionality
- [x] Custom color themes
- [x] Adjustable border thickness
- [ ] Keyboard shortcut support
- [ ] Right-click highlighting
- [ ] Drag trail display
- [ ] Multi-monitor support optimization
- [ ] More animation effects

---

## 📄 License

[MIT License](LICENSE) © 2025

---

## 💬 Support

- 🐛 [Report Bug](https://github.com/YOUR_USERNAME/FocusPointer/issues/new?template=bug_report.md)
- 💡 [Feature Request](https://github.com/YOUR_USERNAME/FocusPointer/issues/new?template=feature_request.md)
- 💬 [Discussions](https://github.com/YOUR_USERNAME/FocusPointer/discussions)

---

## 🙏 Acknowledgments

Thanks to all contributors and supporters!

---

<div align="center">

**If you find it useful, please give it a ⭐️!**

Made with ❤️ for the macOS community

</div>

---
---

<a name="中文"></a>
# 中文说明

## 📖 简介

Aura 是一款专为 macOS 设计的轻量级鼠标点击高亮工具。在屏幕演示、在线教学和远程协作时,它能在鼠标点击处显示优雅的彩色渐变边框,让观众轻松跟随你的操作。

### 为什么选择 Aura?

- 🎯 **精准定位**: 在复杂界面中不再丢失鼠标光标
- 🎨 **美观舒适**: 平滑的渐变动画,不干扰工作流程
- ⚡ **性能优异**: 极低资源占用,完全不影响系统性能
- 🛠️ **高度可定制**: 多种颜色主题和尺寸选项
- 🔒 **隐私优先**: 完全本地运行,不收集任何数据

---

## ✨ 功能

### 核心功能

- **🖱️ 实时高亮**: 按住鼠标左键时显示彩色渐变边框
- **🎨 多种主题**: 5+ 种预设颜色主题供选择
- **📏 可调尺寸**: 小、中、大三档边框厚度
- **⚙️ 全局开关**: 通过菜单栏一键启用/禁用
- **💾 记忆设置**: 自动保存你的偏好设置

### 技术特性

- ✅ 原生 macOS 应用 (Swift + SwiftUI)
- ✅ 支持 macOS 13.0 (Ventura) 及以上
- ✅ 菜单栏常驻,不占用 Dock 空间
- ✅ 完全开源,MIT 许可证

---

## 💾 安装

### 方法: 下载 DMG (推荐)

1. 前往 [Releases 页面](https://github.com/LumingWyy/FocusPointer/releases)
2. 下载最新版本的 `Aura-x.x.x.dmg`
3. 打开 DMG 文件
4. 将 **Aura** 拖动到 **应用程序** 文件夹

---

## 🚀 使用

### 快速开始

1. **启动应用**: Aura 会出现在菜单栏 (右上角)
2. **点击菜单栏图标**,选择 **"启用高亮"**
3. **按住鼠标左键**,立即看到高亮效果!

### 自定义设置

点击菜单栏图标 → **"设置..."** → 调整:

- **边框厚度**: 小 / 中 / 大
- **颜色主题**:
  - 🌈 彩虹渐变 (默认)
  - 🔵 蓝色主题
  - 💚 绿色主题
  - 🔴 红色主题
  - 🟣 紫色主题

### 快捷键 (计划中)

- `⌘ + Shift + H`: 切换启用/禁用
- `⌘ + Shift + ,`: 打开设置

---

## 🛠️ 开发

### 环境要求

- macOS 13.0+
- Xcode 15.0+
- Swift 5.9+
- [XcodeGen](https://github.com/yonaskolb/XcodeGen)

### 克隆项目

```bash
git clone https://github.com/YOUR_USERNAME/FocusPointer.git
cd FocusPointer
```

### 安装依赖

```bash
brew install xcodegen
```

### 生成项目

```bash
xcodegen generate
```

### 在 Xcode 中打开

```bash
open Aura.xcodeproj
```

### 构建和运行

**方法一: Xcode**
- 选择 `Aura` scheme
- 按 `⌘ + R` 运行

**方法二: 命令行**
```bash
# 开发构建
./scripts/build.sh

# 创建 DMG
./scripts/create-dmg.sh

# 完整发布流程
./scripts/release.sh
```

---

## 📦 打包和发布

### 本地打包

```bash
# 1. 构建应用
./scripts/build.sh

# 2. 创建 DMG
./scripts/create-dmg.sh

# 输出: build/Aura-x.x.x.dmg
```

### 代码签名和公证 (可选)

如果你有 Apple 开发者账户:

```bash
# 编辑 scripts/sign-and-notarize.sh 配置
# 然后运行:
./scripts/sign-and-notarize.sh
```

### 自动发布到 GitHub

项目已配置 GitHub Actions 自动化:

```bash
# 1. 创建版本标签
git tag v1.0.0
git push origin v1.0.0

# 2. GitHub Actions 将自动:
#    - 构建应用
#    - 创建 DMG
#    - 发布 Release
```

---

## 📁 项目结构

```
FocusPointer/
├── Aura/                   # 主应用代码
│   ├── App/               # 应用入口
│   ├── Core/              # 核心功能
│   ├── Features/          # 功能模块
│   ├── Models/            # 数据模型
│   └── Services/          # 服务层
├── scripts/               # 构建脚本
│   ├── build.sh          # 构建脚本
│   ├── create-dmg.sh     # DMG 打包
│   ├── release.sh        # 发布流程
│   └── sign-and-notarize.sh  # 签名和公证
├── .github/
│   └── workflows/        # GitHub Actions
├── docs/                 # 文档
├── project.yml           # XcodeGen 配置
└── README.md
```

---

## 🤝 贡献

欢迎贡献! 请查看 [CONTRIBUTING.md](CONTRIBUTING.md)

### 开发路线图

- [x] 基础高亮功能
- [x] 自定义颜色主题
- [x] 可调节边框厚度
- [ ] 快捷键支持
- [ ] 右键点击高亮
- [ ] 拖拽轨迹显示
- [ ] 多显示器支持优化
- [ ] 更多动画效果

---

## 📄 许可证

[MIT License](LICENSE) © 2025

---

## 💬 支持

- 🐛 [报告 Bug](https://github.com/YOUR_USERNAME/FocusPointer/issues/new?template=bug_report.md)
- 💡 [功能建议](https://github.com/YOUR_USERNAME/FocusPointer/issues/new?template=feature_request.md)
- 💬 [讨论区](https://github.com/YOUR_USERNAME/FocusPointer/discussions)

---

## 🙏 致谢

感谢所有贡献者和支持者!

---

<div align="center">

**如果觉得有用,请给个 ⭐️ 支持一下!**

Made with ❤️ for the macOS community

</div>
