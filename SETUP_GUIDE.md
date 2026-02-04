# Daily Habit Tracker - Complete Setup Guide

## 📦 What's Included

Your complete fullstack Daily Habit Tracker app includes:

### Backend (Node.js + Express)
- ✅ RESTful API with 6+ endpoints
- ✅ SQLite database with 3 tables (users, habits, completions)
- ✅ Streak calculation logic
- ✅ CORS enabled for frontend communication
- ✅ Ready for deployment

### Frontend (Flutter)
- ✅ Clean, modern UI with Material Design
- ✅ 3 main screens (Login, Home, Add Habit)
- ✅ State management with Provider
- ✅ HTTP client for API communication
- ✅ Color customization for habits

### Database (SQLite)
- ✅ Auto-created on first run
- ✅ Three interconnected tables
- ✅ Automatic date-based streak tracking

---

## 🚀 Installation & Running

### Prerequisites Check

Before starting, ensure you have:

```powershell
# Check Node.js (v14+)
node --version

# Check npm
npm --version

# Check Flutter
flutter --version

# Check Dart
dart --version
```

### Step 1: Run Backend Server

```powershell
# Navigate to backend
cd daily_habit_tracker\backend

# Install npm packages
npm install

# Start the server
npm start
```

**Expected Output:**
```
Habit Tracker API running on http://localhost:5000
Connected to SQLite database
```

✅ **Backend is now running!**

### Step 2: Run Flutter App

Open a **new PowerShell/Terminal window**:

```powershell
# Navigate to frontend
cd daily_habit_tracker\frontend

# Get Flutter dependencies
flutter pub get

# Run the app
flutter run
```

**Choose your target:**
- Type `a` for Android emulator
- Type `i` for iOS simulator
- Type `w` for Web browser

✅ **App is now running!**

---

## 📱 App Features Explained

### Login Screen
- Enter any username (no password required for demo)
- Create new user or login with existing username
- Simple, clean interface

### Home Screen
- **Habit List**: View all your habits in card format
- **Current Streak**: Days in a row completed
- **Best Streak**: Your personal record
- **Mark Done**: Complete the habit for today
- **Delete**: Remove habit permanently
- **Floating Action Button**: Add new habit

### Add Habit Screen
- **Name**: Habit name (required)
- **Description**: Optional details
- **Color**: Choose from 6 colors
- **Create**: Add to your list

### Features
- ✅ Mark habits complete once per day
- ✅ Automatic streak calculation
- ✅ Real-time sync with backend
- ✅ Color-coded habits
- ✅ Delete habits with confirmation

---

## 🔌 API Reference

### Base URL
```
http://localhost:5000/api
```

### Endpoints

#### 1. User Management
```
POST /api/user
Request: {"username": "john"}
Response: {"id": 1, "username": "john", "created_at": "..."}
```

#### 2. Get Habits
```
GET /api/habits/:userId
Response: [{id, user_id, name, description, color, created_at}, ...]
```

#### 3. Create Habit
```
POST /api/habits
Request: {
  "user_id": 1,
  "name": "Morning Run",
  "description": "30 minutes",
  "color": "#4CAF50"
}
Response: {id, user_id, name, description, color, created_at}
```

#### 4. Delete Habit
```
DELETE /api/habits/:habitId
Response: {message: "Habit deleted"}
```

#### 5. Complete Habit
```
POST /api/completions
Request: {"habit_id": 1}
Response: {id, habit_id, completed_date}
```

#### 6. Get Completions
```
GET /api/completions/:habitId
Response: [{id, habit_id, completed_date, completed_at}, ...]
```

#### 7. Get Streak
```
GET /api/streak/:habitId
Response: {"streak": 5, "longestStreak": 10}
```

---

## 📁 File Structure Explained

```
daily_habit_tracker/
│
├── backend/
│   ├── index.js              # Express server + all routes
│   ├── package.json          # Dependencies (express, sqlite3, cors)
│   ├── .gitignore           # Git ignore rules
│   └── README.md            # Backend docs
│
├── frontend/
│   ├── lib/
│   │   ├── main.dart                      # App entry, routing
│   │   ├── models/
│   │   │   └── models.dart               # Habit, User, Streak, Completion
│   │   ├── providers/
│   │   │   └── habit_provider.dart       # State management (Provider)
│   │   ├── screens/
│   │   │   ├── login_screen.dart         # User login
│   │   │   ├── home_screen.dart          # Habit list & tracker
│   │   │   └── add_habit_screen.dart     # Create habit form
│   │   └── services/
│   │       └── api_service.dart          # HTTP client
│   ├── pubspec.yaml          # Flutter dependencies
│   ├── android/              # Android config
│   ├── .gitignore           # Git ignore rules
│   └── README.md            # Frontend docs
│
├── QUICK_START.md           # Quick setup guide
└── README.md                # Main documentation
```

---

## 💾 Database Schema

### users
```sql
id (PRIMARY KEY)
username (UNIQUE)
created_at (TIMESTAMP)
```

### habits
```sql
id (PRIMARY KEY)
user_id (FOREIGN KEY -> users)
name (TEXT)
description (TEXT)
color (TEXT)
created_at (TIMESTAMP)
```

### completions
```sql
id (PRIMARY KEY)
habit_id (FOREIGN KEY -> habits)
completed_date (TEXT) -- YYYY-MM-DD format
completed_at (TIMESTAMP)
```

---

## 🔧 Troubleshooting

### Issue: "Cannot find module 'sqlite3'"
```bash
cd backend
npm install sqlite3 --save
npm start
```

### Issue: "Backend connection refused"
- Ensure backend is running: `npm start` in backend folder
- Check if port 5000 is available
- Check firewall settings

### Issue: "Flutter app crashes on startup"
- Run `flutter pub get` again
- Clean build: `flutter clean && flutter pub get`
- Check Flutter version: `flutter --version`

### Issue: "Cannot reach localhost from device"
For physical devices, replace `localhost` with your machine's IP:
1. Get your IP: `ipconfig` (look for IPv4 Address)
2. Edit `frontend/lib/services/api_service.dart`
3. Change `baseUrl = 'http://localhost:5000/api'` to `http://YOUR_IP:5000/api`

### Issue: "Emulator/simulator won't start"
```bash
# List available devices
flutter devices

# Run on specific device
flutter run -d <device_id>
```

---

## 📈 What Can Be Added

### Phase 2 Features
- [ ] Weekly/Monthly statistics
- [ ] Push notifications for reminders
- [ ] Data export (CSV, PDF)
- [ ] Cloud sync
- [ ] Dark mode
- [ ] Multiple devices sync

### Deployment
- [ ] Deploy backend to Heroku/Railway/AWS
- [ ] Build production APK for Android
- [ ] Build IPA for iOS
- [ ] Web version deployment

---

## 📝 Code Walkthrough

### How Streaks Work (backend/index.js)
```javascript
// GET /api/streak/:habitId
// 1. Fetch all completions sorted by date
// 2. Check if completed today or yesterday
// 3. Calculate consecutive days
// 4. Track longest streak
// Returns: {streak: 5, longestStreak: 10}
```

### How State Management Works (Provider)
```dart
// HabitProvider extends ChangeNotifier
// - Holds currentUser, habits list, streaks map
// - Loads data on init
// - Updates UI when data changes
// - Communicates with ApiService
```

### Frontend Flow
```
LoginScreen (username input)
  ↓
HabitProvider.initializeUser()
  ↓
HomeScreen (display habits)
  ↓
Add/Complete/Delete (API calls via Provider)
  ↓
Provider notifies listeners
  ↓
UI rebuilds with new data
```

---

## 🎯 Next Steps

1. ✅ Get backend running
2. ✅ Get frontend running
3. ✅ Create a test account
4. ✅ Add 3-4 habits
5. ✅ Mark them complete daily
6. ✅ Check streaks working

Then:
- Explore the code
- Modify UI colors
- Add new features
- Deploy!

---

## 📚 Useful Commands

```bash
# Backend
npm install              # Install dependencies
npm start               # Start server
npm run dev             # Development mode with nodemon

# Frontend
flutter pub get         # Get dependencies
flutter run             # Run app
flutter build apk       # Build Android
flutter build ios       # Build iOS
flutter clean           # Clean build files
flutter doctor          # Check environment
```

---

## 🤝 Support

For issues:
1. Check the troubleshooting section
2. Review individual README files (backend/ and frontend/)
3. Check console/terminal output for errors
4. Verify all prerequisites are installed

Happy building! 🚀
