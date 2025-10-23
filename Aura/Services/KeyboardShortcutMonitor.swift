import Cocoa
import Combine

/// 键盘快捷键监听协议
protocol KeyboardShortcutMonitoring: AnyObject {
    var toggleRequested: AnyPublisher<Void, Never> { get }
    func startMonitoring()
    func stopMonitoring()
}

/// Global keyboard monitor: toggle on Control+Option+Command+H
final class KeyboardShortcutMonitor: KeyboardShortcutMonitoring {
    // MARK: - Public publisher
    private let toggleSubject = PassthroughSubject<Void, Never>()
    var toggleRequested: AnyPublisher<Void, Never> { toggleSubject.eraseToAnyPublisher() }

    // MARK: - Private state
    private var keyMonitor: Any?
    private var isMonitoring = false

    // Key codes
    private let keycodeH: Int = 4 // 'H'

    deinit { stopMonitoring() }

    // MARK: - Monitoring
    func startMonitoring() {
        guard !isMonitoring else { return }

        keyMonitor = NSEvent.addGlobalMonitorForEvents(matching: [.keyDown]) { [weak self] event in
            self?.handleKeyDown(event)
        }

        isMonitoring = true
        print("⌨️ Keyboard monitor installed (Ctrl+Option+Cmd+H to toggle)")
    }

    func stopMonitoring() {
        guard isMonitoring else { return }
        if let m = keyMonitor { NSEvent.removeMonitor(m) }
        keyMonitor = nil
        isMonitoring = false
    }

    // MARK: - Logic
    private func handleKeyDown(_ event: NSEvent) {
        if event.isARepeat { return }
        let code = Int(event.keyCode)
        let flags = event.modifierFlags
        let required: NSEvent.ModifierFlags = [.control, .option, .command]

        if code == keycodeH && flags.isSuperset(of: required) {
            #if DEBUG
            print("⌨️ Ctrl+Option+Cmd+H matched → toggle")
            #endif
            toggleSubject.send(())
        }
    }
}
