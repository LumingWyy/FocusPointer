import Cocoa
import Combine

/// 高亮效果管理器
/// 协调鼠标事件监听和高亮窗口显示
final class HighlightManager: ObservableObject {
    // MARK: - Published Properties

    /// 高亮功能是否启用
    @Published var isEnabled = false {
        didSet {
            if isEnabled {
                startHighlighting()
            } else {
                stopHighlighting()
            }
        }
    }

    // MARK: - Private Properties

    /// 鼠标事件监听器（可注入，便于测试）
    private let mouseMonitor: MouseEventMonitoring

    /// 高亮窗口
    private var highlightWindow: HighlightWindow?

    /// 设置管理器
    private let settingsManager: SettingsManager

    /// 订阅集合
    private var cancellables = Set<AnyCancellable>()

    // MARK: - Initialization

    init(settingsManager: SettingsManager, mouseMonitor: MouseEventMonitoring = MouseEventMonitor()) {
        self.settingsManager = settingsManager
        self.mouseMonitor = mouseMonitor
        setupObservers()
        observeSettings()
    }

    // MARK: - Setup

    private func setupObservers() {
        // 监听鼠标按下状态
        mouseMonitor.isMouseDownPublisher
            .sink { [weak self] isDown in
                guard let self = self, self.isEnabled else { return }

                if isDown {
                    self.showHighlight()
                } else {
                    self.hideHighlight()
                }
            }
            .store(in: &cancellables)

        // 监听鼠标位置变化
        mouseMonitor.mouseLocationPublisher
            .sink { [weak self] location in
                guard let self = self,
                      self.isEnabled,
                      self.mouseMonitor.isMouseDown else { return }

                self.updateHighlightPosition(location)
            }
            .store(in: &cancellables)
    }

    /// 监听设置变化
    private func observeSettings() {
        settingsManager.$settings
            .sink { [weak self] settings in
                self?.highlightWindow?.updateSettings(settings)
                print("⚙️ Highlight settings updated: theme=\(settings.colorTheme.displayName), thickness=\(settings.borderThickness))")
            }
            .store(in: &cancellables)
    }

    // MARK: - Private Methods

    /// 开始高亮功能
    private func startHighlighting() {
        mouseMonitor.startMonitoring()
        print("✨ Highlighting enabled (awaiting mouse events)")
    }

    /// 停止高亮功能
    private func stopHighlighting() {
        // 保持鼠标监听常驻，仅隐藏高亮，避免重复触发系统权限弹窗
        hideHighlight()
        print("⏸️ Highlighting disabled (monitor remains active)")
    }

    /// 显示高亮效果
    private func showHighlight() {
        if highlightWindow == nil {
            highlightWindow = HighlightWindow(settings: settingsManager.settings)
        }

        let location = mouseMonitor.mouseLocation
        print("🎨 begin drag rect @ \(location)")
        highlightWindow?.beginDrag(at: location)
    }

    /// 隐藏高亮效果
    private func hideHighlight() {
        print("🎨 end drag rect (hide)")
        highlightWindow?.hide()
    }

    /// 更新高亮位置
    private func updateHighlightPosition(_ location: CGPoint) {
        highlightWindow?.updateDrag(to: location)
        // Debug: print occasionally to avoid flooding
        #if DEBUG
        // sample every ~8px move
        if Int(location.x) % 8 == 0 || Int(location.y) % 8 == 0 {
            print("🎨 update rect @ \(location)")
        }
        #endif
    }

    // MARK: - Public Methods

    /// 切换高亮状态
    func toggle() {
        isEnabled.toggle()
    }
}
