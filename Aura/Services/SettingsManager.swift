import Foundation
import Combine

/// 设置管理器
/// 负责设置的持久化和状态管理
final class SettingsManager: ObservableObject {
    // MARK: - Published Properties

    /// 当前设置
    @Published var settings: HighlightSettings {
        didSet {
            saveSettings()
        }
    }

    // MARK: - Private Properties

    /// UserDefaults 键
    private let settingsKey = "com.aura.highlightSettings"

    /// UserDefaults 实例
    private let userDefaults: UserDefaults

    // MARK: - Initialization

    /// 初始化设置管理器
    /// - Parameter userDefaults: UserDefaults 实例 (用于测试注入)
    init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
        self.settings = Self.loadSettings(from: userDefaults) ?? .default
    }

    // MARK: - Public Methods

    /// 重置为默认设置
    func resetToDefault() {
        settings = .default
        print("✨ 设置已重置为默认值")
    }

    // MARK: - Private Methods

    /// 保存设置
    private func saveSettings() {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(settings)
            userDefaults.set(data, forKey: settingsKey)
            print("💾 设置已保存")
        } catch {
            print("❌ 保存设置失败: \(error.localizedDescription)")
        }
    }

    /// 加载设置
    /// - Parameter userDefaults: UserDefaults 实例
    /// - Returns: 加载的设置,如果失败返回 nil
    private static func loadSettings(from userDefaults: UserDefaults) -> HighlightSettings? {
        guard let data = userDefaults.data(forKey: "com.aura.highlightSettings") else {
            print("📋 未找到保存的设置,使用默认设置")
            return nil
        }

        do {
            let decoder = JSONDecoder()
            let settings = try decoder.decode(HighlightSettings.self, from: data)
            print("✅ 设置加载成功")
            return settings
        } catch {
            print("❌ 加载设置失败: \(error.localizedDescription)")
            return nil
        }
    }
}
