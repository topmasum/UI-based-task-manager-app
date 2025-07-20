import 'package:flutter/material.dart';
import 'package:task_manager/data/models/task_model.dart';

enum TaskStatus { tNew, progress, completed, canceled }

class Taskcard extends StatelessWidget {
  const Taskcard({
    super.key,
    required this.status, required this.taskModel,
  });

  final TaskStatus status;
  final TaskModel taskModel;

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
            Text(taskModel.title, style: Theme.of(context).textTheme.titleMedium),
            Text(taskModel.description, style: TextStyle(color: Colors.grey)),
            Text('Date:${taskModel.createdDate}', style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 8),
            Row(
              children: [
                Chip(
                  label: Text(
                    taskModel.status,
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

}
