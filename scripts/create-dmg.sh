#!/bin/bash
set -e

# 颜色输出
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${GREEN}📦 开始创建 DMG...${NC}"

# 配置
PROJECT_NAME="Aura"
VERSION=$(defaults read "$(pwd)/build/Export/${PROJECT_NAME}.app/Contents/Info.plist" CFBundleShortVersionString)
DMG_NAME="${PROJECT_NAME}-${VERSION}"
SOURCE_APP="build/Export/${PROJECT_NAME}.app"
DMG_DIR="build/dmg"
DMG_TEMP="${DMG_DIR}/temp"
DMG_OUTPUT="build/${DMG_NAME}.dmg"

# 检查应用是否存在
if [ ! -d "${SOURCE_APP}" ]; then
    echo -e "${RED}❌ 错误: 找不到应用 ${SOURCE_APP}${NC}"
    echo -e "${YELLOW}💡 请先运行: ./scripts/build.sh${NC}"
    exit 1
fi

# 清理并创建临时目录
echo -e "${YELLOW}🧹 准备 DMG 目录...${NC}"
rm -rf "${DMG_DIR}"
mkdir -p "${DMG_TEMP}"

# 复制应用到临时目录
echo -e "${YELLOW}📋 复制应用...${NC}"
cp -R "${SOURCE_APP}" "${DMG_TEMP}/"

# 创建应用程序文件夹的符号链接
echo -e "${YELLOW}🔗 创建快捷方式...${NC}"
ln -s /Applications "${DMG_TEMP}/Applications"

# 创建自定义背景 (可选)
# 如果有背景图片,可以添加到 DMG_TEMP/.background/

# 删除旧的 DMG
rm -f "${DMG_OUTPUT}"

# 创建 DMG
echo -e "${YELLOW}🎨 生成 DMG...${NC}"

# 方法1: 使用 hdiutil (macOS 原生工具)
hdiutil create -volname "${PROJECT_NAME}" \
    -srcfolder "${DMG_TEMP}" \
    -ov -format UDZO \
    "${DMG_OUTPUT}"

# 清理临时文件
echo -e "${YELLOW}🧹 清理临时文件...${NC}"
rm -rf "${DMG_DIR}"

# 验证 DMG
if [ -f "${DMG_OUTPUT}" ]; then
    DMG_SIZE=$(du -h "${DMG_OUTPUT}" | cut -f1)
    echo -e "${GREEN}✅ DMG 创建成功!${NC}"
    echo -e "${GREEN}📦 文件: ${DMG_OUTPUT}${NC}"
    echo -e "${GREEN}📏 大小: ${DMG_SIZE}${NC}"
    echo -e "${GREEN}🏷️  版本: ${VERSION}${NC}"

    # 计算 SHA256 校验和
    echo -e "\n${BLUE}🔐 校验和:${NC}"
    shasum -a 256 "${DMG_OUTPUT}"
else
    echo -e "${RED}❌ DMG 创建失败!${NC}"
    exit 1
fi

echo -e "${GREEN}🎉 打包完成!${NC}"
echo -e "\n${YELLOW}📤 发布步骤:${NC}"
echo -e "1. 测试 DMG: open ${DMG_OUTPUT}"
echo -e "2. 创建 GitHub Release"
echo -e "3. 上传 DMG 文件"
