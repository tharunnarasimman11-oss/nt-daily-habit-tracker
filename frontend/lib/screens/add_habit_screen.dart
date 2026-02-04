import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/habit_provider.dart';

class AddHabitScreen extends StatefulWidget {
  const AddHabitScreen({super.key});

  @override
  State<AddHabitScreen> createState() => _AddHabitScreenState();
}

class _AddHabitScreenState extends State<AddHabitScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  String _selectedColor = '#4CAF50';
  bool _isLoading = false;

  final List<Map<String, dynamic>> _colorOptions = [
    {'name': 'Green', 'color': '#4CAF50'},
    {'name': 'Blue', 'color': '#2196F3'},
    {'name': 'Red', 'color': '#F44336'},
    {'name': 'Orange', 'color': '#FF9800'},
    {'name': 'Purple', 'color': '#9C27B0'},
    {'name': 'Pink', 'color': '#E91E63'},
  ];

  Future<void> _addHabit() async {
    if (_nameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a habit name')),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      await context.read<HabitProvider>().addHabit(
            _nameController.text,
            _descriptionController.text,
            _selectedColor,
          );

      if (mounted) {
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }

    setState(() => _isLoading = false);
  }

  Color _getColorFromHex(String hexColor) {
    final hex = hexColor.replaceFirst('#', '');
    return Color(int.parse('FF$hex', radix: 16));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Habit'),
        backgroundColor: Colors.indigo,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Habit Name',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                hintText: 'e.g., Morning Exercise',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Description (Optional)',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(
                hintText: 'e.g., 30 minutes of jogging',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 24),
            const Text(
              'Color',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 12,
              children: _colorOptions.map((option) {
                final isSelected = _selectedColor == option['color'];
                return GestureDetector(
                  onTap: () {
                    setState(() => _selectedColor = option['color']);
                  },
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: _getColorFromHex(option['color']),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.black,
                        width: isSelected ? 3 : 0,
                      ),
                    ),
                    child: isSelected
                        ? const Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 24,
                          )
                        : null,
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _addHabit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: _isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text(
                        'Create Habit',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
}
