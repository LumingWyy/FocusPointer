#!/bin/bash
# 查找 Xcode 构建的 Aura.app

echo "🔍 正在搜索 Aura.app..."

# 搜索 DerivedData 中的 Release 版本
APP_PATH=$(find ~/Library/Developer/Xcode/DerivedData/Aura-* -name "Aura.app" -path "*/Build/Products/Release/*" 2>/dev/null | head -1)

if [ -z "$APP_PATH" ]; then
    echo "⚠️  未找到 Release 版本，尝试查找 Debug 版本..."
    APP_PATH=$(find ~/Library/Developer/Xcode/DerivedData/Aura-* -name "Aura.app" -path "*/Build/Products/Debug/*" 2>/dev/null | head -1)
fi

if [ -n "$APP_PATH" ]; then
    echo "✅ 找到: $APP_PATH"
    echo ""
    echo "📊 文件信息:"
    ls -lh "$APP_PATH"
    echo ""
    echo "📋 复制命令:"
    echo "   mkdir -p build/Export"
    echo "   cp -R \"$APP_PATH\" build/Export/"
else
    echo "❌ 未找到 Aura.app"
    echo ""
    echo "💡 请确保:"
    echo "   1. 已在 Xcode 中构建项目 (⌘ + B)"
    echo "   2. 构建配置为 Release"
    echo ""
    exit 1
fi
