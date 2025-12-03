import ActivityKit
import AppIntents
import Foundation

/// カウントを増やすApp Intent / App Intent to increment count
@available(iOS 17.0, *)
public struct IncrementCountIntent: LiveActivityIntent {
    /// タイトル / Title
    public static let title: LocalizedStringResource = "Increment Count"
    /// 説明 / Description
    public static let description = IntentDescription("Count up")
    
    public init() {}
    
    /// Intentを実行する / Perform the intent
    public func perform() async throws -> some IntentResult {
        guard let activity = Activity<ButtonLiveActivityAttributes>.activities.first else {
            print("IncrementCountIntent: No activity found")
            return .result()
        }
        
        let currentContent = activity.content
        let currentState = currentContent.state
        let newCount = currentState.count + 1
        print("IncrementCountIntent: Current count: \(currentState.count), New: \(newCount)")

        let updatedState = ButtonLiveActivityAttributes.ContentState(
            emoji: currentState.emoji,
            count: newCount
        )
        
        do {
            await activity.update(
                .init(
                    state: updatedState,
                    staleDate: .distantFuture
                )
            )
            print("IncrementCountIntent: Activity updated successfully")
        }
        
        return .result()
    }
}
