#!/bin/bash
set -e

# 颜色输出
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${GREEN}🔐 代码签名和公证流程${NC}\n"

# 可选: 读取本地环境变量 (.env)
if [ -f .env ]; then
  echo -e "${YELLOW}📄 载入 .env 配置...${NC}"
  # shellcheck disable=SC1091
  source .env
fi

# 配置 - 需要替换为实际的开发者信息
DEVELOPER_ID_APP="${DEVELOPER_ID_APP:-Developer ID Application: Your Name (TEAM_ID)}"
DEVELOPER_ID_INSTALLER="${DEVELOPER_ID_INSTALLER:-Developer ID Installer: Your Name (TEAM_ID)}"
APPLE_ID="${APPLE_ID:-your-apple-id@example.com}"
TEAM_ID="${TEAM_ID:-YOUR_TEAM_ID}"
APP_SPECIFIC_PASSWORD="${APP_SPECIFIC_PASSWORD:-xxxx-xxxx-xxxx-xxxx}"  # 从 appleid.apple.com 生成

PROJECT_NAME="Aura"
APP_PATH="build/Export/${PROJECT_NAME}.app"

# 读取版本并定位 DMG 文件
if [ -d "$APP_PATH" ]; then
  VERSION=$(defaults read "$(pwd)/${APP_PATH}/Contents/Info.plist" CFBundleShortVersionString 2>/dev/null || echo "1.0")
else
  VERSION="1.0"
fi
DMG_PATH="build/${PROJECT_NAME}-${VERSION}.dmg"

# 检查配置
echo -e "${YELLOW}⚙️  检查配置...${NC}"
if [[ "$DEVELOPER_ID_APP" == *"Your Name"* ]] || [[ "$APPLE_ID" == "your-apple-id@example.com" ]] || [[ "$TEAM_ID" == "YOUR_TEAM_ID" ]] || [[ "$APP_SPECIFIC_PASSWORD" == "xxxx-xxxx-xxxx-xxxx" ]]; then
    echo -e "${RED}❌ 错误: 请先配置开发者信息${NC}"
    echo -e "${YELLOW}需要配置的变量:${NC}"
    echo -e "  - DEVELOPER_ID_APP"
    echo -e "  - APPLE_ID"
    echo -e "  - TEAM_ID"
    echo -e "  - APP_SPECIFIC_PASSWORD"
    echo -e "\n${YELLOW}建议:${NC} 在项目根目录创建 .env 文件 (参见 .env.example)"
    echo -e "\n${BLUE}📖 获取信息:${NC}"
    echo -e "1. 开发者证书: security find-identity -v -p codesigning"
    echo -e "2. 团队 ID: https://developer.apple.com/account"
    echo -e "3. App 专用密码: https://appleid.apple.com/account/manage (登录与安全 -> App 专用密码)"
    exit 1
fi

# 步骤1: 代码签名
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${BLUE}步骤 1/3: 代码签名${NC}"
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}\n"

if [ ! -d "${APP_PATH}" ]; then
    echo -e "${RED}❌ 错误: 找不到应用 ${APP_PATH}${NC}"
    echo -e "${YELLOW}💡 请先运行: ./scripts/build.sh${NC}"
    exit 1
fi

echo -e "${YELLOW}🔏 签名应用...${NC}"
codesign --force --deep --sign "$DEVELOPER_ID_APP" \
    --options runtime \
    --entitlements scripts/entitlements.plist \
    "${APP_PATH}"

# 验证签名
echo -e "${YELLOW}✅ 验证签名...${NC}"
codesign --verify --deep --strict --verbose=2 "${APP_PATH}"

# 步骤2: 创建并签名 DMG
echo -e "\n${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${BLUE}步骤 2/3: 创建和签名 DMG${NC}"
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}\n"

# 如果 DMG 不存在,创建它
if [ ! -f "${DMG_PATH}" ]; then
    echo -e "${YELLOW}📦 创建 DMG...${NC}"
    ./scripts/create-dmg.sh
fi

echo -e "${YELLOW}🔏 签名 DMG...${NC}"
codesign --force --sign "$DEVELOPER_ID_APP" "${DMG_PATH}"

# 步骤3: 公证
echo -e "\n${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${BLUE}步骤 3/3: 公证 (Notarization)${NC}"
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}\n"

echo -e "${YELLOW}📤 上传至 Apple 公证服务...${NC}"
echo -e "${YELLOW}⏳ 这可能需要几分钟...${NC}\n"

# 使用 notarytool 公证 (Xcode 13+)
if [ -n "$KEYCHAIN_PROFILE" ]; then
  # 如果事先用 notarytool store-credentials 配置过钥匙串配置档
  xcrun notarytool submit "${DMG_PATH}" --keychain-profile "$KEYCHAIN_PROFILE" --wait
else
  xcrun notarytool submit "${DMG_PATH}" \
      --apple-id "$APPLE_ID" \
      --team-id "$TEAM_ID" \
      --password "$APP_SPECIFIC_PASSWORD" \
      --wait
fi

# 装订公证票据
echo -e "\n${YELLOW}📎 装订公证票据...${NC}"
xcrun stapler staple "${DMG_PATH}"

# 验证公证
echo -e "${YELLOW}✅ 验证公证...${NC}"
xcrun stapler validate "${DMG_PATH}"

# 完成
echo -e "\n${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${GREEN}✨ 签名和公证完成!${NC}"
echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}\n"

echo -e "${BLUE}📦 可分发的 DMG:${NC}"
echo -e "文件: ${DMG_PATH}"
echo -e "\n${BLUE}🔐 校验和:${NC}"
shasum -a 256 "${DMG_PATH}"

echo -e "\n${GREEN}✅ 该 DMG 现在可以安全分发,用户下载后不会看到安全警告${NC}"
