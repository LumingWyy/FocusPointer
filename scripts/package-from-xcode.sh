#!/bin/bash
# 从 Xcode 构建的应用一键打包为 DMG

set -e

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "${GREEN}📦 开始打包 Aura.app 为 DMG...${NC}\n"

# 第 1 步: 查找应用
echo -e "${YELLOW}步骤 1/3: 查找 Aura.app...${NC}"
./scripts/copy-built-app.sh

if [ ! -d "build/Export/Aura.app" ]; then
    echo -e "${RED}❌ 未找到应用，退出${NC}"
    exit 1
fi

echo ""

# 第 2 步: 创建 DMG
echo -e "${YELLOW}步骤 2/3: 创建 DMG 安装包...${NC}"
./scripts/create-dmg.sh

if [ ! -f "build/Aura-1.0.0.dmg" ]; then
    echo -e "${RED}❌ DMG 创建失败，退出${NC}"
    exit 1
fi

echo ""

# 第 3 步: 验证
echo -e "${YELLOW}步骤 3/3: 验证 DMG...${NC}"
ls -lh build/Aura-1.0.0.dmg
ls -lh build/Aura-1.0.0.dmg.sha256

echo ""
echo -e "${GREEN}✅ 打包完成!${NC}\n"
echo -e "${GREEN}📦 生成的文件:${NC}"
echo "   - build/Aura-1.0.0.dmg"
echo "   - build/Aura-1.0.0.dmg.sha256"
echo ""
echo -e "${GREEN}🎯 测试 DMG:${NC}"
echo "   open build/Aura-1.0.0.dmg"
echo ""
echo -e "${GREEN}📤 上传到 GitHub Releases:${NC}"
echo "   https://github.com/LumingWyy/FocusPointer/releases/new"
