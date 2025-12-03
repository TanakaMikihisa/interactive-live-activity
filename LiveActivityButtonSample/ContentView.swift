import SwiftUI

struct ContentView: View {
    @StateObject private var activityHelper = ActivityHelper()
    @State var initialCount = 0
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Count: \(activityHelper.currentCount)")
            
            Button {
                startLiveActivity()
            } label: {
                Text("Start Live Activity")
            }
            .disabled(activityHelper.isActive)
            
            if activityHelper.isActive {
                Button {
                    Task {
                        await endLiveActivity()
                    }
                } label: {
                    Text("End Live Activity")
                }
            }
        }
    }
    
    private func startLiveActivity() {
        do {
            print("Live Activity started!")
            try activityHelper.startLiveActivity(name: "Counter", emoji: "😀", count: initialCount)
        } catch {
            print("Failed to start Live Activity: \(error)")
        }
    }
    
    private func endLiveActivity() async {
        print("Live Activity stopped!")
        await activityHelper.endLiveActivity(emoji: activityHelper.currentEmoji, count: activityHelper.currentCount)
    }
}

#Preview {
    ContentView()
}
