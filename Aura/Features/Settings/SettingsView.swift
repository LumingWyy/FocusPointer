import SwiftUI

/// 设置窗口视图
/// 提供用户自定义高亮效果的界面
struct SettingsView: View {
    @ObservedObject var settingsManager: SettingsManager
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack(spacing: 0) {
            // 标题栏
            headerView

            Divider()

            // 设置内容
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    // 边框厚度设置
                    borderThicknessSection

                    Divider()

                    // 颜色主题设置
                    colorThemeSection

                    Divider()

                    // 预览区域
                    previewSection
                }
                .padding(20)
            }

            Divider()

            // 底部按钮
            footerView
        }
        .frame(width: 500, height: 600)
    }

    // MARK: - Header

    private var headerView: some View {
        HStack {
            Text("设置")
                .font(.title2)
                .fontWeight(.semibold)

            Spacer()

            Button("重置默认") {
                settingsManager.resetToDefault()
            }
            .buttonStyle(.plain)
            .foregroundColor(.blue)
        }
        .padding()
    }

    // MARK: - Border Thickness Section

    private var borderThicknessSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Label("边框厚度", systemImage: "ruler")
                .font(.headline)

            Picker("边框厚度", selection: $settingsManager.settings.borderThickness) {
                ForEach(HighlightSettings.BorderThickness.allCases) { thickness in
                    Text(thickness.rawValue)
                        .tag(thickness)
                }
            }
            .pickerStyle(.segmented)
            .labelsHidden()
        }
    }

    // MARK: - Color Theme Section

    private var colorThemeSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Label("颜色主题", systemImage: "paintpalette")
                .font(.headline)

            LazyVGrid(columns: [
                GridItem(.flexible()),
                GridItem(.flexible()),
                GridItem(.flexible())
            ], spacing: 12) {
                ForEach(HighlightSettings.ColorTheme.allCases) { theme in
                    ThemeCard(
                        theme: theme,
                        isSelected: settingsManager.settings.colorTheme == theme
                    ) {
                        settingsManager.settings.colorTheme = theme
                    }
                }
            }
        }
    }

    // MARK: - Preview Section

    private var previewSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Label("预览", systemImage: "eye")
                .font(.headline)

            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color(nsColor: .windowBackgroundColor))
                    .frame(height: 200)

                Circle()
                    .strokeBorder(
                        AngularGradient(
                            gradient: Gradient(colors: settingsManager.settings.colorTheme.colors),
                            center: .center,
                            startAngle: .degrees(0),
                            endAngle: .degrees(360)
                        ),
                        lineWidth: settingsManager.settings.borderThickness.lineWidth
                    )
                    .frame(
                        width: settingsManager.settings.borderThickness.circleSize,
                        height: settingsManager.settings.borderThickness.circleSize
                    )
            }
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.gray.opacity(0.2), lineWidth: 1)
            )
        }
    }

    // MARK: - Footer

    private var footerView: some View {
        HStack {
            Spacer()

            Button("关闭") {
                dismiss()
            }
            .keyboardShortcut(.defaultAction)
        }
        .padding()
    }
}

// MARK: - Theme Card

/// 主题卡片组件
private struct ThemeCard: View {
    let theme: HighlightSettings.ColorTheme
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(spacing: 8) {
                // 颜色预览圆环
                Circle()
                    .strokeBorder(
                        AngularGradient(
                            gradient: Gradient(colors: theme.colors),
                            center: .center,
                            startAngle: .degrees(0),
                            endAngle: .degrees(360)
                        ),
                        lineWidth: 4
                    )
                    .frame(width: 50, height: 50)

                // 主题名称
                VStack(spacing: 2) {
                    Text(theme.icon)
                        .font(.title3)

                    Text(theme.rawValue)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .fill(isSelected ? Color.accentColor.opacity(0.1) : Color.clear)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(
                        isSelected ? Color.accentColor : Color.gray.opacity(0.2),
                        lineWidth: isSelected ? 2 : 1
                    )
            )
        }
        .buttonStyle(.plain)
    }
}

// MARK: - Preview

#Preview {
    SettingsView(settingsManager: SettingsManager())
}
