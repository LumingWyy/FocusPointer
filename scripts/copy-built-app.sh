#!/bin/bash
# 自动查找并复制 Xcode 构建的 Aura.app

set -e

echo "🔍 正在搜索 Aura.app..."

# 搜索 Release 版本
APP_PATH=$(find ~/Library/Developer/Xcode/DerivedData/Aura-* -name "Aura.app" -path "*/Build/Products/Release/*" 2>/dev/null | head -1)

if [ -z "$APP_PATH" ]; then
    echo "⚠️  未找到 Release 版本，尝试 Debug 版本..."
    APP_PATH=$(find ~/Library/Developer/Xcode/DerivedData/Aura-* -name "Aura.app" -path "*/Build/Products/Debug/*" 2>/dev/null | head -1)
fi

if [ -z "$APP_PATH" ]; then
    echo "❌ 未找到 Aura.app"
    echo ""
    echo "💡 请先在 Xcode 中构建项目:"
    echo "   1. 打开 Aura.xcodeproj"
    echo "   2. 按 ⌘ + B 构建"
    echo "   3. 然后重新运行此脚本"
    exit 1
fi

echo "✅ 找到: $APP_PATH"

# 创建导出目录
mkdir -p build/Export

# 复制应用
echo "📦 正在复制到 build/Export/..."
cp -R "$APP_PATH" build/Export/

# 验证
if [ -d "build/Export/Aura.app" ]; then
    echo "✅ 复制成功!"
    echo ""
    echo "📊 文件信息:"
    ls -lh build/Export/
    echo ""
    echo "🎯 下一步:"
    echo "   ./scripts/create-dmg.sh"
else
    echo "❌ 复制失败"
    exit 1
fi
