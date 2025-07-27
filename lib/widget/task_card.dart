import 'package:flutter/material.dart';
import 'package:task_manager/data/models/task_model.dart';
import 'package:task_manager/data/service/network_caller.dart';
import 'package:task_manager/data/Urls.dart';
import 'package:task_manager/widget/snackbar_message.dart';


enum TaskType { tNew, progress, completed, cancelled }

class TaskCard extends StatefulWidget {
  const TaskCard({
    super.key,
    required this.taskType,
    required this.taskModel,
    required this.onStatusUpdate,
  });

  final TaskType taskType;
  final TaskModel taskModel;
  final VoidCallback onStatusUpdate;

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  bool _updateTaskStatusInProgress = false;
  bool _deleteTaskInProgress = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.taskModel.title,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(
              widget.taskModel.description,
              style: TextStyle(color: Colors.black54),
            ),
            Text('Date: ${widget.taskModel.createdDate}'),
            const SizedBox(height: 8),
            Row(
              children: [
                Chip(
                  label: Text(
                    _getTaskTypeName(),
                    style: TextStyle(color: Colors.white),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  backgroundColor: _getTaskChipColor(),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: BorderSide.none,
                  ),
                ),
                Spacer(),
                IconButton(onPressed: () {
                  _showDeleteConfirmationDialog();
                }, icon: Icon(Icons.delete)),
                Visibility(
                  visible: _updateTaskStatusInProgress == false,
                  replacement: CircularProgressIndicator(),
                  child: IconButton(
                    onPressed: () {
                      _showEditTaskStatusDialog();
                    },
                    icon: Icon(Icons.edit),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Color _getTaskChipColor() {
    switch (widget.taskType) {
      case TaskType.tNew:
        return Colors.blue;
      case TaskType.progress:
        return Colors.purple;
      case TaskType.completed:
        return Colors.green;
      case TaskType.cancelled:
        return Colors.red;
    }
  }

  String _getTaskTypeName() {
    switch (widget.taskType) {
      case TaskType.tNew:
        return 'New';
      case TaskType.progress:
        return 'Progress';
      case TaskType.completed:
        return 'Completed';
      case TaskType.cancelled:
        return 'Cancelled';
    }
  }

  void _showEditTaskStatusDialog() {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: Text('Change Status'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text('New'),
                trailing: _getTaskStatusTrailing(TaskType.tNew),
                onTap: () {
                  if (widget.taskType == TaskType.tNew) {
                    return;
                  }
                  _updateTaskStatus('New');
                },
              ),
              ListTile(
                title: Text('In Progress'),
                trailing: _getTaskStatusTrailing(TaskType.progress),
                onTap: () {
                  if (widget.taskType == TaskType.progress) {
                    return;
                  }
                  _updateTaskStatus('Progress');
                },
              ),
              ListTile(
                title: Text('Completed'),
                trailing: _getTaskStatusTrailing(TaskType.completed),
                onTap: () {
                  if (widget.taskType == TaskType.completed) {
                    return;
                  }
                  _updateTaskStatus('Completed');
                },
              ),
              ListTile(
                title: Text('Cancelled'),
                trailing: _getTaskStatusTrailing(TaskType.cancelled),
                onTap: () {
                  if (widget.taskType == TaskType.cancelled) {
                    return;
                  }
                  _updateTaskStatus('Cancelled');
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget? _getTaskStatusTrailing(TaskType type) {
    return widget.taskType == type ? Icon(Icons.check) : null;
  }

  // TODO: Complete this
  // void _onTapTaskStatus(TaskType type) {
  //   if (type == widget.taskType) {
  //     return;
  //   }
  //
  // }
  Future<void> _deleteTask() async {
    Navigator.pop(context);
    _deleteTaskInProgress = true;
    if (mounted) {
      setState(() {});
    }
    NetworkResponse response = await Networkcaller.getRequest(
      url: Url.deleteTask(widget.taskModel.id),
    );
    _deleteTaskInProgress = false;
    if (mounted) {
      setState(() {});
    }
    if (response.isSuccess) {
      widget.onStatusUpdate();
    } else {
      if (mounted) {
        snackbar_message(context, response.message!);
      }
    }
  }
  void _showDeleteConfirmationDialog() {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: Text('Delete Task'),
          content: Text('Are you sure you want to delete this task?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx); // Dismiss dialog
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: _deleteTask,
              child: _deleteTaskInProgress
                  ? SizedBox(
                height: 16,
                width: 16,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
                  : Text('Delete'),
            ),
          ],
        );
      },
    );
  }


  Future<void> _updateTaskStatus(String status) async {
    Navigator.pop(context);
    _updateTaskStatusInProgress = true;
    if (mounted) {
      setState(() {});
    }

    NetworkResponse response = await Networkcaller.getRequest(
      url: Url.updateTaskStatusUrl(widget.taskModel.id, status),
    );

    _updateTaskStatusInProgress = false;
    if (mounted) {
      setState(() {});
    }

    if (response.isSuccess) {
      widget.onStatusUpdate();
    } else {
      if (mounted) {
        snackbar_message(context, response.message!);
      }
    }
  }
}