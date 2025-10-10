# 3. Project Structure

```plaintext
Aura/
├── Aura.xcodeproj
└── Aura/
    ├── App/
    │   └── AuraApp.swift           # Main application entry point
    ├── Core/
    │   ├── EventHandler/           # Global mouse event listener logic
    │   └── HighlightView/          # The SwiftUI View that draws the gradient border
    ├── Features/
    │   └── Settings/
    │       ├── SettingsView.swift        # The UI for the settings panel
    │       └── SettingsViewModel.swift   # State and logic for the settings view
    ├── Models/
    │   └── AppSettings.swift             # Data model for all user-configurable settings
    ├── Services/
    │   ├── PermissionsManager.swift      # Logic for checking/requesting Accessibility permissions
    │   └── SettingsService.swift         # Logic for saving and loading settings to disk
    └── Resources/
        └── Assets.xcassets               # To store the menu bar icon and other assets
```


