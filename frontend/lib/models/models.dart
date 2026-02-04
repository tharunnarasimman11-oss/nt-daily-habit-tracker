class Habit {
  final int? id;
  final int userId;
  final String name;
  final String description;
  final String color;
  final DateTime createdAt;

  Habit({
    this.id,
    required this.userId,
    required this.name,
    this.description = '',
    this.color = '#4CAF50',
    required this.createdAt,
  });

  factory Habit.fromJson(Map<String, dynamic> json) {
    return Habit(
      id: json['id'],
      userId: json['user_id'],
      name: json['name'],
      description: json['description'] ?? '',
      color: json['color'] ?? '#4CAF50',
      createdAt: DateTime.parse(json['created_at'] ?? DateTime.now().toString()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'name': name,
      'description': description,
      'color': color,
      'created_at': createdAt.toIso8601String(),
    };
  }
}

class Completion {
  final int? id;
  final int habitId;
  final String completedDate;
  final DateTime completedAt;

  Completion({
    this.id,
    required this.habitId,
    required this.completedDate,
    required this.completedAt,
  });

  factory Completion.fromJson(Map<String, dynamic> json) {
    return Completion(
      id: json['id'],
      habitId: json['habit_id'],
      completedDate: json['completed_date'],
      completedAt: DateTime.parse(json['completed_at'] ?? DateTime.now().toString()),
    );
  }
}

class Streak {
  final int streak;
  final int longestStreak;

  Streak({required this.streak, required this.longestStreak});

  factory Streak.fromJson(Map<String, dynamic> json) {
    return Streak(
      streak: json['streak'] ?? 0,
      longestStreak: json['longestStreak'] ?? 0,
    );
  }
}

class User {
  final int id;
  final String username;
  final DateTime createdAt;

  User({
    required this.id,
    required this.username,
    required this.createdAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      username: json['username'],
      createdAt: DateTime.parse(json['created_at'] ?? DateTime.now().toString()),
    );
  }
}
