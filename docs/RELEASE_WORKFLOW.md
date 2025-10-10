# 🚀 发布工作流程指南

本文档说明如何使用 GitHub Actions 自动化发布流程。

---

## 📋 发布方式总览

项目提供三种发布方式:

| 方式 | 触发条件 | 适用场景 | 自动化程度 |
|------|---------|---------|-----------|
| **方式 1: Tag 发布** | 推送 `v*` 标签 | 快速发布 | ⭐⭐⭐ |
| **方式 2: PR 发布** | 合并 `release/*` PR | 团队协作 | ⭐⭐⭐⭐⭐ |
| **方式 3: 手动发布** | 本地脚本 | 测试/验证 | ⭐⭐ |

---

## 🏷️ 方式 1: Tag 发布 (推荐新手)

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
# 访问: https://github.com/YOUR_USERNAME/FocusPointer/actions
```

### 自动执行
- ✅ 构建 Xcode 项目
- ✅ 创建 DMG 文件
- ✅ 生成 SHA256 校验和
- ✅ 创建 GitHub Release
- ✅ 上传 DMG 和校验和文件

---

## 🔀 方式 2: PR 发布 (推荐团队)

### 工作流文件
`.github/workflows/release-pr.yml`

### 使用步骤

#### 步骤 1: 创建 Release 分支

```bash
# 从 main 分支创建 release 分支
git checkout main
git pull origin main
git checkout -b release/v1.0.0
```

#### 步骤 2: 准备发布

```bash
# 1. 更新版本号 (project.yml)
# MARKETING_VERSION: "1.0.0"

# 2. 更新 CHANGELOG (可选)
# 添加新版本的更新说明

# 3. 提交更改
git add .
git commit -m "chore: 准备发布 v1.0.0"
git push origin release/v1.0.0
```

#### 步骤 3: 创建 Pull Request

1. 访问 GitHub 仓库
2. 点击 **Pull requests** → **New pull request**
3. 设置:
   - **Base**: `main`
   - **Compare**: `release/v1.0.0`
   - **Title**: `v1.0.0` 或 `Release v1.0.0`
   - **Description**: 填写更新内容

```markdown
## 🎉 v1.0.0

### ✨ 新功能
- 添加鼠标点击高亮效果
- 支持 5 种颜色主题
- 可调节边框厚度

### 🐛 修复
- 修复内存泄漏问题

### 📝 其他
- 更新文档
```

#### 步骤 4: 合并 PR

1. Review 代码
2. 点击 **Merge pull request**
3. 选择 **Merge commit** (推荐)
4. 点击 **Confirm merge**

#### 步骤 5: 自动发布 🎉

PR 合并后,GitHub Actions 自动:
- ✅ 构建应用
- ✅ 创建 DMG
- ✅ 创建 Git Tag (`v1.0.0`)
- ✅ 创建 GitHub Release
- ✅ 上传 DMG 文件
- ✅ 在 PR 中添加评论通知

### PR 发布的优势

- 📝 **代码审查**: 发布前可以 review
- 🔄 **回滚简单**: 可以快速 revert PR
- 📋 **自动化文档**: PR 描述自动成为 Release Notes
- 👥 **团队协作**: 多人可以参与发布流程
- 🔔 **通知机制**: PR 合并后自动通知

---

## 🖥️ 方式 3: 本地手动发布

### 适用场景
- 测试发布流程
- 无法使用 GitHub Actions
- 需要代码签名和公证

### 使用步骤

```bash
# 1. 完整发布流程
./scripts/release.sh

# 2. 或分步执行
./scripts/build.sh          # 构建
./scripts/create-dmg.sh     # 创建 DMG
./scripts/sign-and-notarize.sh  # 签名公证 (可选)

# 3. 手动上传到 GitHub
gh release create v1.0.0 \
    build/Aura-1.0.0.dmg \
    --title "Aura v1.0.0" \
    --notes "Release notes..."
```

---

## 📊 发布流程对比

### Tag 发布 vs PR 发布

| 特性 | Tag 发布 | PR 发布 |
|------|---------|---------|
| **触发方式** | 推送标签 | 合并 PR |
| **代码审查** | ❌ | ✅ |
| **自动标签** | 手动创建 | 自动创建 |
| **Release Notes** | 模板生成 | PR 描述 |
| **回滚难度** | 中等 | 简单 |
| **团队协作** | 一般 | 优秀 |
| **适合场景** | 个人项目 | 团队项目 |

---

## 🔧 配置说明

### release.yml (Tag 触发)

```yaml
on:
  push:
    tags:
      - 'v*'  # 任何 v 开头的标签
  workflow_dispatch:  # 手动触发
```

### release-pr.yml (PR 触发)

```yaml
on:
  pull_request:
    types:
      - closed
    branches:
      - main

jobs:
  release:
    # 只在合并且分支名以 release 开头时运行
    if: github.event.pull_request.merged == true && startsWith(github.head_ref, 'release')
```

---

## 📝 版本号规范

遵循 [Semantic Versioning](https://semver.org/):

- **主版本号 (Major)**: 不兼容的 API 修改 - `v2.0.0`
- **次版本号 (Minor)**: 向下兼容的功能性新增 - `v1.1.0`
- **修订号 (Patch)**: 向下兼容的问题修正 - `v1.0.1`

### 示例

```bash
# 初始发布
v1.0.0

# 添加新功能 (向下兼容)
v1.1.0

# 修复 Bug
v1.1.1

# 重大更新 (不兼容)
v2.0.0
```

---

## 🐛 常见问题

### Q1: GitHub Actions 构建失败

**A**: 检查:
1. `project.yml` 语法是否正确
2. Xcode 版本是否支持
3. 依赖是否正确安装
4. 查看 Actions 日志详细错误

### Q2: PR 合并后没有触发发布

**A**: 确认:
1. 分支名是否以 `release` 开头 (如 `release/v1.0.0`)
2. PR 是否真正合并 (不是关闭)
3. Target 分支是否为 `main`

### Q3: DMG 创建失败

**A**: 可能原因:
1. 应用未成功构建
2. 磁盘空间不足
3. 权限问题

### Q4: 如何更新已发布的 Release

```bash
# 删除标签和 Release
git tag -d v1.0.0
git push origin :refs/tags/v1.0.0

# 在 GitHub 上手动删除 Release
# 重新创建标签
git tag v1.0.0
git push origin v1.0.0
```

---

## 📚 推荐工作流

### 个人项目

```bash
# 开发 → 提交 → 推送标签
git tag v1.0.0
git push origin v1.0.0
```

### 团队项目

```bash
# 开发 → 创建 release 分支 → PR → Review → 合并
git checkout -b release/v1.0.0
# ... 修改版本号 ...
git push origin release/v1.0.0
# 在 GitHub 创建 PR → Review → Merge
```

---

## 🎯 最佳实践

1. **版本号规范**: 遵循 Semantic Versioning
2. **Release Notes**: 详细描述更新内容
3. **测试验证**: 发布前充分测试
4. **代码审查**: 团队项目使用 PR 发布
5. **备份重要版本**: 保留重要版本的 DMG 文件
6. **更新文档**: 发布后更新 README 和 CHANGELOG

---

## 🔗 相关链接

- [GitHub Actions 文档](https://docs.github.com/en/actions)
- [Semantic Versioning](https://semver.org/)
- [Release Drafter](https://github.com/release-drafter/release-drafter)

---

**祝你发布顺利! 🚀**
