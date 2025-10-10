import XCTest
@testable import Aura

final class SettingsManagerTests: XCTestCase {
    func testPersistenceAcrossInstances() throws {
        // Arrange: use isolated UserDefaults suite
        let suiteName = "com.aura.tests.settings.\(UUID().uuidString)"
        guard let ud = UserDefaults(suiteName: suiteName) else {
            XCTFail("Failed to create UserDefaults suite")
            return
        }

        let manager1 = SettingsManager(userDefaults: ud)

        // Act: change and persist settings
        manager1.settings.borderThickness = .large
        manager1.settings.colorTheme = .blue

        // Create a second manager reading from the same store
        let manager2 = SettingsManager(userDefaults: ud)

        // Assert: values are persisted
        XCTAssertEqual(manager2.settings.borderThickness, .large)
        XCTAssertEqual(manager2.settings.colorTheme, .blue)
    }
}

