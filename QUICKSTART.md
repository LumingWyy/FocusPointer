# 🚀 Aura 快速开始指南

立即生成你的 App 图标并测试应用!

---

## ⚡ 5 分钟快速上手

### 1️⃣ 生成图标 (2 分钟)

```bash
# 打开 Playground
open GenerateIcons.playground
```

**操作步骤**:
1. Xcode 会自动打开
2. 点击 **▶️ Run** (或按 `⌘ + Shift + Return`)
3. 等待 3-5 秒
4. 查看右侧预览 - 你会看到两个图标预览
5. 查看桌面 - 所有图标已生成到 `~/Desktop/AuraIcons/`

**验证**:
```bash
# 查看生成的图标
open ~/Desktop/AuraIcons/
# 应该有 10 个 PNG 文件
```

---

### 2️⃣ 集成图标到项目 (1 分钟)

```bash
# 复制图标到 Xcode 资源文件夹
cp ~/Desktop/AuraIcons/*.png Aura/Resources/Assets.xcassets/AppIcon.appiconset/

# 验证复制成功
ls -lh Aura/Resources/Assets.xcassets/AppIcon.appiconset/*.png
# 应该看到 10 个 PNG 文件
```

---

### 3️⃣ 运行应用 (2 分钟)

**方法 A: 使用 Xcode (推荐)**
```bash
# 打开项目
open Aura.xcodeproj

# 在 Xcode 中按 ⌘ + R 运行
```

**方法 B: 使用构建脚本**
```bash
# 构建应用
./scripts/build.sh

# 运行
open build/Export/Aura.app
```

**验证**:
- ✅ 应用在状态栏显示 (右上角闪光图标)
- ✅ 点击图标查看菜单
- ✅ 按 `⌘ + Shift + H` 切换高亮效果
- ✅ 按 `⌘ + ,` 打开设置

---

## 🎨 功能测试清单

### 基础功能
- [ ] **鼠标高亮**: 按住鼠标左键,看到彩虹圆环
- [ ] **菜单栏控制**: 点击状态栏图标,看到菜单
- [ ] **快捷键切换**: `⌘ + Shift + H` 开关高亮
- [ ] **设置面板**: `⌘ + ,` 打开设置

### 设置功能
- [ ] **边框粗细**: 在设置中切换 小/中/大
- [ ] **颜色主题**: 测试 5 种主题 (彩虹/蓝色/绿色/红色/紫色)
- [ ] **实时预览**: 设置更改立即生效
- [ ] **设置持久化**: 关闭重启后设置保留

### 图标显示
- [ ] **Finder 中查看**: 在 `build/Export/` 查看 Aura.app 图标
- [ ] **不同尺寸**: 在 Finder 中调整图标大小 (`⌘ + J`)
- [ ] **深色模式**: 切换系统主题查看对比度

---

## 📚 详细文档

### 用户文档
- **README.md** - 完整项目介绍 (中英双语)
- **docs/LOCAL_TESTING.md** - 本地测试指南

### 开发文档
- **docs/ARCHITECTURE.md** - 架构设计
- **docs/DEVELOPMENT.md** - 开发指南
- **docs/ROADMAP.md** - 功能路线图

### 图标文档
- **docs/ICON_DESIGN.md** - 设计理念和规格
- **docs/ICON_GENERATION.md** - 生成方法详解
- **docs/ICON_TESTING.md** - 完整测试流程

### 发布文档
- **docs/RELEASE_WORKFLOW.md** - 发布流程和版本管理

---

## 🐛 遇到问题?

### 问题 1: Playground 无法运行

**症状**: 点击运行无反应

**解决**:
```bash
# 重启 Xcode
killall Xcode
open GenerateIcons.playground
```

### 问题 2: xcodebuild 报错

**症状**: `tool 'xcodebuild' requires Xcode`

**解决**:
- 你需要安装完整的 Xcode (不只是 Command Line Tools)
- 从 App Store 搜索 "Xcode" 安装

### 问题 3: 图标显示为空白

**症状**: Assets 中图标槽位为空

**解决**:
```bash
# 重新复制图标
cp ~/Desktop/AuraIcons/*.png Aura/Resources/Assets.xcassets/AppIcon.appiconset/

# 重新生成项目
xcodegen generate
```

### 问题 4: 应用无法运行

**症状**: 点击 ⌘ + R 无反应

**解决**:
1. 检查是否选择了正确的 Scheme (左上角应显示 "Aura")
2. 查看构建日志: `⌘ + 9` 打开 Report Navigator
3. 参考 `docs/LOCAL_TESTING.md` 中的调试章节

---

## 🎯 下一步

### 立即推送代码
```bash
# 推送图标相关更改
git push origin develop
```

### 准备发布 v1.0.0
```bash
# 合并到 main 分支
git checkout main
git merge develop
git push origin main

# auto-release.yml 会自动:
# - 创建 v1.0.0 tag
# - 构建 DMG 安装包
# - 生成 Release Notes
# - 上传到 GitHub Releases
```

### 继续开发

查看 `docs/ROADMAP.md` 了解计划的功能:
- ⌨️ 自定义快捷键
- 🖱️ 右键点击高亮
- 🎨 拖拽轨迹显示
- ⚙️ 更多自定义选项

---

## 📞 获取帮助

- **文档**: 查看 `docs/` 文件夹中的详细文档
- **问题**: 在 GitHub Issues 报告问题
- **讨论**: 在 GitHub Discussions 参与讨论

---

**🎉 现在开始使用 Aura 吧!**

运行 `open GenerateIcons.playground` 生成你的第一个图标! 🚀
