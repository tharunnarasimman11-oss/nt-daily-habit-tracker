import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/habit_provider.dart';
import '../models/models.dart';
import 'add_habit_screen.dart';

Color _hexToColor(String hex) {
  final h = hex.replaceFirst('#', '');
  return Color(int.parse('FF$h', radix: 16));
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HabitProvider>().loadHabits();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('NT Daily Habits'),
        backgroundColor: Colors.indigo,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              context.read<HabitProvider>().loadHabits();
            },
          ),
        ],
      ),
      body: Consumer<HabitProvider>(
        builder: (context, habitProvider, _) {
          if (habitProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (habitProvider.habits.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.inbox,
                    size: 80,
                    color: Colors.grey[400],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No habits yet',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const AddHabitScreen(),
                        ),
                      );
                    },
                    icon: const Icon(Icons.add),
                    label: const Text('Add Your First Habit'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                    ),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: habitProvider.habits.length,
            itemBuilder: (context, index) {
              final habit = habitProvider.habits[index];
              final streak = habitProvider.streaks[habit.id] ?? 
                  Streak(streak: 0, longestStreak: 0);
              final isCompletedToday = habitProvider.isCompletedToday(habit.id!);

              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                elevation: 6,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      Container(
                        width: 10,
                        height: 60,
                        decoration: BoxDecoration(
                          color: _hexToColor(habit.color),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              habit.name,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            if (habit.description.isNotEmpty)
                              Padding(
                                padding: const EdgeInsets.only(top: 6),
                                child: Text(
                                  habit.description,
                                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                                ),
                              ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Current Streak', style: TextStyle(fontSize: 12, color: Colors.grey[600])),
                                    Text('${streak.streak} days', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.indigo)),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Best', style: TextStyle(fontSize: 12, color: Colors.grey[600])),
                                    Text('${streak.longestStreak} days', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.orange)),
                                  ],
                                ),
                                ElevatedButton.icon(
                                  onPressed: isCompletedToday ? null : () => habitProvider.completeHabit(habit.id!),
                                  icon: Icon(isCompletedToday ? Icons.check_circle : Icons.add_circle_outline),
                                  label: Text(isCompletedToday ? 'Done' : 'Mark'),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: isCompletedToday ? Colors.grey : Colors.green,
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      IconButton(
                        icon: const Icon(Icons.delete_outline),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('Delete Habit?'),
                              content: Text('Are you sure you want to delete "${habit.name}"?'),
                              actions: [
                                TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
                                TextButton(onPressed: () { habitProvider.removeHabit(habit.id!); Navigator.pop(context); }, child: const Text('Delete', style: TextStyle(color: Colors.red))),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const AddHabitScreen(),
            ),
          );
        },
        backgroundColor: Colors.blueAccent,
        child: const Icon(Icons.add),
      ),
    );
  }
}
