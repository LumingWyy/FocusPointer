#!/bin/bash
set -e

# 颜色输出
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${GREEN}🚀 Aura 完整发布流程${NC}\n"

# 检查依赖
echo -e "${YELLOW}🔍 检查依赖...${NC}"

# 检查 xcodegen
if ! command -v xcodegen &> /dev/null; then
    echo -e "${RED}❌ xcodegen 未安装${NC}"
    echo -e "${YELLOW}💡 安装: brew install xcodegen${NC}"
    exit 1
fi

# 检查 gh (GitHub CLI) - 可选
if ! command -v gh &> /dev/null; then
    echo -e "${YELLOW}⚠️  GitHub CLI (gh) 未安装 - 将跳过自动发布${NC}"
    echo -e "${YELLOW}💡 安装: brew install gh${NC}"
    GH_AVAILABLE=false
else
    GH_AVAILABLE=true
fi

echo -e "${GREEN}✅ 依赖检查完成${NC}\n"

# 步骤1: 构建应用
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${BLUE}步骤 1/3: 构建应用${NC}"
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}\n"
./scripts/build.sh

# 步骤2: 创建 DMG
echo -e "\n${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${BLUE}步骤 2/3: 创建 DMG${NC}"
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}\n"
./scripts/create-dmg.sh

# 获取版本信息
PROJECT_NAME="Aura"
VERSION=$(defaults read "$(pwd)/build/Export/${PROJECT_NAME}.app/Contents/Info.plist" CFBundleShortVersionString)
DMG_FILE="build/${PROJECT_NAME}-${VERSION}.dmg"

# 步骤3: 发布到 GitHub
echo -e "\n${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${BLUE}步骤 3/3: 发布到 GitHub${NC}"
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}\n"

if [ "$GH_AVAILABLE" = true ]; then
    echo -e "${YELLOW}是否要创建 GitHub Release? (y/n)${NC}"
    read -r response

    if [[ "$response" =~ ^[Yy]$ ]]; then
        echo -e "\n${YELLOW}📝 输入版本标签 (例如: v${VERSION}):${NC}"
        read -r tag

        if [ -z "$tag" ]; then
            tag="v${VERSION}"
        fi

        echo -e "\n${YELLOW}📝 输入发布说明 (可选,回车跳过):${NC}"
        read -r notes

        if [ -z "$notes" ]; then
            notes="Release ${tag}"
        fi

        echo -e "\n${YELLOW}🚀 创建 GitHub Release...${NC}"
        gh release create "$tag" \
            "${DMG_FILE}" \
            --title "${PROJECT_NAME} ${tag}" \
            --notes "$notes"

        echo -e "${GREEN}✅ GitHub Release 创建成功!${NC}"
    else
        echo -e "${YELLOW}⏭️  跳过 GitHub Release${NC}"
    fi
else
    echo -e "${YELLOW}📋 手动发布步骤:${NC}"
    echo -e "1. 推送代码到 GitHub"
    echo -e "2. 创建新的 Release: https://github.com/YOUR_USERNAME/FocusPointer/releases/new"
    echo -e "3. 设置标签: v${VERSION}"
    echo -e "4. 上传文件: ${DMG_FILE}"
fi

# 完成
echo -e "\n${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${GREEN}✨ 发布流程完成!${NC}"
echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}\n"

echo -e "${BLUE}📦 制品信息:${NC}"
echo -e "版本: ${VERSION}"
echo -e "DMG: ${DMG_FILE}"
echo -e "\n${BLUE}🔐 校验和:${NC}"
shasum -a 256 "${DMG_FILE}"
