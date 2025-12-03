import ActivityKit
import WidgetKit
import SwiftUI
import AppIntents
import Shared

/// Live Activityウィジェット / Live Activity widget
struct ButtonLiveActivityLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: ButtonLiveActivityAttributes.self) { context in
            VStack(spacing: 16) {
                Text("Hello \(context.state.emoji)")
                Text("Count: \(context.state.count)")
                    .font(.title)
                    .fontWeight(.bold)
                Button(intent: IncrementCountIntent()) {
                    Label("Count Up", systemImage: "plus.circle.fill")
                }
                .buttonStyle(.borderedProminent)
            }
            .padding()
            .activityBackgroundTint(Color.cyan)
            .activitySystemActionForegroundColor(Color.black)

        } dynamicIsland: { context in
            DynamicIsland {
                DynamicIslandExpandedRegion(.leading) {
                    Text("Leading")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Trailing")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    VStack(spacing: 12) {
                        Text("Bottom \(context.state.emoji)")
                        Text("Count: \(context.state.count)")
                            .font(.title2)
                            .fontWeight(.semibold)
                        Button(intent: IncrementCountIntent()) {
                            Label("Count Up", systemImage: "plus.circle.fill")
                        }
                        .buttonStyle(.borderedProminent)
                    }
                }
            } compactLeading: {
                Text("L")
            } compactTrailing: {
                Text("\(context.state.count)")
            } minimal: {
                Text("\(context.state.count)")
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

extension ButtonLiveActivityAttributes {
    /// プレビュー用の属性 / Attributes for preview
    fileprivate static var preview: ButtonLiveActivityAttributes {
        ButtonLiveActivityAttributes(name: "World")
    }
}

extension ButtonLiveActivityAttributes.ContentState {
    /// プレビュー用の状態（スマイル） / Preview state (smiley)
    fileprivate static var smiley: ButtonLiveActivityAttributes.ContentState {
        ButtonLiveActivityAttributes.ContentState(emoji: "😀", count: 0)
     }
     
     /// プレビュー用の状態（星目） / Preview state (star eyes)
     fileprivate static var starEyes: ButtonLiveActivityAttributes.ContentState {
         ButtonLiveActivityAttributes.ContentState(emoji: "🤩", count: 0)
     }
}

#Preview("Notification", as: .content, using: ButtonLiveActivityAttributes.preview) {
   ButtonLiveActivityLiveActivity()
} contentStates: {
    ButtonLiveActivityAttributes.ContentState.smiley
    ButtonLiveActivityAttributes.ContentState.starEyes
}
