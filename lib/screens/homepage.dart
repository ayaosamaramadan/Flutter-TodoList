import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final Gradient backgroundGradient = const LinearGradient(
    colors: [
      Color(0xFF56CCF2),
      Color.fromARGB(255, 84, 117, 160),
      Color.fromARGB(255, 8, 13, 90),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  final TextEditingController _taskController = TextEditingController();
  List<Map<String, dynamic>> tasks = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Todo App',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
            fontSize: 22,
          ),
        ),
        centerTitle: false,
        elevation: 10,
        backgroundColor: const Color(0xFF2F80ED),
        shadowColor: Colors.lightBlueAccent.withOpacity(0.5),
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(icon: const Icon(Icons.settings), onPressed: () {}),
        ],
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(gradient: backgroundGradient),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Welcome to the Todo App',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2F80ED),
                  shadows: [
                    Shadow(
                      blurRadius: 8,
                      color: Colors.lightBlueAccent,
                      offset: Offset(2, 2),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  _addTask();
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 28,
                    vertical: 14,
                  ),
                  textStyle: const TextStyle(fontSize: 20),
                  backgroundColor: const Color(0xFF2F80ED),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 8,
                  shadowColor: Colors.lightBlueAccent,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(Icons.add, color: Colors.white, size: 26),
                    SizedBox(width: 10),
                    Text(
                      'Add New Task',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              OutlinedButton(
                onPressed: () {
                  _printAllTasks(); // طباعة المهام في الكونسول
                },
                style: OutlinedButton.styleFrom(
                  foregroundColor: const Color.fromARGB(
                    255,
                    249,
                    251,
                    255,
                  ), // Blue
                  side: const BorderSide(
                    color: Color.fromARGB(255, 255, 255, 255),
                    width: 2,
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 28,
                    vertical: 14,
                  ),
                  textStyle: const TextStyle(fontSize: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: const Text(
                  'View Tasks',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _addTask() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Add New Task',
            style: TextStyle(
              color: Color(0xFF2F80ED),
              fontWeight: FontWeight.bold,
            ),
          ),
          content: TextField(
            controller: _taskController,
            decoration: const InputDecoration(
              hintText: 'Enter your task here...',
              border: OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xFF2F80ED), width: 2),
              ),
            ),
            maxLines: 3,
          ),
          actions: [
            TextButton(
              onPressed: () {
                _taskController.clear();
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (_taskController.text.trim().isNotEmpty) {
                  setState(() {
                    tasks.add({
                      'id': DateTime.now().millisecondsSinceEpoch,
                      'title': _taskController.text.trim(),
                      'isCompleted': false,
                      'createdAt': DateTime.now(),
                    });
                  });

                  // طباعة جميع المهام في الكونسول
                  print('📝 Total tasks: ${tasks.length}');
                  print('📋 All tasks:');
                  for (int i = 0; i < tasks.length; i++) {
                    print(
                      '${i + 1}. ${tasks[i]['title']} - Completed: ${tasks[i]['isCompleted']}',
                    );
                  }
                  print('-------------------');

                  _taskController.clear();
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Task added successfully!'),
                      backgroundColor: Color(0xFF2F80ED),
                      duration: Duration(seconds: 2),
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2F80ED),
              ),
              child: const Text(
                'Add Task',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }

  // دالة لطباعة جميع المهام
  void _printAllTasks() {
    print('\n🔍 === TASKS DEBUG INFO ===');
    print('📊 Total number of tasks: ${tasks.length}');

    if (tasks.isEmpty) {
      print('📭 No tasks available');
    } else {
      print('📋 Tasks list:');
      for (int i = 0; i < tasks.length; i++) {
        var task = tasks[i];
        String status = task['isCompleted'] ? '✅ Completed' : '⏳ Pending';
        print('${i + 1}. "${task['title']}" - $status');
        print('   ID: ${task['id']}');
        print('   Created: ${task['createdAt']}');
        print('   --------');
      }
    }
    print('🔍 === END DEBUG INFO ===\n');
  }

  @override
  void dispose() {
    _taskController.dispose();
    super.dispose();
  }
}
