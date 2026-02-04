import 'package:flutter/material.dart';
import '../models/models.dart';
import '../services/api_service.dart';

class HabitProvider extends ChangeNotifier {
  late User currentUser;
  List<Habit> habits = [];
  Map<int, Streak> streaks = {};
  Map<int, List<Completion>> completions = {};
  bool isLoading = false;

  Future<void> initializeUser(String username) async {
    isLoading = true;
    notifyListeners();
    try {
      currentUser = await ApiService.getOrCreateUser(username);
      await loadHabits();
    } catch (e) {
      print('Error initializing user: $e');
    }
    isLoading = false;
    notifyListeners();
  }

  Future<void> loadHabits() async {
    try {
      print('[HABITS] Loading habits for user ${currentUser.id}');
      habits = await ApiService.getHabits(currentUser.id);
      print('[HABITS] Got ${habits.length} habits');
      for (var habit in habits) {
        await loadStreak(habit.id!);
        await loadCompletions(habit.id!);
      }
      print('[HABITS] All habits loaded successfully');
      notifyListeners();
    } catch (e) {
      print('Error loading habits: $e');
      rethrow;
    }
  }

  Future<void> addHabit(String name, String description, String color) async {
    try {
      final habit = await ApiService.createHabit(currentUser.id, name, description, color);
      habits.add(habit);
      await loadStreak(habit.id!);
      notifyListeners();
    } catch (e) {
      print('Error adding habit: $e');
    }
  }

  Future<void> removeHabit(int habitId) async {
    try {
      await ApiService.deleteHabit(habitId);
      habits.removeWhere((h) => h.id == habitId);
      streaks.remove(habitId);
      completions.remove(habitId);
      notifyListeners();
    } catch (e) {
      print('Error removing habit: $e');
    }
  }

  Future<void> completeHabit(int habitId) async {
    try {
      await ApiService.completeHabit(habitId);
      await loadStreak(habitId);
      await loadCompletions(habitId);
      notifyListeners();
    } catch (e) {
      print('Error completing habit: $e');
    }
  }

  Future<void> loadStreak(int habitId) async {
    try {
      final streak = await ApiService.getStreak(habitId);
      streaks[habitId] = streak;
      notifyListeners();
    } catch (e) {
      print('Error loading streak: $e');
    }
  }

  Future<void> loadCompletions(int habitId) async {
    try {
      final comps = await ApiService.getCompletions(habitId);
      completions[habitId] = comps;
      notifyListeners();
    } catch (e) {
      print('Error loading completions: $e');
    }
  }

  bool isCompletedToday(int habitId) {
    final today = DateTime.now();
    final todayStr = '${today.year}-${today.month.toString().padLeft(2, '0')}-${today.day.toString().padLeft(2, '0')}';
    
    final comps = completions[habitId] ?? [];
    return comps.any((c) => c.completedDate == todayStr);
  }
}
