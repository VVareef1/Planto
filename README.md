## 🌿 Planto Plant Care Reminder
A beautiful and intuitive iOS app to help you take care of your plants by sending timely watering reminders.

📱 About
Planto is a SwiftUI-based iOS application designed for plant lovers who want to keep their plants healthy and thriving. 
Never forget to water your plants again with smart notifications and easy-to-use plant management features.

## ✨ Features

- 🌱 **Add & Manage Plants**: Store your plant collection with detailed information
- 💧 **Watering Reminders**: Customizable watering schedules (daily, every 2 days, weekly, etc.)
- 🔔 **Push Notifications**: Get notified when it's time to water your plants
- 🏠 **Room Organization**: Organize plants by location (Bedroom, Living Room, Kitchen, etc.)
- ☀️ **Light Requirements**: Track sunlight needs (Full Sun, Partial Sun, Low Light)
- 💦 **Water Amount Tracking**: Record how much water each plant needs
- ✏️ **Edit & Delete**: Easily update or remove plants from your collection
- 📊 **Clean Interface**: Beautiful, user-friendly design with SwiftUI

## 🛠 Technologies Used

- **SwiftUI**: Modern declarative UI framework
- **UserNotifications**: Local push notifications
- **Combine**: Reactive programming
- **iOS 15.0+**: Minimum deployment target

## 📋 Requirements

- Xcode 14.0 or later
- iOS 15.0 or later
- macOS 12.0 or later (for development)

## 🎯 How to Use

1. **Add a Plant**: Tap the '+' button to add a new plant
2. **Fill Details**: Enter plant name, location, light requirements, and watering schedule
3. **Set Reminders**: Choose how often you want to be reminded to water
4. **Get Notified**: Receive timely notifications to water your plants
5. **Edit/Delete**: Long press or tap on a plant to edit or remove it

## 🏗 Project Structure
```
Planto/
├── Planto/
│   ├── MVVM/
│   │   ├── Model/
│   │   │   └── Plant.swift
│   │   └── ViewModels/
│   │       ├── NotificationViewModel.swift
│   │       ├── SetReminderViewModel.swift
│   │       ├── TodayReminderViewModel.swift
│   │       └── ViewModel.swift
│   ├── Views/
│   │   ├── AllDoneView.swift
│   │   ├── PlantRowView.swift
│   │   ├── SetReminder.swift
│   │   ├── SetUp.swift
│   │   ├── Splash.swift
│   │   ├── TodayReminder.swift
│   │   └── plant_animation
│   ├── Assets/
│   ├── Item.swift
│   └── PlantoApp.swift
├── PlantoTests/
│   └── PlantoTests.swift
└── PlantoUITests/
    ├── PlantoUITests.swift
    └── PlantoUITestsLaunchTests.swift
```

### 📂 File Descriptions

- **MVVM/Model**: Data models (Plant structure)
- **MVVM/ViewModels**: Business logic and state management
- **Views**: All SwiftUI view components
- **Assets**: Images, colors, and other resources
- **PlantoApp.swift**: Main app entry point
- **Tests**: Unit and UI tests



Made by Wareef S. Alzahrani with ❤️ and SwiftUI
