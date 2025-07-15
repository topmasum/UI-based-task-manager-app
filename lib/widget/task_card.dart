import 'package:flutter/material.dart';

enum TaskStatus { tNew, progress, completed, canceled }

class Taskcard extends StatelessWidget {
  const Taskcard({
    super.key,
    required this.status,
  });

  final TaskStatus status;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Title text', style: Theme.of(context).textTheme.titleMedium),
            Text('Description', style: TextStyle(color: Colors.grey)),
            Text('Date: 15/07/2025'),
            const SizedBox(height: 8),
            Row(
              children: [
                Chip(
                  label: Text(
                    _taskType(),
                    style: TextStyle(color: Colors.white),
                  ),
                  backgroundColor: _taskColor(),
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: BorderSide.none,
                  ),
                ),
                Spacer(),
                IconButton(onPressed: () {}, icon: Icon(Icons.edit)),
                IconButton(onPressed: () {}, icon: Icon(Icons.delete)),
              ],
            )
          ],
        ),
      ),
    );
  }

  Color _taskColor() {
    switch (status) {
      case TaskStatus.tNew:
        return Colors.blue;
      case TaskStatus.progress:
        return Colors.purple;
      case TaskStatus.completed:
        return Colors.green;
      case TaskStatus.canceled:
        return Colors.red;
    }
  }

  String _taskType() {
    switch (status) {
      case TaskStatus.tNew:
        return 'New';
      case TaskStatus.progress:
        return 'Progress';
      case TaskStatus.completed:
        return 'Completed';
      case TaskStatus.canceled:
        return 'Canceled';
    }
  }
}
