import SwiftUI
import AppKit

/// Settings window controller
/// Manages the settings window lifecycle
final class SettingsWindowController: NSObject {
    // MARK: - Properties

    /// Window instance
    private var window: NSWindow?

    /// Settings manager
    private let settingsManager: SettingsManager

    // MARK: - Initialization

    init(settingsManager: SettingsManager) {
        self.settingsManager = settingsManager
    }

    // MARK: - Public Methods

    /// Show settings window
    func show() {
        // If window exists, bring to front
        if let existingWindow = window {
            existingWindow.makeKeyAndOrderFront(nil)
            NSApp.activate(ignoringOtherApps: true)
            return
        }

        // Create new window
        let settingsView = SettingsView(settingsManager: settingsManager)
        let hostingView = NSHostingView(rootView: settingsView)

        let window = NSWindow(
            contentRect: NSRect(x: 0, y: 0, width: 500, height: 600),
            styleMask: [.titled, .closable, .miniaturizable],
            backing: .buffered,
            defer: false
        )

        window.center()
        window.title = "Aura Settings"
        window.contentView = hostingView
        window.isReleasedWhenClosed = false
        window.makeKeyAndOrderFront(nil)

        // Set delegate to handle close
        window.delegate = self

        self.window = window

        // Activate app
        NSApp.activate(ignoringOtherApps: true)
    }

    /// Close settings window
    func close() {
        window?.close()
    }
}

// MARK: - NSWindowDelegate

extension SettingsWindowController: NSWindowDelegate {
    func windowWillClose(_ notification: Notification) {
        // Keep reference
        print("⚙️ Settings window closed")
    }
}
