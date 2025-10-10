# 📦 手动生成 DMG 安装包指南

由于没有安装完整的 Xcode，我们使用 Xcode GUI 来构建应用，然后使用脚本创建 DMG。

---

## 🚀 完整流程（5 步骤）

### ✅ 第 1 步：打开项目

```bash
cd /Users/rokumei_ou/workspace/FocusPointer
open Aura.xcodeproj
```

---

### ✅ 第 2 步：在 Xcode 中构建 Release 版本

1. **选择正确的 Scheme**
   - 左上角确保选择了 **Aura** (不是 AuraTests)
   - 旁边选择 **My Mac**

2. **选择 Release 配置**
   - 菜单: **Product** → **Scheme** → **Edit Scheme...**
   - 左侧选择 **Run**
   - 右侧 **Build Configuration** 改为 **Release**
   - 点击 **Close**

3. **清理并构建**
   ```
   ⌘ + Shift + K    (Clean Build Folder)
   ⌘ + B            (Build)
   ```

4. **等待构建完成**
   - 查看顶部状态栏: "Build Succeeded" ✅
   - 或打开 Report Navigator (⌘ + 9) 查看详细日志

---

### ✅ 第 3 步：找到构建的 .app 文件

**方法 1: 使用 Finder**

1. 在 Xcode 左侧导航栏，选择 **Products** 文件夹
2. 找到 **Aura.app**
3. 右键点击 → **Show in Finder**

**方法 2: 使用命令行**

```bash
# 查找构建目录
find ~/Library/Developer/Xcode/DerivedData -name "Aura.app" -type d 2>/dev/null

# 或使用更精确的搜索
find ~/Library/Developer/Xcode/DerivedData/Aura-* -name "Aura.app" -path "*/Build/Products/Release/*" 2>/dev/null
```

**方法 3: 自动脚本**

```bash
# 我已经为你准备了查找脚本
./scripts/find-app.sh
```

---

### ✅ 第 4 步：创建导出目录并复制应用

一旦找到 Aura.app，运行以下命令：

```bash
# 创建导出目录
mkdir -p build/Export

# 复制 .app 文件 (替换 <PATH_TO_AURA_APP> 为实际路径)
# 例如: ~/Library/Developer/Xcode/DerivedData/Aura-xxx/Build/Products/Release/Aura.app
cp -R <PATH_TO_AURA_APP> build/Export/

# 验证
ls -lh build/Export/Aura.app
```

**快捷方式 - 自动查找并复制：**

```bash
# 运行自动脚本
./scripts/copy-built-app.sh
```

---

### ✅ 第 5 步：创建 DMG 安装包

```bash
# 运行 DMG 创建脚本
./scripts/create-dmg.sh

# 等待完成，你会看到:
# ✅ DMG 已创建: build/Aura-1.0.0.dmg
```

**验证 DMG：**

```bash
# 查看生成的文件
ls -lh build/*.dmg

# 打开 DMG 测试
open build/Aura-1.0.0.dmg
```

---

## 🎯 一键脚本（推荐）

我为你创建了自动化脚本，合并步骤 3-5：

```bash
# 运行一键打包脚本
./scripts/package-from-xcode.sh

# 这个脚本会:
# 1. 自动查找 Xcode 构建的 Aura.app
# 2. 复制到 build/Export/
# 3. 创建 DMG 安装包
# 4. 生成 SHA256 校验和
```

---

## 📋 完整命令清单

**如果你已经在 Xcode 中构建了 Release 版本：**

```bash
# 1. 查找并复制应用
./scripts/copy-built-app.sh

# 2. 创建 DMG
./scripts/create-dmg.sh

# 3. 验证
open build/Aura-1.0.0.dmg
```

**或者使用一键脚本：**

```bash
./scripts/package-from-xcode.sh
```

---

## 🐛 常见问题

### Q1: 找不到 Aura.app

**原因**: 可能只构建了 Debug 版本

**解决**:
1. 在 Xcode 中确认 Build Configuration 是 **Release**
2. 重新构建 (⌘ + Shift + K, 然后 ⌘ + B)

### Q2: DMG 创建失败

**症状**: "No such file or directory: build/Export/Aura.app"

**解决**:
```bash
# 检查应用是否存在
ls -la build/Export/

# 如果不存在，重新复制
./scripts/copy-built-app.sh
```

### Q3: Xcode 构建失败

**症状**: 构建错误，无法生成 Aura.app

**解决**:
1. 清理构建: ⌘ + Shift + K
2. 重新生成项目:
   ```bash
   xcodegen generate
   ```
3. 重新打开项目:
   ```bash
   open Aura.xcodeproj
   ```
4. 再次构建: ⌘ + B

### Q4: 图标未显示

**症状**: DMG 中的应用没有图标

**解决**:
```bash
# 确认图标已复制
ls -la Aura/Resources/Assets.xcassets/AppIcon.appiconset/*.png

# 如果缺少图标，重新生成
swift scripts/generate-icons-cli.swift
cp ~/Desktop/AuraIcons/*.png Aura/Resources/Assets.xcassets/AppIcon.appiconset/

# 重新构建
```

---

## ✨ 测试 DMG

打开生成的 DMG 后，你应该看到：

1. **Aura.app** - 应用图标 (彩虹光环)
2. **Applications 快捷方式** - 拖拽安装

**测试安装：**
```bash
# 方法 1: 从 DMG 拖拽
open build/Aura-1.0.0.dmg
# 将 Aura.app 拖到 Applications 文件夹

# 方法 2: 命令行安装
cp -R build/Export/Aura.app /Applications/

# 运行应用
open /Applications/Aura.app
```

---

## 📦 发布到 GitHub

```bash
# 1. 提交图标文件
git add Aura/Resources/Assets.xcassets/AppIcon.appiconset/*.png
git commit -m "feat: 添加应用图标资源"

# 2. 推送代码
git push origin develop

# 3. 手动上传 DMG
# - 访问 https://github.com/LumingWyy/FocusPointer/releases
# - 点击 "Draft a new release"
# - 上传 build/Aura-1.0.0.dmg
# - 上传 build/Aura-1.0.0.dmg.sha256
```

---

**🎉 完成！你的 Aura.app 已打包为 DMG 安装文件！**
