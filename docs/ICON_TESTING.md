# 🧪 图标测试指南

本文档提供 Aura App 图标的完整测试流程和验证方法。

---

## 📋 测试前准备

### 1. 确保已安装 Xcode

检查 Xcode 安装状态:
```bash
xcode-select -p
```

如果显示 `/Library/Developer/CommandLineTools`,说明只安装了命令行工具,需要安装完整 Xcode。

**安装方法**:
- **App Store**: 搜索 "Xcode" 并安装 (推荐)
- **xcodes CLI**: `xcodes install 15.0` (需要先安装 xcodes)

### 2. 验证项目结构

确认以下文件存在:
```bash
cd /Users/rokumei_ou/workspace/FocusPointer

# 检查图标生成器
ls -l Aura/Resources/IconGenerator.swift

# 检查 Playground
ls -l GenerateIcons.playground/

# 检查资源配置
ls -l Aura/Resources/Assets.xcassets/AppIcon.appiconset/Contents.json
```

---

## 🎨 方法 1: 使用 Playground 生成图标 (推荐)

### 步骤 1: 打开 Playground

```bash
open GenerateIcons.playground
```

### 步骤 2: 运行 Playground

1. Xcode 会自动打开 Playground
2. 点击左下角 **▶️ Run** 按钮或按 `⌘ + Shift + Return`
3. 等待几秒,右侧会显示图标预览
4. 查看控制台输出,确认所有图标已生成

**预期输出**:
```
🎨 开始生成 Aura App 图标...
✅ 已生成: icon_16x16.png (16x16)
✅ 已生成: icon_16x16@2x.png (32x32)
✅ 已生成: icon_32x32.png (32x32)
...
✅ 所有图标已生成到桌面 ~/Desktop/AuraIcons/
```

### 步骤 3: 查看生成的图标

```bash
open ~/Desktop/AuraIcons/
```

**验证清单**:
- [ ] 10 个 PNG 文件都已生成
- [ ] 文件大小合理 (16x16 约 1-5KB, 1024x1024 约 50-200KB)
- [ ] 在 Finder 预览中图标清晰无模糊
- [ ] 小尺寸图标简化版显示正常
- [ ] 大尺寸图标显示完整渐变效果

### 步骤 4: 复制图标到项目

```bash
# 复制所有图标到 Xcode 资源文件夹
cp ~/Desktop/AuraIcons/*.png Aura/Resources/Assets.xcassets/AppIcon.appiconset/

# 验证复制成功
ls -lh Aura/Resources/Assets.xcassets/AppIcon.appiconset/
```

**预期结果**: 应该看到 10 个 PNG 文件 + 1 个 Contents.json

---

## 🖼️ 方法 2: 在 Xcode 中预览图标

### 步骤 1: 打开项目

```bash
cd /Users/rokumei_ou/workspace/FocusPointer
open Aura.xcodeproj
```

### 步骤 2: 打开 IconGenerator.swift

1. 在左侧项目导航栏找到 `Aura/Resources/IconGenerator.swift`
2. 点击打开文件

### 步骤 3: 启用 Canvas 预览

1. 按 `⌥ + ⌘ + Enter` 或点击右上角 **Editor** → **Canvas**
2. 等待 Canvas 加载 (首次可能需要几分钟)

### 步骤 4: 查看预览

**预期显示**:
- **预览 1**: "1024x1024" - 显示完整版图标
  - 紫蓝渐变背景
  - 彩虹色圆环 (红→橙→黄→绿→蓝→紫)
  - 白色发光中心点

- **预览 2**: "32x32" - 显示简化版图标
  - 相同配色但更简洁
  - 更粗的线条便于小尺寸显示

### 步骤 5: 导出图标

1. 右键点击预览图像
2. 选择 **Copy** 或 **Export**
3. 保存为 PNG 格式

---

## ✅ 方法 3: 在 Xcode 中验证图标

### 步骤 1: 打开 Assets 目录

在 Xcode 中:
1. 展开 `Aura/Resources/Assets.xcassets`
2. 点击 `AppIcon`

### 步骤 2: 检查图标集

**验证清单**:
- [ ] 所有尺寸槽位都有图像 (无黄色警告图标)
- [ ] 图标在不同尺寸下清晰可辨
- [ ] 没有 "Missing" 或 "Unassigned" 提示

**图标尺寸映射**:
| 槽位 | 文件名 | 实际尺寸 |
|------|--------|----------|
| 16pt 1x | icon_16x16.png | 16x16 |
| 16pt 2x | icon_16x16@2x.png | 32x32 |
| 32pt 1x | icon_32x32.png | 32x32 |
| 32pt 2x | icon_32x32@2x.png | 64x64 |
| 128pt 1x | icon_128x128.png | 128x128 |
| 128pt 2x | icon_128x128@2x.png | 256x256 |
| 256pt 1x | icon_256x256.png | 256x256 |
| 256pt 2x | icon_256x256@2x.png | 512x512 |
| 512pt 1x | icon_512x512.png | 512x512 |
| 512pt 2x | icon_512x512@2x.png | 1024x1024 |

---

## 🚀 方法 4: 构建并测试应用中的图标

### 步骤 1: 构建应用

```bash
# 确保在项目根目录
cd /Users/rokumei_ou/workspace/FocusPointer

# 清理旧构建
rm -rf build/

# 运行构建脚本
./scripts/build.sh
```

### 步骤 2: 查看构建的应用

```bash
# 打开构建目录
open build/Export/

# 在 Finder 中查看 Aura.app 图标
```

### 步骤 3: 运行应用

```bash
# 方法 1: 直接运行
open build/Export/Aura.app

# 方法 2: 在 Xcode 中运行
# 打开 Aura.xcodeproj,按 ⌘ + R
```

### 步骤 4: 验证图标显示

**验证位置**:
- [ ] **Finder**: 在 `build/Export/` 中查看 Aura.app
- [ ] **菜单栏**: 应用运行时状态栏图标 (使用 SF Symbol "sparkles")
- [ ] **Dock**: 如果临时禁用 LSUIElement,会在 Dock 显示
- [ ] **Spotlight**: 搜索 "Aura" 查看搜索结果图标
- [ ] **Launchpad**: (如果已安装到 Applications)

**图标显示测试**:
1. **Finder 图标视图**: 确保图标清晰
2. **不同尺寸**: 切换 Finder 视图大小 (⌘ + J 调整图标大小)
3. **深色模式**: 切换系统深色/浅色模式查看对比度
4. **Retina 屏幕**: 确保高分辨率下图标锐利

---

## 🎯 完整测试流程 (推荐)

### 测试清单

#### 1. 图标生成测试 ✅
```bash
# 1.1 运行 Playground
open GenerateIcons.playground
# 在 Xcode 中运行,验证控制台输出

# 1.2 检查生成文件
ls -lh ~/Desktop/AuraIcons/
# 应有 10 个 PNG 文件

# 1.3 验证图标质量
open ~/Desktop/AuraIcons/icon_512x512@2x.png
# 查看 1024x1024 最高质量版本
```

#### 2. Xcode 集成测试 ✅
```bash
# 2.1 复制图标
cp ~/Desktop/AuraIcons/*.png Aura/Resources/Assets.xcassets/AppIcon.appiconset/

# 2.2 打开 Xcode
open Aura.xcodeproj

# 2.3 验证 Assets
# 在 Xcode 中查看 Assets.xcassets > AppIcon
# 确认无黄色警告

# 2.4 Canvas 预览
# 打开 IconGenerator.swift,启用 Canvas (⌥ + ⌘ + Enter)
```

#### 3. 构建测试 ✅
```bash
# 3.1 清理构建
xcodegen generate
rm -rf build/

# 3.2 构建应用
./scripts/build.sh

# 3.3 验证构建成功
ls -lh build/Export/Aura.app

# 3.4 查看应用图标
open build/Export/
# 在 Finder 中查看图标
```

#### 4. 运行测试 ✅
```bash
# 4.1 运行应用
open build/Export/Aura.app

# 4.2 检查状态栏
# 应在右上角状态栏看到 "sparkles" 图标

# 4.3 测试功能
# 点击状态栏图标,验证菜单
# 切换高亮效果 (⌘ + Shift + H)
# 打开设置 (⌘ + ,)
```

#### 5. 视觉质量测试 ✅

**不同尺寸检查**:
- [ ] 16x16: 简化版,线条清晰
- [ ] 32x32: 简化版,颜色分明
- [ ] 64x64: 简化版,中心点可见
- [ ] 128x128: 完整版,渐变平滑
- [ ] 256x256: 完整版,细节丰富
- [ ] 512x512: 完整版,发光效果明显
- [ ] 1024x1024: 完整版,最高质量

**视觉效果检查**:
- [ ] 背景渐变: 紫蓝色渐变平滑
- [ ] 彩虹环: 七色渐变自然过渡
- [ ] 中心点: 白色发光效果清晰
- [ ] 圆角: Big Sur 风格圆角合适
- [ ] 边缘: 无锯齿,无模糊

**系统集成检查**:
- [ ] Finder 各种视图模式显示正常
- [ ] 深色模式下对比度良好
- [ ] 浅色模式下视觉清晰
- [ ] Spotlight 搜索结果显示正确
- [ ] 与其他 macOS 应用风格协调

---

## 🐛 常见问题排查

### 问题 1: Playground 无法运行

**症状**:
- 点击运行无反应
- 报错 "Failed to build module"

**解决方法**:
```bash
# 1. 重启 Xcode
killall Xcode
open GenerateIcons.playground

# 2. 清理 Playground 缓存
rm -rf ~/Library/Developer/Xcode/UserData/Playground\ *

# 3. 检查 Xcode 版本
xcodebuild -version
# 需要 Xcode 14+ 和 macOS 13+
```

### 问题 2: 图标显示为空白

**症状**: Assets 中图标槽位为空

**解决方法**:
```bash
# 1. 确认文件存在
ls -l Aura/Resources/Assets.xcassets/AppIcon.appiconset/*.png

# 2. 重新复制图标
rm Aura/Resources/Assets.xcassets/AppIcon.appiconset/*.png
cp ~/Desktop/AuraIcons/*.png Aura/Resources/Assets.xcassets/AppIcon.appiconset/

# 3. 验证 Contents.json
cat Aura/Resources/Assets.xcassets/AppIcon.appiconset/Contents.json

# 4. 重新生成项目
xcodegen generate
```

### 问题 3: 构建后图标未更新

**症状**: Finder 中 Aura.app 显示旧图标

**解决方法**:
```bash
# 1. 清理缓存
rm -rf ~/Library/Caches/com.apple.iconservices.store
killall Finder
killall Dock

# 2. 清理构建
rm -rf build/
rm -rf ~/Library/Developer/Xcode/DerivedData/Aura-*

# 3. 重新构建
./scripts/build.sh

# 4. 重新打开 Finder
open build/Export/
```

### 问题 4: 图标模糊或像素化

**症状**: 图标在某些尺寸下不清晰

**解决方法**:

1. **检查文件质量**:
```bash
# 查看文件大小
ls -lh ~/Desktop/AuraIcons/

# 1024x1024 应约 50-200KB
# 16x16 应约 1-5KB
```

2. **重新生成高质量图标**:
- 在 Playground 中确保 `size` 参数正确
- 检查渐变和阴影半径是否成比例

3. **验证 @2x 图标**:
- 确保高分辨率图标文件大小是标准版的 4 倍

### 问题 5: Canvas 预览不显示

**症状**: 点击 Canvas 按钮后一直加载

**解决方法**:
```bash
# 1. 重启 Canvas
# 在 Xcode 中: Editor > Canvas > Restart Canvas

# 2. 清理 Xcode 缓存
rm -rf ~/Library/Developer/Xcode/UserData

# 3. 重新打开项目
killall Xcode
xcodegen generate
open Aura.xcodeproj
```

---

## 📊 图标质量标准

### 技术标准

| 指标 | 要求 | 实际 |
|------|------|------|
| 格式 | PNG | ✅ |
| 颜色空间 | sRGB | ✅ |
| 透明度 | 不透明 | ✅ |
| 最大尺寸 | 1024x1024 | ✅ |
| 文件大小 | < 500KB | ✅ |
| 圆角 | Big Sur (22.27%) | ✅ |

### 设计标准

| 指标 | 要求 | 评分 |
|------|------|------|
| 识别度 | 独特且易识别 | ⭐⭐⭐⭐⭐ |
| 简洁性 | 小尺寸可辨 | ⭐⭐⭐⭐⭐ |
| 适应性 | 深浅色模式都好看 | ⭐⭐⭐⭐⭐ |
| 一致性 | 符合 macOS 风格 | ⭐⭐⭐⭐⭐ |
| 关联性 | 反映应用功能 | ⭐⭐⭐⭐⭐ |

---

## 📝 测试报告模板

完成测试后,填写以下报告:

```markdown
# Aura App 图标测试报告

## 测试信息
- **测试日期**: YYYY-MM-DD
- **测试人员**: [姓名]
- **系统版本**: macOS [版本]
- **Xcode 版本**: [版本]

## 测试结果

### 1. 图标生成
- [ ] Playground 运行成功
- [ ] 所有 10 个图标已生成
- [ ] 文件大小合理
- [ ] 图标质量清晰

### 2. Xcode 集成
- [ ] 图标已复制到 Assets
- [ ] 无黄色警告
- [ ] Canvas 预览正常
- [ ] 所有槽位已填充

### 3. 构建测试
- [ ] 构建成功 (无错误)
- [ ] Aura.app 已生成
- [ ] Finder 中显示图标
- [ ] 应用可正常运行

### 4. 视觉质量
- [ ] 所有尺寸清晰
- [ ] 渐变效果平滑
- [ ] 彩虹环颜色正确
- [ ] 中心点发光明显
- [ ] 深浅色模式都好看

## 问题记录
[描述遇到的任何问题]

## 改进建议
[可选的设计或实现改进]

## 总体评价
⭐⭐⭐⭐⭐ (1-5 星)
```

---

## 🎉 测试完成后

### 提交代码

```bash
cd /Users/rokumei_ou/workspace/FocusPointer

# 添加生成的图标
git add Aura/Resources/Assets.xcassets/AppIcon.appiconset/*.png

# 提交
git commit -m "feat: 添加 App 图标资源文件

- 使用 Playground 生成所有尺寸图标 (16x16 到 1024x1024)
- 彩虹渐变光环设计
- 紫蓝渐变背景 + 白色发光中心点
- 符合 macOS Big Sur 设计语言
- 小尺寸使用简化版本保证清晰度

测试: ✅ 所有尺寸在 Finder/Spotlight/Dock 显示正常"

# 推送
git push origin develop
```

### 创建 Release

图标完成后,可以准备 v1.0.0 正式版发布:

```bash
# 合并到 main
git checkout main
git merge develop
git push origin main

# auto-release.yml 会自动创建 release
```

---

**🎨 现在你可以开始测试图标了!**

推荐测试顺序:
1. ✅ 运行 Playground 生成图标
2. ✅ 查看生成的文件
3. ✅ 复制到 Xcode Assets
4. ✅ 在 Canvas 中预览
5. ✅ 构建并运行应用
6. ✅ 验证图标在 Finder 中显示

祝测试顺利! 🚀
