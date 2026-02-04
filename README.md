# Daily Habit Tracker - Fullstack App

A complete Daily Habit Tracker application built with Flutter (frontend), Node.js/Express (backend), and SQLite (database).

## Features

- ✅ User Authentication (username-based)
- ✅ Create, Read, Delete Habits
- ✅ Mark habits as completed daily
- ✅ View current streak and best streak
- ✅ Simple and intuitive UI
- ✅ Real-time data synchronization

## Project Structure

```
daily_habit_tracker/
├── backend/          # Node.js Express API
├── frontend/         # Flutter Mobile App
└── README.md
```

## Quick Start

### Prerequisites

- Node.js 14+ and npm
- Flutter 3.0+
- SQLite (included with Node.js packages)

### Backend Setup

1. Navigate to the backend folder:
```bash
cd backend
```

2. Install dependencies:
```bash
npm install
```

3. Start the server:
```bash
npm start
```

The API will run on `http://localhost:5000`

### Frontend Setup

1. Navigate to the frontend folder:
```bash
cd frontend
```

2. Get Flutter dependencies:
```bash
flutter pub get
```

3. Run the app:
```bash
flutter run
```

## API Endpoints

### User Management
- `POST /api/user` - Get or create a user

### Habits
- `GET /api/habits/:userId` - Get all habits for a user
- `POST /api/habits` - Create a new habit
- `DELETE /api/habits/:id` - Delete a habit

### Completions
- `POST /api/completions` - Mark habit as completed
- `GET /api/completions/:habitId` - Get completions for a habit

### Streaks
- `GET /api/streak/:habitId` - Get current and best streak

## Database Schema

### Users Table
```sql
CREATE TABLE users (
  id INTEGER PRIMARY KEY,
  username TEXT UNIQUE NOT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);
```

### Habits Table
```sql
CREATE TABLE habits (
  id INTEGER PRIMARY KEY,
  user_id INTEGER NOT NULL,
  name TEXT NOT NULL,
  description TEXT,
  color TEXT DEFAULT '#4CAF50',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(id)
);
```

### Completions Table
```sql
CREATE TABLE completions (
  id INTEGER PRIMARY KEY,
  habit_id INTEGER NOT NULL,
  completed_date TEXT NOT NULL,
  completed_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (habit_id) REFERENCES habits(id)
);
```

## How to Use

1. **Login**: Enter your username to get started
2. **Create Habits**: Click the FAB to add new habits with name, description, and color
3. **Track Progress**: Mark habits as complete daily to build streaks
4. **View Streaks**: See your current streak and best streak for each habit
5. **Delete Habits**: Remove habits you no longer want to track

## Technologies Used

- **Frontend**: Flutter, Provider (State Management), HTTP
- **Backend**: Node.js, Express.js, CORS
- **Database**: SQLite3

## Future Enhancements

- Weekly/Monthly progress charts
- Habit reminders and notifications
- Export progress data
- Multi-user sync with cloud backup
- Dark mode support
- Social sharing features

## License

MIT License

## Author

Created as a learning project for fullstack mobile development.
