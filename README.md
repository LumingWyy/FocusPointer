# Aura - macOS 鼠标点击高亮工具

<div align="center">

![Aura Logo](docs/images/logo.png)

**优雅的鼠标点击视觉反馈工具,让你的演示更清晰**

[![Build Status](https://github.com/YOUR_USERNAME/FocusPointer/workflows/Build%20and%20Test/badge.svg)](https://github.com/YOUR_USERNAME/FocusPointer/actions)
[![Release](https://img.shields.io/github/v/release/YOUR_USERNAME/FocusPointer)](https://github.com/YOUR_USERNAME/FocusPointer/releases)
[![License](https://img.shields.io/github/license/YOUR_USERNAME/FocusPointer)](LICENSE)
[![macOS](https://img.shields.io/badge/macOS-13.0+-blue.svg)](https://www.apple.com/macos/)

[下载](https://github.com/YOUR_USERNAME/FocusPointer/releases) • [功能](#-功能) • [安装](#-安装) • [使用](#-使用) • [开发](#-开发)

</div>

---

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

### 方法一: 下载 DMG (推荐)

1. 前往 [Releases 页面](https://github.com/YOUR_USERNAME/FocusPointer/releases)
2. 下载最新版本的 `Aura-x.x.x.dmg`
3. 打开 DMG 文件
4. 将 **Aura** 拖动到 **应用程序** 文件夹

### 方法二: 使用 Homebrew

```bash
brew install --cask aura
```

### 首次运行

1. 在 **应用程序** 中找到并打开 **Aura**
2. 如果看到"无法打开"提示:
   - 进入 **系统设置 > 隐私与安全性**
   - 点击"仍要打开"
3. 授予 **辅助功能** 权限:
   - **系统设置 > 隐私与安全性 > 辅助功能**
   - 勾选 **Aura**

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
