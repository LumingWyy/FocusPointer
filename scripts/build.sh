#!/bin/bash
set -e

# 颜色输出
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${GREEN}🔨 开始构建 Aura...${NC}"

# 项目配置
PROJECT_NAME="Aura"
SCHEME_NAME="Aura"
CONFIGURATION="Release"
BUILD_DIR="build"
ARCHIVE_PATH="${BUILD_DIR}/${PROJECT_NAME}.xcarchive"
EXPORT_PATH="${BUILD_DIR}/Export"
APP_PATH="${EXPORT_PATH}/${PROJECT_NAME}.app"

# 清理旧构建
echo -e "${YELLOW}🧹 清理旧构建文件...${NC}"
rm -rf "${BUILD_DIR}"
mkdir -p "${BUILD_DIR}"

# 生成 Xcode 项目
echo -e "${YELLOW}📦 生成 Xcode 项目...${NC}"
xcodegen generate

# 构建和归档
echo -e "${YELLOW}🏗️  归档应用...${NC}"
xcodebuild archive \
    -project "${PROJECT_NAME}.xcodeproj" \
    -scheme "${SCHEME_NAME}" \
    -configuration "${CONFIGURATION}" \
    -archivePath "${ARCHIVE_PATH}" \
    -destination 'generic/platform=macOS' \
    CODE_SIGN_IDENTITY="-" \
    CODE_SIGNING_REQUIRED=NO \
    CODE_SIGNING_ALLOWED=NO

# 导出应用
echo -e "${YELLOW}📤 导出应用...${NC}"
mkdir -p "${EXPORT_PATH}"

# 从归档中复制应用
cp -R "${ARCHIVE_PATH}/Products/Applications/${PROJECT_NAME}.app" "${EXPORT_PATH}/"

# 验证应用
if [ -d "${APP_PATH}" ]; then
    echo -e "${GREEN}✅ 构建成功!${NC}"
    echo -e "${GREEN}📍 应用位置: ${APP_PATH}${NC}"

    # 显示应用信息
    echo -e "\n${YELLOW}📋 应用信息:${NC}"
    /usr/libexec/PlistBuddy -c "Print :CFBundleShortVersionString" "${APP_PATH}/Contents/Info.plist" | xargs echo "版本:"
    /usr/libexec/PlistBuddy -c "Print :CFBundleIdentifier" "${APP_PATH}/Contents/Info.plist" | xargs echo "Bundle ID:"
else
    echo -e "${RED}❌ 构建失败!${NC}"
    exit 1
fi

echo -e "${GREEN}🎉 构建完成!${NC}"
