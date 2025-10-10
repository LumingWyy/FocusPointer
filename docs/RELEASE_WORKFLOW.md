# 🚀 发布工作流程指南

本文档说明如何使用 GitHub Actions 自动化发布流程。

---

## 📋 发布方式总览

项目提供**四种**发布方式:

| 方式 | 触发条件 | 适用场景 | 自动化程度 |
|------|---------|---------|-----------|
| **方式 1: 自动发布** ⭐ | 推送到 main | 最简单 | ⭐⭐⭐⭐⭐ |
| **方式 2: Tag 发布** | 推送 `v*` 标签 | 快速发布 | ⭐⭐⭐ |
| **方式 3: PR 发布** | 合并 `release/*` PR | 团队协作 | ⭐⭐⭐⭐ |
| **方式 4: 手动发布** | 本地脚本 | 测试/验证 | ⭐⭐ |

---

## 🎯 方式 1: 自动发布 (推荐 ⭐)

### 工作流文件
`.github/workflows/auto-release.yml`

### 使用步骤

```bash
# 1. 更新版本号
# 编辑 project.yml:
# MARKETING_VERSION: "1.0.1"  # ← 更新这里

# 2. 提交并推送到 main
git add project.yml
git commit -m "chore: bump version to 1.0.1"
git push origin main

# 3. GitHub Actions 自动完成发布! 🎉
```

### 自动执行
- ✅ 检测版本号是否变化
- ✅ 检查 Tag 是否已存在
- ✅ 构建应用和创建 DMG
- ✅ 自动创建 Git Tag
- ✅ 生成 Release Notes (基于 git log)
- ✅ 创建 GitHub Release
- ✅ 上传 DMG 和校验和

### 优势
- 🚀 **最简单**: 只需更新版本号并推送
- 🔄 **自动化**: 完全自动,无需手动操作
- 🛡️ **防重复**: 自动检查 Tag 避免重复发布
- 📝 **自动生成 Release Notes**: 基于 git commit 历史

---

## 🏷️ 方式 2: Tag 发布

### 工作流文件
`.github/workflows/release.yml`

### 使用步骤

```bash
# 1. 确保代码已提交
git add .
git commit -m "准备发布 v1.0.0"

# 2. 创建并推送标签
git tag v1.0.0
git push origin v1.0.0

# 3. 等待 GitHub Actions 完成 ✨
```

---

## 🔀 方式 3: PR 发布 (团队协作)

### 工作流文件
`.github/workflows/release-pr.yml`

### 使用步骤

```bash
# 1. 创建 release 分支
git checkout -b release/v1.0.0

# 2. 更新版本号
# project.yml: MARKETING_VERSION: "1.0.0"

# 3. 提交并推送
git add .
git commit -m "chore: 准备发布 v1.0.0"
git push origin release/v1.0.0

# 4. 在 GitHub 创建 PR
# 5. 合并 PR → 自动发布! 🎉
```

---

## 🖥️ 方式 4: 本地手动发布

```bash
# 完整发布流程
./scripts/release.sh

# 或分步执行
./scripts/build.sh          # 构建
./scripts/create-dmg.sh     # 创建 DMG
```

---

## 🔄 完整发布示例 (推荐工作流)

### 场景: 发布新版本 v1.0.1

```bash
# 步骤 1: 开发功能
git checkout -b feature/new-theme
# ... 开发 ...
git commit -m "feat: 添加新主题"

# 步骤 2: 合并到 develop
git checkout develop
git merge feature/new-theme
git push origin develop

# 步骤 3: 测试通过后,更新版本号
git checkout main
git merge develop

# 编辑 project.yml
# MARKETING_VERSION: "1.0.1"

git add project.yml
git commit -m "chore: bump version to 1.0.1"

# 步骤 4: 推送到 main → 自动发布!
git push origin main

# 🎉 完成! GitHub Actions 会自动:
# - 创建 v1.0.1 tag
# - 构建 DMG
# - 创建 Release
```

---

## 📊 工作流对比

| 特性 | 自动发布 | Tag 发布 | PR 发布 | 手动发布 |
|------|---------|---------|---------|---------|
| **触发方式** | 推送 main | 推送标签 | 合并 PR | 本地脚本 |
| **版本检测** | ✅ 自动 | ❌ 手动 | ✅ PR | ❌ 手动 |
| **防重复** | ✅ | ❌ | ✅ | ❌ |
| **Release Notes** | 自动生成 | 模板 | PR 描述 | 手动 |
| **代码审查** | ❌ | ❌ | ✅ | ❌ |
| **操作步骤** | 1 | 2 | 3-4 | 2-3 |
| **适合场景** | 个人/小团队 | 快速修复 | 大型团队 | 本地测试 |

---

## 📝 版本号管理

### 在 project.yml 中更新

```yaml
settings:
  base:
    MARKETING_VERSION: "1.0.1"  # ← 在这里更新
    CURRENT_PROJECT_VERSION: 1
```

### 版本号规范 (Semantic Versioning)

- **Major (主版本)**: 不兼容的 API 修改 - `2.0.0`
- **Minor (次版本)**: 向下兼容的新增功能 - `1.1.0`
- **Patch (修订)**: 向下兼容的问题修正 - `1.0.1`

### 示例

```bash
# 初始发布
1.0.0

# 添加新功能
1.1.0

# 修复 Bug
1.1.1

# 重大更新
2.0.0
```

---

## 🔍 如何查看发布状态

### 方法 1: GitHub Actions 页面

访问: `https://github.com/YOUR_USERNAME/FocusPointer/actions`

### 方法 2: 命令行查看

```bash
# 查看最新的 workflow 运行状态
gh run list --workflow=auto-release.yml

# 查看详细日志
gh run view --log
```

---

## 🐛 常见问题

### Q1: 推送到 main 但没有发布

**A**: 检查:
1. 版本号是否更新 (project.yml 中的 MARKETING_VERSION)
2. Tag 是否已存在 (会跳过)
3. 是否修改了 docs/ 或 .md 文件 (被忽略)

```bash
# 查看现有 tags
git tag -l

# 如果 tag 已存在,删除后重试
git tag -d v1.0.0
git push origin :refs/tags/v1.0.0
```

### Q2: 构建失败

**A**: 查看 Actions 日志:
```bash
gh run view --log
```

常见原因:
- Xcode 版本不兼容
- 依赖安装失败
- 代码编译错误

### Q3: DMG 创建失败

**A**: 确认:
- 应用是否成功构建
- `build/Export/Aura.app` 是否存在
- 磁盘空间是否充足

### Q4: 如何跳过自动发布

如果只想推送代码而不发布:

```bash
# 方法 1: 不更新版本号
# 只要 MARKETING_VERSION 不变,就不会创建新 tag

# 方法 2: Tag 已存在会自动跳过
```

### Q5: 如何手动触发发布

```bash
# 使用 Tag 发布方式
git tag v1.0.0
git push origin v1.0.0

# 或手动触发 workflow
gh workflow run auto-release.yml
```

---

## 🎯 最佳实践

### 1. 版本号管理

```bash
# ✅ 好的做法
git commit -m "chore: bump version to 1.0.1"

# ❌ 避免
git commit -m "update"
```

### 2. Commit 消息规范

```bash
feat: 添加新功能
fix: 修复 Bug
chore: 更新版本号
docs: 更新文档
ci: 修改 CI 配置
```

### 3. 发布前检查

```bash
# 1. 本地测试构建
./scripts/build.sh

# 2. 运行测试
xcodebuild test -project Aura.xcodeproj -scheme Aura

# 3. 检查版本号
grep "MARKETING_VERSION" project.yml
```

### 4. 发布后验证

```bash
# 1. 检查 Release
open https://github.com/YOUR_USERNAME/FocusPointer/releases

# 2. 下载 DMG 测试
# 3. 验证校验和
shasum -a 256 Aura-1.0.0.dmg
```

---

## 📚 工作流程图

```
开发功能
   ↓
提交到 develop
   ↓
测试通过
   ↓
合并到 main + 更新版本号
   ↓
推送 main
   ↓
GitHub Actions 检测版本号变化
   ↓
自动构建 DMG
   ↓
创建 Tag 和 Release
   ↓
完成! 🎉
```

---

## 🔗 相关链接

- [GitHub Actions 文档](https://docs.github.com/en/actions)
- [Semantic Versioning](https://semver.org/)
- [项目 README](../README.md)

---

**祝你发布顺利! 🚀**
