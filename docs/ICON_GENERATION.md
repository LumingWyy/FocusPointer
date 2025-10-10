# 🎨 图标生成指南

本文档说明如何为 Aura 生成和使用 App 图标。

---

## 🚀 快速生成图标

### 方法一: 在 Xcode 中预览和导出

1. **打开项目**
   ```bash
   cd /Users/rokumei_ou/workspace/FocusPointer
   open Aura.xcodeproj
   ```

2. **打开图标生成器**
   - 在 Xcode 左侧找到 `Aura/Resources/IconGenerator.swift`
   - 点击打开文件

3. **启用 Canvas 预览**
   - 按 `⌥ + ⌘ + Enter` 或
   - 点击右上角 **Editor** > **Canvas**

4. **查看预览**
   - 看到两个预览:
     - `1024x1024` - 完整图标
     - `32x32` - 简化图标

5. **导出图标**
   - 右键点击预览图像
   - **Copy** 或 **Export**
   - 保存为 PNG

---

### 方法二: 使用 Playground 批量生成

1. **创建 Playground**
   ```
   File > New > Playground
   选择 macOS > Blank
   ```

2. **复制代码**
   - 将 `IconGenerator.swift` 的内容复制到 Playground
   - 添加执行代码:
   ```swift
   // 在最后添加
   IconGenerator.generateAllIcons()
   ```

3. **运行**
   - 点击运行按钮
   - 所有图标会生成到 `~/Desktop/AuraIcons/`

---

### 方法三: 使用在线工具 (推荐新手)

#### AppIcon.co
1. 访问 https://appicon.co
2. 上传 1024x1024 图标
3. 选择 macOS
4. 下载生成的图标集

#### Figma
1. 访问 https://figma.com
2. 创建 1024x1024 画板
3. 使用设计工具绘制
4. 导出为 PNG

#### Canva
1. 访问 https://canva.com
2. 创建自定义尺寸 (1024x1024)
3. 使用模板或自定义设计
4. 下载 PNG

---

## 📐 图标设计规格

### 尺寸要求

| 尺寸 | 用途 | 文件名 |
|------|------|--------|
| 16x16 | 小图标 | `icon_16x16.png` |
| 32x32 | 小图标 @2x | `icon_16x16@2x.png` |
| 32x32 | 标准图标 | `icon_32x32.png` |
| 64x64 | 标准图标 @2x | `icon_32x32@2x.png` |
| 128x128 | 中等图标 | `icon_128x128.png` |
| 256x256 | 中等图标 @2x | `icon_128x128@2x.png` |
| 256x256 | 大图标 | `icon_256x256.png` |
| 512x512 | 大图标 @2x | `icon_256x256@2x.png` |
| 512x512 | 超大图标 | `icon_512x512.png` |
| 1024x1024 | 超大图标 @2x | `icon_512x512@2x.png` |

### 设计元素

```
┌─────────────────────────┐
│                         │
│    ╭─────────────╮     │  渐变背景
│    │   ◉◉◉◉◉   │     │  (紫蓝渐变)
│    │  ◉     ◉  │     │
│    │ ◉   ●   ◉ │     │  彩虹光环
│    │  ◉     ◉  │     │  (7色渐变)
│    │   ◉◉◉◉◉   │     │
│    ╰─────────────╯     │  中心白点
│                         │  (发光效果)
└─────────────────────────┘
```

---

## 📦 安装图标到项目

### 步骤 1: 准备图标文件

确保你有所有需要的尺寸:
```
AuraIcons/
├── icon_16x16.png
├── icon_16x16@2x.png
├── icon_32x32.png
├── icon_32x32@2x.png
├── icon_128x128.png
├── icon_128x128@2x.png
├── icon_256x256.png
├── icon_256x256@2x.png
├── icon_512x512.png
└── icon_512x512@2x.png
```

### 步骤 2: 复制到 Xcode

1. 在 Xcode 中打开项目
2. 找到 `Aura/Resources/Assets.xcassets/AppIcon.appiconset`
3. 将所有 PNG 文件拖入对应位置

### 步骤 3: 验证

- 在 Assets 中查看 AppIcon
- 所有尺寸都应该有图像
- 没有黄色警告图标

---

## 🎨 使用临时图标 (开发阶段)

如果暂时没有自定义图标,可以使用 SF Symbol:

### 更新菜单栏图标

编辑 `AuraApp.swift`:

```swift
MenuBarExtra("Aura", systemImage: "circle.circle") {  // 使用系统图标
    MenuBarView(appState: appState)
}
```

可用的 SF Symbol:
- `circle.circle` - 双圆环 ⭕
- `target` - 目标 🎯
- `sparkles` - 闪光 ✨
- `circle.dotted` - 虚线圆
- `circle.hexagongrid` - 蜂窝圆

---

## 🔍 测试图标

### 在 Finder 中查看

1. 构建应用
   ```bash
   xcodegen generate
   xcodebuild -project Aura.xcodeproj -scheme Aura build
   ```

2. 找到 .app 文件
   ```bash
   open build/Debug/
   ```

3. 查看图标
   - 在 Finder 中应该看到新图标
   - 不同视图模式下检查清晰度

### 在 Dock 中查看

1. 运行应用
2. 如果是菜单栏应用,不会显示在 Dock
3. 临时测试:注释掉 `Info.plist` 中的 `LSUIElement`

### 在 App Store 中预览

使用 Xcode:
1. Product > Archive
2. 查看存档中的图标

---

## 🐛 常见问题

### Q: 图标显示为空白或默认图标

**A**: 检查:
1. 图标文件是否正确命名
2. Contents.json 配置是否正确
3. 清理项目: Product > Clean Build Folder (⌘ + Shift + K)
4. 重新生成项目: `xcodegen generate`

### Q: 图标模糊不清

**A**: 确保:
1. 使用正确的 @2x 高分辨率图标
2. 图标是 PNG 格式,非 JPEG
3. 没有过度压缩

### Q: 图标边缘有白边

**A**:
1. 确保背景是渐变或纯色,非透明
2. 或使用圆角裁剪 (228px for 1024x1024)

### Q: 如何更新已安装应用的图标

**A**:
```bash
# 删除应用
rm -rf /Applications/Aura.app

# 清理缓存
killall Dock
killall Finder

# 重新安装
```

---

## 💡 设计技巧

### 1. 保持简洁
- 在小尺寸(16x16)仍然清晰
- 避免过多细节
- 使用粗线条和简单形状

### 2. 使用对比
- 背景和前景对比度高
- 在深色和浅色模式下都好看

### 3. 测试多种尺寸
- 在 Finder 的不同视图模式
- 在 Spotlight 搜索
- 在 Launchpad

### 4. 参考优秀设计
- 查看 macOS 内置应用图标
- 参考 App Store 热门应用
- 保持一致的视觉风格

---

## 📚 资源链接

### 设计工具
- [Figma](https://figma.com) - 专业设计工具
- [Canva](https://canva.com) - 简单易用
- [Sketch](https://sketch.com) - macOS 专用

### 图标生成器
- [AppIcon.co](https://appicon.co) - 免费在线工具
- [MakeAppIcon](https://makeappicon.com) - 批量生成
- [AppIconMaker](https://appiconmaker.co) - AI 辅助

### 设计参考
- [macOS Human Interface Guidelines](https://developer.apple.com/design/human-interface-guidelines/macos)
- [Dribbble](https://dribbble.com) - 设计灵感
- [Behance](https://behance.net) - 作品展示

---

**现在开始设计你的 Aura 图标吧! 🎨**
