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

        /// 渐变颜色数组
        var colors: [Color] {
            switch self {
            case .rainbow:
                return [.red, .orange, .yellow, .green, .blue, .purple, .red]

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
                return [
                    Color(red: 1.0, green: 0.2, blue: 0.2),
                    Color(red: 1.0, green: 0.4, blue: 0.3),
                    Color(red: 1.0, green: 0.5, blue: 0.4),
                    Color(red: 1.0, green: 0.2, blue: 0.2)
                ]

            case .purple:
                return [
                    Color(red: 0.6, green: 0.2, blue: 0.8),
                    Color(red: 0.7, green: 0.3, blue: 0.9),
                    Color(red: 0.8, green: 0.4, blue: 1.0),
                    Color(red: 0.6, green: 0.2, blue: 0.8)
                ]
            }
        }
    }

    // MARK: - Default Settings

    /// 默认设置
    static let `default` = HighlightSettings()
}
