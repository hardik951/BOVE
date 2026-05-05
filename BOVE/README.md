# 🚤 BOVE — Boat Voyage & Emergency Safety System

**BOVE** is a premium iOS application designed to enhance maritime safety for boat operators, captains, and crew. With a stunning **Boho Glassmorphism** UI, it provides real-time passenger management, pre-departure safety verification, live trip monitoring, and emergency SOS capabilities — all in one elegant interface.

---

## ✨ Key Features

### 🧑‍🤝‍🧑 Passenger Management
- **Live Passenger Counter** — Track onboard headcount with intuitive `+` / `−` controls and a beautiful circular progress ring.
- **Capacity Status Indicator** — Automatically updates to **Safe** (green), **Near Capacity** (orange), or **Overloaded** (red) based on current count vs. maximum capacity.
- **Visual Progress Ring** — Animated circular gauge shows at-a-glance occupancy percentage.

### ✅ Pre-Trip Safety Checklist
- **Mandatory Verification** — Three critical checks must be completed before any trip can begin:
  - 🛟 **Life Jackets** — Confirm all life jackets are available and accessible.
  - 🌤️ **Weather Check** — Verify weather conditions are safe for departure.
  - 🛡️ **Passengers Verified** — Confirm all passengers are accounted for.
- **Smart Trip Lock** — The "Start Trip" button only activates when all checks are complete and the boat is not overloaded.

### 📍 Active Trip Monitoring
- **Live Timer** — Real-time elapsed duration displayed in a large monospaced format (`HH:MM:SS`).
- **LIVE Indicator** — Green pulsing dot confirms the trip is actively being monitored.
- **Trip Start Time** — Shows exactly when the current voyage began.
- **Passenger & Security Status** — Displays current passenger count and security status at a glance.
- **End Trip** — One-tap trip completion that automatically logs the voyage to history.

### 📋 Trip History
- **Complete Voyage Log** — Every completed trip is automatically recorded with:
  - Date and time of departure
  - Total trip duration
  - Number of passengers onboard
- **Scrollable History Cards** — Browse past trips in beautifully styled glassmorphism cards.
- **Auto-Reset** — Safety checklist resets after each trip ends, ensuring fresh verification for every voyage.

### 🆘 Emergency SOS
- **Always-On SOS Button** — Floating emergency button with a pulsing red animation, accessible from every screen in the app.
- **Instant Access** — Designed for quick activation during emergencies.

---

## 🎨 Design Philosophy

BOVE uses a custom **Boho Glassmorphism** design system featuring:

| Element | Description |
|---|---|
| **Color Palette** | Warm sand beige, terracotta, olive green, and warm brown tones |
| **Glassmorphism** | Frosted glass cards with thin borders and soft shadows using `UIKit` materials |
| **Typography** | System SF fonts with varied weights — from bold headers to monospaced timers |
| **Animations** | Spring animations on buttons, smooth progress ring transitions, and pulsing SOS |
| **Dark Mode** | Full adaptive color support for both light and dark appearances |
| **Gradients** | Warm peach-to-blue background gradient and terracotta button gradients |

---

## 🏗️ Architecture

```
BOVE/
├── BOVEApp.swift              # App entry point
├── ContentView.swift           # Root view with color scheme preference
├── Components/
│   └── BohoComponents.swift    # Reusable UI components (buttons, counters, SOS)
├── Models/
│   └── TripModel.swift         # Data models, app state (MVVM), trip logic
├── Theme/
│   ├── BohoColors.swift        # Color palette with dark mode support
│   └── GlassModifiers.swift    # Glassmorphism view modifiers
└── Views/
    ├── DashboardView.swift     # Main dashboard with passenger counter & checklist
    ├── MainTabView.swift       # Tab navigation with custom glass tab bar
    └── TripView.swift          # Active monitoring & trip history
```

### Pattern: **MVVM**
- **Model** — `TripRecord`, `SafetyCheckItem`, `CapacityStatus`
- **ViewModel** — `AppState` (ObservableObject) manages all app logic including trip lifecycle, passenger tracking, and safety checks
- **View** — SwiftUI views observe and react to `AppState` changes

---

## 🛠️ Tech Stack

| Technology | Details |
|---|---|
| **Language** | Swift 5.9+ |
| **Framework** | SwiftUI |
| **Reactive** | Combine (for trip timer) |
| **Min. Deployment** | iOS 16.0 |
| **IDE** | Xcode 15+ |
| **Architecture** | MVVM |

---

## 🚀 Getting Started

### Prerequisites
- macOS Sonoma or later
- Xcode 15.0 or later
- An iOS 16+ device or simulator

### Installation

```bash
# Clone the repository
git clone https://github.com/hardik951/BOVE.git

# Open in Xcode
cd BOVE
open BOVE.xcodeproj
```

1. Select your target device (iPhone simulator or physical device).
2. Press `⌘ + R` to build and run.

---

## 📱 App Flow

```
Launch → Dashboard
            │
            ├── Adjust passenger count (+/−)
            ├── Complete safety checklist (3 items)
            ├── Tap "Start Trip" (enabled when all checks pass)
            │       │
            │       └── Auto-navigate to Trips tab
            │               │
            │               ├── Live monitoring (timer, status)
            │               └── Tap "End Trip"
            │                       │
            │                       ├── Trip saved to history
            │                       └── Checklist auto-resets
            │
            └── SOS button (always visible)
```

---

## 👨‍💻 Author

**Hardik Sahni**  
📧 hardiksahni09@gmail.com  
🔗 [github.com/hardik951](https://github.com/hardik951)

---

## 📄 License

This project is available for educational and personal use.

---

*Ensuring safety on the water, one trip at a time.* ⛵
