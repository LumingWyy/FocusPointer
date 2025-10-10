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

    /// 鼠标事件监听器
    private let mouseMonitor = MouseEventMonitor()

    /// 高亮窗口
    private var highlightWindow: HighlightWindow?

    /// 订阅集合
    private var cancellables = Set<AnyCancellable>()

    // MARK: - Initialization

    init() {
        setupObservers()
    }

    // MARK: - Setup

    private func setupObservers() {
        // 监听鼠标按下状态
        mouseMonitor.$isMouseDown
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
        mouseMonitor.$mouseLocation
            .sink { [weak self] location in
                guard let self = self,
                      self.isEnabled,
                      self.mouseMonitor.isMouseDown else { return }

                self.updateHighlightPosition(location)
            }
            .store(in: &cancellables)
    }

    // MARK: - Private Methods

    /// 开始高亮功能
    private func startHighlighting() {
        mouseMonitor.startMonitoring()
        print("✨ 高亮功能已启用")
    }

    /// 停止高亮功能
    private func stopHighlighting() {
        mouseMonitor.stopMonitoring()
        hideHighlight()
        print("⏸️ 高亮功能已禁用")
    }

    /// 显示高亮效果
    private func showHighlight() {
        if highlightWindow == nil {
            highlightWindow = HighlightWindow()
        }

        let location = mouseMonitor.mouseLocation
        highlightWindow?.show(at: location)
    }

    /// 隐藏高亮效果
    private func hideHighlight() {
        highlightWindow?.hide()
    }

    /// 更新高亮位置
    private func updateHighlightPosition(_ location: CGPoint) {
        highlightWindow?.updatePosition(location)
    }

    // MARK: - Public Methods

    /// 切换高亮状态
    func toggle() {
        isEnabled.toggle()
    }
}
