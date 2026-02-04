# Daily Habit Tracker - Quick Start Guide

## 🎉 Welcome to Daily Habit Tracker!

Your complete fullstack app is ready. Here's how to get it running:

## 📋 Project Structure

```
daily_habit_tracker/
├── backend/
│   ├── index.js           # Express server with all API routes
│   ├── package.json       # Node.js dependencies
│   └── README.md          # Backend documentation
│
├── frontend/
│   ├── lib/
│   │   ├── main.dart      # App entry point
│   │   ├── models/        # Data classes (Habit, User, Streak)
│   │   ├── providers/     # State management
│   │   ├── screens/       # UI screens
│   │   └── services/      # API communication
│   ├── pubspec.yaml       # Flutter dependencies
│   └── README.md          # Frontend documentation
│
└── README.md              # Main documentation
```

## 🚀 Getting Started

### Step 1: Start the Backend

Open PowerShell/Terminal and run:

```bash
cd backend
npm install
npm start
```

✅ Backend will run on: `http://localhost:5000`

### Step 2: Run the Frontend

Open another PowerShell/Terminal:

```bash
cd frontend
flutter pub get
flutter run
```

✅ Choose your target device (Android emulator, iOS simulator, or web)

## 📱 Using the App

1. **Login**: Enter any username to get started
2. **Create Habit**: Tap the + button to add a new habit
3. **Mark Complete**: Click "Mark Done" to complete the habit for today
4. **Track Progress**: View your current streak and best streak
5. **Delete Habit**: Swipe or tap delete to remove a habit

## 🎨 Features

✅ **User Accounts** - Username-based login (no password needed for demo)
✅ **Habit Management** - Create, view, and delete habits
✅ **Daily Tracking** - Mark habits complete each day
✅ **Streak Tracking** - Current and best streak counters
✅ **Color Coding** - Choose colors for your habits
✅ **Descriptions** - Add optional descriptions to habits

## 🛠️ Technologies

- **Frontend**: Flutter + Provider (state management)
- **Backend**: Node.js + Express
- **Database**: SQLite (no setup needed, auto-created)
- **API**: RESTful endpoints

## 📚 API Endpoints

All endpoints return JSON:

- `POST /api/user` - Create/get user
- `GET /api/habits/:userId` - List all habits
- `POST /api/habits` - Create habit
- `DELETE /api/habits/:id` - Delete habit
- `POST /api/completions` - Mark complete
- `GET /api/streak/:habitId` - Get streak

## 🔧 Troubleshooting

**Backend won't start:**
```bash
# Make sure you're in the backend folder
cd backend
npm install  # Install packages if needed
npm start
```

**Frontend can't connect:**
- Ensure backend is running on port 5000
- Check `lib/services/api_service.dart` - baseUrl should be `http://localhost:5000/api`
- For physical devices, replace `localhost` with your machine's IP address

**Flutter not installed:**
```bash
flutter --version
flutter doctor  # Check for issues
```

## 📝 Key Files to Know

- `backend/index.js` - All API logic
- `frontend/lib/main.dart` - App setup
- `frontend/lib/providers/habit_provider.dart` - State management
- `frontend/lib/screens/home_screen.dart` - Main UI

## 🎯 Next Steps

- Add more features like reminders
- Implement data export
- Add charts and statistics
- Deploy backend to a cloud service
- Build for production (APK/IPA)

## 📖 Documentation

See `README.md` in the project root, `backend/README.md`, and `frontend/README.md` for detailed docs.

Happy tracking! 🎉
