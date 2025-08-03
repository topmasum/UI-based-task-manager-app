import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../ui/controllers/progressTaskList_controller.dart';
import '../widget/task_card.dart';

class Progresstaskscreen extends StatelessWidget {
  Progresstaskscreen({super.key});

  final ProgressTaskController _controller = Get.find();

  @override
  Widget build(BuildContext context) {
    // Load progress tasks on first build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.getProgressTasks();
    });

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Obx(() {
          if (_controller.inProgress.value) {
            return const Center(child: CircularProgressIndicator());
          }

          return ListView.builder(
            itemCount: _controller.progressList.length,
            itemBuilder: (context, index) {
              return TaskCard(
                taskType: TaskType.progress,
                taskModel: _controller.progressList[index],
                onStatusUpdate: _controller.getProgressTasks,
              );
            },
          );
        }),
      ),
    );
  }
}
