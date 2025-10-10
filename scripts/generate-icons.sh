#!/bin/bash
set -e

# 颜色输出
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${GREEN}🎨 生成 Aura App 图标${NC}\n"

echo -e "${YELLOW}📝 说明:${NC}"
echo "此脚本将使用 Swift 代码生成 App 图标"
echo "图标将保存到桌面的 AuraIcons 文件夹"
echo ""

# 创建临时 Swift 文件
TEMP_FILE=$(mktemp).swift

cat > "$TEMP_FILE" << 'EOF'
import SwiftUI
import AppKit

// 将 IconGenerator.swift 的内容复制到这里
// 或直接使用 Xcode Playground 运行

print("请在 Xcode 中运行 IconGenerator.generateAllIcons()")
print("或使用 Playground 预览图标")
EOF

echo -e "${YELLOW}⚠️  自动生成需要 Xcode Playground${NC}"
echo -e "${YELLOW}推荐方法:${NC}"
echo ""
echo "1. 在 Xcode 中打开 Aura.xcodeproj"
echo "2. 打开 Aura/Resources/IconGenerator.swift"
echo "3. 点击右侧 Canvas 预览"
echo "4. 截图保存预览图像"
echo ""
echo "或者:"
echo ""
echo "1. 创建新的 Playground"
echo "2. 复制 IconGenerator.swift 内容"
echo "3. 运行 IconGenerator.generateAllIcons()"
echo "4. 图标会生成到桌面 ~/Desktop/AuraIcons/"
echo ""

# 清理
rm "$TEMP_FILE"

echo -e "${GREEN}💡 提示: 也可以使用在线工具生成图标${NC}"
echo "- Figma: https://figma.com"
echo "- Canva: https://canva.com"
echo "- AppIconMaker: https://appiconmaker.co"
echo ""

echo -e "${GREEN}📖 查看完整设计文档:${NC}"
echo "cat docs/ICON_DESIGN.md"
