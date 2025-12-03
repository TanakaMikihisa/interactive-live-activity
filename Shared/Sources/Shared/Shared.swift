import ActivityKit
import Foundation

public struct ButtonLiveActivityAttributes: ActivityAttributes {
    /// アクティビティの動的な状態 / Dynamic state of the activity
    public struct ContentState: Codable, Hashable {
        
        public var emoji: String
        
        public var count: Int

        public init(emoji: String, count: Int) {
            self.emoji = emoji
            self.count = count
        }
    }

    public var name: String

    public init(name: String) {
        self.name = name
    }
}
