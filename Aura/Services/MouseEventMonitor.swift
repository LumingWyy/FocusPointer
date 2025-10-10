import Cocoa
import Combine

/// 鼠标事件监听服务
/// 监听全局鼠标事件并发布状态变化
final class MouseEventMonitor: ObservableObject {
    // MARK: - Published Properties

    /// 鼠标是否按下
    @Published private(set) var isMouseDown = false

    /// 当前鼠标位置
    @Published private(set) var mouseLocation: CGPoint = .zero

    // MARK: - Private Properties

    /// 事件监听器
    private var eventMonitor: Any?

    /// 是否正在监听
    private var isMonitoring = false

    // MARK: - Lifecycle

    deinit {
        stopMonitoring()
    }

    // MARK: - Public Methods

    /// 开始监听鼠标事件
    func startMonitoring() {
        guard !isMonitoring else { return }

        // 请求辅助功能权限
        let options: NSDictionary = [kAXTrustedCheckOptionPrompt.takeUnretainedValue() as String: true]
        let accessEnabled = AXIsProcessTrustedWithOptions(options)

        guard accessEnabled else {
            print("⚠️ 需要辅助功能权限才能监听鼠标事件")
            return
        }

        // 监听左键按下和松开事件
        eventMonitor = NSEvent.addGlobalMonitorForEvents(
            matching: [.leftMouseDown, .leftMouseUp, .leftMouseDragged]
        ) { [weak self] event in
            guard let self = self else { return }

            DispatchQueue.main.async {
                switch event.type {
                case .leftMouseDown:
                    self.isMouseDown = true
                    self.mouseLocation = NSEvent.mouseLocation

                case .leftMouseUp:
                    self.isMouseDown = false

                case .leftMouseDragged:
                    self.mouseLocation = NSEvent.mouseLocation

                default:
                    break
                }
            }
        }

        isMonitoring = true
        print("✅ 开始监听鼠标事件")
    }

    /// 停止监听鼠标事件
    func stopMonitoring() {
        guard isMonitoring else { return }

        if let monitor = eventMonitor {
            NSEvent.removeMonitor(monitor)
            eventMonitor = nil
        }

        isMonitoring = false
        isMouseDown = false
        print("🛑 停止监听鼠标事件")
    }
}
