# Flow

A SwiftUI iOS productivity app for managing workflows and tracking time across tasks.

## Overview

Flow helps you organize your work into structured workflows (called "Flows") with individual tasks that can be timed and tracked. Whether you're managing projects, daily routines, or creative processes, Flow provides a clean, intuitive interface for staying organized and measuring your productivity.

## Features

### 🔄 Flow Management
- Create custom workflows with descriptive titles and details
- Organize flows with custom icons and colors
- Edit and delete flows with swipe gestures
- Visual organization for easy identification

### ⏱️ Time Tracking
- Start/stop timers for individual tasks
- Track both active session time and cumulative time
- Toggle timing with a single tap
- Persistent time accumulation across app sessions

### 🎨 Customization
- Choose from system icons for flows and tasks
- Select custom colors for visual organization
- Theme support (Light, Dark, System)
- Clean, distraction-free interface

### 💾 Data Persistence
- Local storage using SwiftData
- Automatic saving of all changes
- Reliable data persistence across app launches

## Screenshots

*Add screenshots here when available*

## Requirements

- iOS 17.0+
- Xcode 15.0+
- Swift 5.9+

## Installation

1. Clone the repository:
```bash
git clone [repository-url]
cd Flow
```

2. Open the project in Xcode:
```bash
open Flow.xcodeproj
```

3. Build and run the app on your device or simulator

## Usage

### Creating a Flow
1. Tap the + button in the top right corner
2. Enter a title and description for your workflow
3. Choose an icon and color
4. Save your flow

### Adding Tasks
1. Select a flow from the main list
2. Tap the + button to add a new task
3. Enter task details and choose an icon
4. Save the task

### Time Tracking
1. Navigate to a flow's detail screen
2. Tap any task to start/stop its timer
3. View accumulated time for each task
4. Timers persist across app sessions

### Managing Content
- **Edit**: Swipe left on flows to edit
- **Delete**: Swipe right on flows or use delete gesture on tasks
- **Organize**: Flows are sorted by most recently updated

## Architecture

The app follows MVVM architecture with SwiftUI and SwiftData:

```
Flow/
├── Models/
│   ├── Flow.swift           # Flow data model
│   └── FlowItem.swift       # Task data model
├── Views/
│   ├── FlowItemView.swift   # Flow list item component
│   ├── TaskItemView.swift   # Task component with timer
│   └── [Other UI components]
├── Screens/
│   ├── FlowListScreen.swift # Main flows list
│   └── FlowDetailScreen.swift # Flow detail with tasks
├── ViewModels/
│   ├── FlowFormViewModel.swift
│   └── FlowTaskFormViewModel.swift
└── Extensions/
    └── FlowItem+Extensions.swift # Time tracking logic
```

## Key Models

### Flow
- Represents a workflow/project
- Contains multiple FlowItems (tasks)
- Supports custom icons and colors
- Tracks creation and update timestamps

### FlowItem
- Individual tasks within a flow
- Time tracking capabilities
- Start/stop/toggle functionality
- Accumulates time across sessions

## Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Author

Created by Axell Solis

## Acknowledgments

- Built with SwiftUI and SwiftData
- Icons provided by SF Symbols
- Inspired by productivity and time management principles