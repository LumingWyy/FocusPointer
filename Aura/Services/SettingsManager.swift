import Foundation
import Combine

/// Settings manager
/// Persists and manages user settings
final class SettingsManager: ObservableObject {
    // MARK: - Published Properties

    /// Current settings
    @Published var settings: HighlightSettings {
        didSet {
            saveSettings()
        }
    }

    // MARK: - Private Properties

    /// UserDefaults key
    private let settingsKey = "com.aura.highlightSettings"

    /// UserDefaults instance
    private let userDefaults: UserDefaults

    // MARK: - Initialization

    /// Initialize settings manager
    /// - Parameter userDefaults: injected for tests
    init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
        self.settings = Self.loadSettings(from: userDefaults) ?? .default
    }

    // MARK: - Public Methods

    /// Reset to default settings
    func resetToDefault() {
        settings = .default
        print("✨ Settings reset to default")
    }

    // MARK: - Private Methods

    /// Save settings
    private func saveSettings() {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(settings)
            userDefaults.set(data, forKey: settingsKey)
            print("💾 Settings saved")
        } catch {
            print("❌ Failed to save settings: \(error.localizedDescription)")
        }
    }

    /// Load settings from UserDefaults
    /// - Parameter userDefaults: storage
    /// - Returns: decoded settings if any
    private static func loadSettings(from userDefaults: UserDefaults) -> HighlightSettings? {
        guard let data = userDefaults.data(forKey: "com.aura.highlightSettings") else {
            print("📋 No saved settings found; using defaults")
            return nil
        }

        do {
            let decoder = JSONDecoder()
            let settings = try decoder.decode(HighlightSettings.self, from: data)
            print("✅ Settings loaded")
            return settings
        } catch {
            print("❌ Failed to load settings: \(error.localizedDescription)")
            return nil
        }
    }
}
