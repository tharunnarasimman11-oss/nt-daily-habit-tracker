import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/models.dart';

class ApiService {
  // Use 127.0.0.1 instead of localhost for web compatibility
  static const String baseUrl = 'http://127.0.0.1:5000/api';

  // Get or create user
  static Future<User> getOrCreateUser(String username) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/user'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'username': username}),
      );

      if (response.statusCode == 200) {
        return User.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to create/get user');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  // Get all habits
  static Future<List<Habit>> getHabits(int userId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/habits/$userId'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((json) => Habit.fromJson(json)).toList();
      } else {
        throw Exception('Failed to fetch habits');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  // Create a new habit
  static Future<Habit> createHabit(int userId, String name, String description, String color) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/habits'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'user_id': userId,
          'name': name,
          'description': description,
          'color': color,
        }),
      );

      if (response.statusCode == 200) {
        return Habit.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to create habit');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  // Delete a habit
  static Future<void> deleteHabit(int habitId) async {
    try {
      final response = await http.delete(
        Uri.parse('$baseUrl/habits/$habitId'),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to delete habit');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  // Mark habit as completed
  static Future<void> completeHabit(int habitId) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/completions'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'habit_id': habitId}),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to complete habit');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  // Get completions for a habit
  static Future<List<Completion>> getCompletions(int habitId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/completions/$habitId'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((json) => Completion.fromJson(json)).toList();
      } else {
        throw Exception('Failed to fetch completions');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  // Get streak for a habit
  static Future<Streak> getStreak(int habitId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/streak/$habitId'),
      );

      if (response.statusCode == 200) {
        return Streak.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to fetch streak');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
