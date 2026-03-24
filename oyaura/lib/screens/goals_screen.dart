import '../widgets/mobile_layout.dart'; // Use new layout
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter/material.dart';


class GoalMakerUI extends StatefulWidget {
  const GoalMakerUI({super.key});

  @override
  State<GoalMakerUI> createState() => _GoalMakerUIState();
}

class _GoalMakerUIState extends State<GoalMakerUI> {
  final supabase = Supabase.instance.client;

  List<dynamic> _goals = [];
  bool _isLoading = true;
  final TextEditingController _wantCtrl = TextEditingController();

  String get currentUserId => supabase.auth.currentUser?.id ?? "";

  @override
  void initState() {
    super.initState();
    fetchGoals();
  }

  Future<void> fetchGoals() async {
    if (currentUserId.isEmpty) {
      if (mounted) setState(() => _isLoading = false);
      return;
    }

    try {
      final data = await supabase
          .from('goals')
          .select()
          .eq('user_id', currentUserId)
          .order('created_at', ascending: true);

      if (mounted) {
        setState(() {
          _goals = data;
          _isLoading = false;
        });
      }
    } catch (e) {
      print("Fetch error: $e");
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> addGoal() async {
    if (_wantCtrl.text.trim().isEmpty) return;

    if (currentUserId.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error: You must be logged in to add a goal!'),
        ),
      );
      return;
    }

    try {
      await supabase.from('goals').insert({
        "user_id": currentUserId,
        "title": _wantCtrl.text.trim(),
        "priority": "Medium",
      });

      _wantCtrl.clear();
      fetchGoals();
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Database Error: $e')));
    }
  }

  // NEW FEATURE: Edit an existing goal in the database
  Future<void> editGoal(String id, String newTitle) async {
    if (newTitle.trim().isEmpty) return;

    try {
      await supabase
          .from('goals')
          .update({"title": newTitle.trim()})
          .eq('goal_id', id);

      fetchGoals();
    } catch (e) {
      print("Edit error: $e");
    }
  }

  Future<void> toggleGoal(String id, bool currentStatus) async {
    bool willBeCompleted = !currentStatus; // What the status is changing to

    try {
      await supabase
          .from('goals')
          .update({"is_completed": willBeCompleted})
          .eq('goal_id', id);

      await fetchGoals(); // Wait for the list to refresh

      // NEW FEATURE: Check if all goals are now completed
      if (willBeCompleted && _goals.isNotEmpty) {
        bool allDone = _goals.every((g) => g['is_completed'] == true);
        if (allDone) {
          _showAllCompletedPopup();
        }
      }
    } catch (e) {
      print("Toggle error: $e");
    }
  }

  // The Celebration Pop-up UI
  void _showAllCompletedPopup() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Row(
          children: [
            Text('🎉 ', style: TextStyle(fontSize: 24)),
            Text('Congratulations!'),
          ],
        ),
        content: const Text(
          'You have completed all your goals for today! Keep up the amazing work.',
          style: TextStyle(fontSize: 16),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text(
              'Awesome!',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return MobileLayout(
      currentScreen: 'goals',
      child: Column(
        children: [
          // ...existing code for your screen body...
          Container(
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Achieve Your Goals!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: colorScheme.primary,
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _wantCtrl,
                        textInputAction: TextInputAction.done,
                        onSubmitted: (_) => addGoal(),
                        decoration: InputDecoration(
                          hintText: 'Type new goal or habit...',
                          prefixIcon: const Icon(Icons.track_changes),
                          filled: true,
                          fillColor: Colors.grey.shade100,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Container(
                      decoration: BoxDecoration(
                        color: colorScheme.primary,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.add, color: Colors.white),
                        onPressed: addGoal,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _goals.isEmpty
                ? Center(
                    child: Text(
                      "No goals yet. Add one above!",
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 16,
                      ),
                    ),
                  )
                : ListView.separated(
                    padding: const EdgeInsets.all(20),
                    itemCount: _goals.length,
                    separatorBuilder: (_, _) => const SizedBox(height: 12),
                    itemBuilder: (context, i) {
                      final goal = _goals[i];
                      final bool isCompleted = goal['is_completed'] ?? false;
                      return _GoalRow(
                        label: goal['title'],
                        isCompleted: isCompleted,
                        onCheck: (bool? newValue) {
                          toggleGoal(goal['goal_id'].toString(), isCompleted);
                        },
                        onEdit: () {
                          TextEditingController editCtrl =
                              TextEditingController(text: goal['title']);
                          showDialog(
                            context: context,
                            builder: (ctx) => AlertDialog(
                              title: const Text('Edit Goal'),
                              content: TextField(
                                controller: editCtrl,
                                decoration: const InputDecoration(
                                  hintText: "Update your goal",
                                ),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(ctx),
                                  child: const Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    editGoal(
                                      goal['goal_id'].toString(),
                                      editCtrl.text,
                                    );
                                    Navigator.pop(ctx);
                                  },
                                  child: const Text('Save'),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

// REUSABLE WIDGET
class _GoalRow extends StatelessWidget {
  const _GoalRow({
    required this.label,
    required this.onCheck,
    required this.isCompleted,
    required this.onEdit, // <-- Added edit callback here
  });

  final String label;
  final bool isCompleted;
  final ValueChanged<bool?> onCheck;
  final VoidCallback onEdit;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isCompleted ? Colors.grey.shade200 : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isCompleted ? Colors.transparent : Colors.grey.shade300,
        ),
        boxShadow: isCompleted
            ? []
            : [
                const BoxShadow(
                  color: Colors.black12,
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        children: [
          Icon(
            Icons.star_rounded,
            color: isCompleted ? Colors.grey.shade400 : Colors.amber,
            size: 32,
          ),
          const SizedBox(width: 12),

          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 16,
                fontWeight: isCompleted ? FontWeight.normal : FontWeight.w600,
                color: isCompleted ? Colors.grey.shade500 : Colors.black87,
                decoration: isCompleted ? TextDecoration.lineThrough : null,
              ),
            ),
          ),

          // Edit Button (Pencil Icon)
          IconButton(
            icon: Icon(Icons.edit, color: Colors.grey.shade400, size: 20),
            onPressed: onEdit,
          ),

          Checkbox(
            value: isCompleted,
            onChanged: onCheck,
            activeColor: Theme.of(context).colorScheme.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ],
      ),
    );
  }
}
