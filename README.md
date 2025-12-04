# 🎯 Live Activity Button Sample

A fun iOS sample project demonstrating **interactive Live Activities** with buttons! Tap buttons directly from your Lock Screen or Dynamic Island to interact with your app. ✨

## 🚀 Features

- 📱 Interactive buttons in Live Activities (iOS 17+)
- 🔄 Real-time state updates
- 🏝️ Dynamic Island support
- 📊 Counter example with emoji
- 🎨 Beautiful UI with SwiftUI

## 📋 Requirements

- iOS 17.0+
- Xcode 15.0+
- Swift 6.0+

## 🏗️ Project Structure

```
LiveActivityButtonSample/
├── LiveActivityButtonSample/     # Main app
├── ButtonLiveActivity/            # Widget Extension
└── Shared/                        # Shared package
    └── Sources/Shared/
        ├── Shared.swift           # Activity attributes
        └── AppIntent.swift        # Button actions
```

## 🎮 How It Works

1. **Start** a Live Activity from the app
2. **See** it appear on your Lock Screen or Dynamic Island
3. **Tap** the button to increment the counter
4. **Watch** the count update in real-time! 🎉

## 🛠️ Setup

1. Clone the repository
2. Open `LiveActivityButtonSample.xcodeproj` in Xcode
3. Build and run on a physical device (iOS 17+)
4. Tap "Start Live Activity" and enjoy! 🎊

## 📝 Key Components

- **ActivityHelper**: Manages Live Activity lifecycle
- **IncrementCountIntent**: Handles button taps
- **ButtonLiveActivityLiveActivity**: Defines the UI

## 💡 What You'll Learn

- How to create interactive Live Activities
- Using `LiveActivityIntent` for button actions
- Sharing data between app and widget via Swift Package
- Dynamic Island customization

## 📄 License

See [LICENSE](LICENSE) file for details.

---

Made with ❤️ for iOS developers

