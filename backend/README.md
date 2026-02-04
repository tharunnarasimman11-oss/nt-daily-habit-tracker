# Daily Habit Tracker Backend

Express.js API server for the Daily Habit Tracker application.

## Setup

```bash
npm install
npm start
```

## API Documentation

### POST /api/user
Create or get a user by username

**Request:**
```json
{
  "username": "john_doe"
}
```

**Response:**
```json
{
  "id": 1,
  "username": "john_doe",
  "created_at": "2024-01-15T10:30:00.000Z"
}
```

### GET /api/habits/:userId
Get all habits for a user

**Response:**
```json
[
  {
    "id": 1,
    "user_id": 1,
    "name": "Morning Exercise",
    "description": "30 minutes jogging",
    "color": "#4CAF50",
    "created_at": "2024-01-15T10:30:00.000Z"
  }
]
```

### POST /api/habits
Create a new habit

**Request:**
```json
{
  "user_id": 1,
  "name": "Morning Exercise",
  "description": "30 minutes jogging",
  "color": "#4CAF50"
}
```

### DELETE /api/habits/:id
Delete a habit and all its completions

### POST /api/completions
Mark a habit as completed for today

**Request:**
```json
{
  "habit_id": 1
}
```

### GET /api/completions/:habitId
Get all completions for a habit

### GET /api/streak/:habitId
Get current and best streak for a habit

**Response:**
```json
{
  "streak": 5,
  "longestStreak": 10
}
```

## Environment Variables

Create a `.env` file (optional):
```
PORT=5000
```

## Database

SQLite database is automatically created as `habits.db` in the project root.
