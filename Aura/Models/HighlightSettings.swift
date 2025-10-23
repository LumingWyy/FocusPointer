import SwiftUI

/// 高亮效果设置
/// 用户可自定义的配置选项
struct HighlightSettings: Codable, Equatable {
    /// 边框厚度
    var borderThickness: BorderThickness = .medium

    /// 颜色主题
    var colorTheme: ColorTheme = .rainbow

    // MARK: - Border Thickness

    /// 边框厚度枚举
    enum BorderThickness: String, Codable, CaseIterable, Identifiable {
        case small = "小"
        case medium = "中"
        case large = "大"

        var id: String { rawValue }

        /// 实际像素值
        var lineWidth: CGFloat {
            switch self {
            case .small: return 3
            case .medium: return 4
            case .large: return 6
            }
        }

        /// 圆形大小
        var circleSize: CGFloat {
            switch self {
            case .small: return 60
            case .medium: return 80
            case .large: return 100
            }
        }
    }

    // MARK: - Color Theme

    /// 颜色主题枚举
    enum ColorTheme: String, Codable, CaseIterable, Identifiable {
        case rainbow = "彩虹渐变"
        case blue = "蓝色主题"
        case green = "绿色主题"
        case red = "红色主题"
        case purple = "紫色主题"

        var id: String { rawValue }

        /// 主题图标
        var icon: String {
            switch self {
            case .rainbow: return "🌈"
            case .blue: return "🔵"
            case .green: return "💚"
            case .red: return "🔴"
            case .purple: return "🟣"
            }
        }

        /// 英文显示名（不影响存储的 rawValue）
        var displayName: String {
            switch self {
            case .rainbow: return "Rainbow"
            case .blue: return "Blue"
            case .green: return "Green"
            case .red: return "Red"
            case .purple: return "Purple"
            }
        }

        /// 渐变颜色数组
        var colors: [Color] {
            switch self {
            case .rainbow:
                // 去除深红/深紫/黑，使用更明亮的暖冷渐变
                return [
                    .orange,
                    .yellow,
                    Color(red: 0.3, green: 0.9, blue: 0.5), // bright green
                    .cyan,
                    Color(red: 0.2, green: 0.6, blue: 1.0), // sky blue
                    .teal,
                    .orange
                ]

            case .blue:
                return [
                    Color(red: 0.0, green: 0.5, blue: 1.0),
                    Color(red: 0.0, green: 0.7, blue: 1.0),
                    Color(red: 0.3, green: 0.8, blue: 1.0),
                    Color(red: 0.0, green: 0.5, blue: 1.0)
                ]

            case .green:
                return [
                    Color(red: 0.0, green: 0.8, blue: 0.4),
                    Color(red: 0.2, green: 0.9, blue: 0.5),
                    Color(red: 0.4, green: 1.0, blue: 0.6),
                    Color(red: 0.0, green: 0.8, blue: 0.4)
                ]

            case .red:
                // 更浅的珊瑚红系，避免深红
                return [
                    Color(red: 1.0, green: 0.55, blue: 0.5),
                    Color(red: 1.0, green: 0.65, blue: 0.55),
                    Color(red: 1.0, green: 0.55, blue: 0.5)
                ]

            case .purple:
                // 偏浅的紫罗兰系，避免深紫
                return [
                    Color(red: 0.78, green: 0.52, blue: 1.0),
                    Color(red: 0.72, green: 0.58, blue: 1.0),
                    Color(red: 0.78, green: 0.52, blue: 1.0)
                ]
            }
        }
    }

    // MARK: - Default Settings

    /// 默认设置
    static let `default` = HighlightSettings()
}
