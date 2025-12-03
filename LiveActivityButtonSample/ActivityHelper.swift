import Foundation
import Combine
import ActivityKit
import Shared

/// Live Activityを管理するヘルパークラス / Helper class to manage Live Activity
@MainActor
class ActivityHelper: ObservableObject {
    /// 現在のアクティビティ / Current activity
    @Published private(set) var currentActivity: Activity<ButtonLiveActivityAttributes>?
    
    /// 現在のカウント / Current count
    @Published private(set) var currentCount: Int = 0
    
    /// 更新タスク / Update task
    private var updateTask: Task<Void, Never>?
    
    init() {
        startObserving()
    }
    
    deinit {
        updateTask?.cancel()
    }

    /// アクティブかどうか / Whether active
    var isActive: Bool {
        currentActivity != nil
    }
    
    /// 現在の絵文字 / Current emoji
    var currentEmoji: String {
        currentActivity?.content.state.emoji ?? "😀"
    }
    
    /// Activityの状態を監視する / Start observing activity state
    private func startObserving() {
        // 0.5秒ごとにカウントを更新するタスクを開始 / Start task to update count every 0.5 seconds
        updateTask = Task { @MainActor in
            while !Task.isCancelled {
                await updateCurrentCount()
                try? await Task.sleep(nanoseconds: 500_000_000)
            }
        }
    }
    
    /// 現在のカウントを更新する / Update current count
    @MainActor
    func updateCurrentCount() async {
        guard let latestActivity = Activity<ButtonLiveActivityAttributes>.activities.first else {
            // Activityが存在しない場合、状態をリセット / Reset state if no activity exists
            if currentActivity != nil {
                currentActivity = nil
                currentCount = 0
            }
            return
        }
        
        // カウントを更新してActivityを更新 / Update count and activity
        currentCount = latestActivity.content.state.count
        currentActivity = latestActivity
    }
    
    /// Live Activityを開始する / Start Live Activity
    func startLiveActivity(name: String, emoji: String, count: Int) throws {
        let attributes = ButtonLiveActivityAttributes(name: name)
        let initialState = ButtonLiveActivityAttributes.ContentState(emoji: emoji, count: count)
        
        // Activityをリクエスト / Request activity
        let activity = try Activity<ButtonLiveActivityAttributes>.request(
            attributes: attributes,
            content: ActivityContent(state: initialState, staleDate: nil),
            pushType: nil
        )
        
        // 状態を更新 / Update state
        currentActivity = activity
        currentCount = count
    }
    
    /// Live Activityを更新する / Update Live Activity
    func updateLiveActivity(emoji: String, count: Int) async {
        guard let activity = currentActivity else { return }
        
        let updatedState = ButtonLiveActivityAttributes.ContentState(emoji: emoji, count: count)
        
        // Activityの状態を更新 / Update activity state
        await activity.update(ActivityContent(state: updatedState, staleDate: nil))
        // ローカルのカウントも更新 / Update local count
        currentCount = count
    }
    
    /// Live Activityを終了する / End Live Activity
    func endLiveActivity(emoji: String, count: Int) async {
        guard let activity = currentActivity else { return }
        
        let finalState = ButtonLiveActivityAttributes.ContentState(emoji: emoji, count: count)
        
        // Activityを終了 / End activity
        await activity.end(
            ActivityContent(state: finalState, staleDate: nil),
            dismissalPolicy: .immediate
        )
        
        // 状態をリセット / Reset state
        currentActivity = nil
        currentCount = 0
    }
}

