import 'package:flutter/material.dart';
import 'taskspage.dart';

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
                  color: Color.fromARGB(255, 246, 250, 255),
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
                  _navigateToTasksPage();
                },
                style: OutlinedButton.styleFrom(
                  foregroundColor: const Color.fromARGB(
                    255,
                    249,
                    251,
                    255,
                  ),
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
                backgroundColor: const Color.fromARGB(255, 49, 131, 238),
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

  void _navigateToTasksPage() async {
    final updatedTasks = await Navigator.push<List<Map<String, dynamic>>>(
      context,
      MaterialPageRoute(
        builder: (context) => TasksPage(
          tasks: tasks,
          onTasksUpdated: (updatedTasks) 
          {
              },
        ),
      ),
    );

      if (updatedTasks != null) {
      setState(() {
        tasks = updatedTasks;
      });
      }
  }

  @override
  void dispose() {
    _taskController.dispose();
    super.dispose();
  }
}
