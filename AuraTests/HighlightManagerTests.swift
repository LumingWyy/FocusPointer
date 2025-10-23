import XCTest
import Combine
@testable import Aura

// Mock monitor implementing protocol for deterministic testing
final class MockMouseEventMonitor: MouseEventMonitoring {
    var isMouseDown: Bool = false
    var mouseLocation: CGPoint = .zero

    private let isMouseDownSubject = PassthroughSubject<Bool, Never>()
    private let mouseLocationSubject = PassthroughSubject<CGPoint, Never>()

    var isMouseDownPublisher: AnyPublisher<Bool, Never> { isMouseDownSubject.eraseToAnyPublisher() }
    var mouseLocationPublisher: AnyPublisher<CGPoint, Never> { mouseLocationSubject.eraseToAnyPublisher() }

    private(set) var startCount = 0
    private(set) var stopCount = 0

    func startMonitoring() { startCount += 1 }
    func stopMonitoring() { stopCount += 1 }

    // helpers
    func sendMouseDown(_ down: Bool) {
        isMouseDown = down
        isMouseDownSubject.send(down)
    }

    func sendLocation(_ point: CGPoint) {
        mouseLocation = point
        mouseLocationSubject.send(point)
    }
}

@MainActor
final class HighlightManagerTests: XCTestCase {
    func testToggleStartsAndStopsMonitoring() {
        // Arrange
        let ud = UserDefaults(suiteName: "com.aura.tests.highlight.\(UUID().uuidString)")!
        let settings = SettingsManager(userDefaults: ud)
        let mock = MockMouseEventMonitor()
        let manager = HighlightManager(settingsManager: settings, mouseMonitor: mock)

        // Act & Assert
        manager.toggle() // enable
        XCTAssertEqual(mock.startCount, 1, "Should start monitoring when enabled")
        XCTAssertTrue(manager.isEnabled)

        manager.toggle() // disable
        // Note: 监听器保持常驻以避免重复权限请求,仅隐藏高亮
        XCTAssertEqual(mock.stopCount, 0, "Monitor should remain active to avoid permission re-prompts")
        XCTAssertFalse(manager.isEnabled)
    }

    func testReceivesMouseEventsWhenEnabled() {
        // Arrange
        let ud = UserDefaults(suiteName: "com.aura.tests.highlight.events.\(UUID().uuidString)")!
        let settings = SettingsManager(userDefaults: ud)
        let mock = MockMouseEventMonitor()
        let manager = HighlightManager(settingsManager: settings, mouseMonitor: mock)

        // Act: enable and simulate events (should not crash)
        manager.toggle()
        mock.sendMouseDown(true)
        mock.sendLocation(CGPoint(x: 100, y: 200))

        // Assert: sanity (no crash path)
        XCTAssertTrue(manager.isEnabled)
    }
}

