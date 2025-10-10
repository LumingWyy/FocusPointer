# 🚀 快速生成 DMG 指南

## ⚡ 3 个步骤，5 分钟完成

---

### 📱 第 1 步：在 Xcode 中构建（2 分钟）

Xcode 应该已经打开了。请按以下操作：

1. **确认 Scheme**
   - 左上角应该显示 **Aura** 和 **My Mac**
   - 如果不是，点击选择正确的 Scheme

2. **切换到 Release 配置**
   - 菜单: **Product** → **Scheme** → **Edit Scheme...**
   - 左侧选择 **Run**
   - **Build Configuration** 改为 **Release**
   - 点击 **Close**

3. **构建项目**
   ```
   ⌘ + Shift + K    (清理)
   ⌘ + B            (构建)
   ```

4. **等待完成**
   - 顶部状态栏会显示 "Build Succeeded" ✅

---

### 📦 第 2 步：打包为 DMG（2 分钟）

回到终端，运行一键打包脚本：

```bash
./scripts/package-from-xcode.sh
```

这个脚本会自动：
1. ✅ 查找 Xcode 构建的 Aura.app
2. ✅ 复制到 build/Export/
3. ✅ 创建 DMG 安装包
4. ✅ 生成 SHA256 校验和

---

### ✨ 第 3 步：测试 DMG（1 分钟）

```bash
# 打开 DMG
open build/Aura-1.0.0.dmg

# 查看文件信息
ls -lh build/Aura-1.0.0.dmg
```

**预期结果：**
- DMG 文件挂载
- 看到 Aura.app 图标（彩虹光环）
- 看到 Applications 快捷方式

---

## 🎯 完整命令（复制粘贴）

```bash
# 假设你已经在 Xcode 中构建了 Release 版本

# 一键打包
./scripts/package-from-xcode.sh

# 测试
open build/Aura-1.0.0.dmg
```

---

## 🐛 如果遇到问题

### 问题：找不到 Aura.app

**解决：**
```bash
# 手动查找
./scripts/find-app.sh

# 如果找到，手动复制
./scripts/copy-built-app.sh

# 然后创建 DMG
./scripts/create-dmg.sh
```

### 问题：Xcode 构建失败

**解决：**
1. 清理: ⌘ + Shift + K
2. 重新生成项目:
   ```bash
   xcodegen generate
   open Aura.xcodeproj
   ```
3. 再次构建: ⌘ + B

### 问题：DMG 创建失败

**解决：**
```bash
# 检查应用是否存在
ls -la build/Export/Aura.app

# 如果不存在，重新复制
./scripts/copy-built-app.sh
```

---

## 📤 发布到 GitHub

```bash
# 1. 提交代码
git add .
git commit -m "feat: 完成 v1.0.0 版本"
git push origin develop

# 2. 手动上传 DMG
# 访问: https://github.com/LumingWyy/FocusPointer/releases
# 点击: "Draft a new release"
# 上传文件:
#   - build/Aura-1.0.0.dmg
#   - build/Aura-1.0.0.dmg.sha256
```

---

## ✅ 完成检查清单

- [ ] Xcode 构建成功（Build Succeeded）
- [ ] 运行 `./scripts/package-from-xcode.sh` 成功
- [ ] DMG 文件已生成 `build/Aura-1.0.0.dmg`
- [ ] 测试 DMG：`open build/Aura-1.0.0.dmg`
- [ ] 安装测试：从 DMG 拖到 Applications
- [ ] 运行测试：打开 Applications/Aura.app
- [ ] 功能测试：高亮效果正常
- [ ] 设置测试：设置面板可打开

---

**🎉 完成！你的 Aura.app 已成功打包为 DMG！**

详细文档: `BUILD_DMG_MANUALLY.md`
