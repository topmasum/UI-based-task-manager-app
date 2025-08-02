import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../ui/controllers/completed_task_controller.dart';
import '../widget/task_card.dart';

class Completedtask extends StatefulWidget {
  const Completedtask({super.key});

  @override
  State<Completedtask> createState() => _CompletedtaskState();
}

class _CompletedtaskState extends State<Completedtask> {
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<CompletedTaskController>().getNewCompleted();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          children: [
            SizedBox(height: 10),
            Expanded(
              child: GetBuilder<CompletedTaskController>(
                builder: (controller) {
                  return Visibility(
                    visible: controller.Inprogress == false,
                    replacement: Center(child: CircularProgressIndicator()),
                    child: ListView.builder(
                      itemCount: controller.newcompleteList.length,
                      itemBuilder: (context, index) {
                        return TaskCard(
                          taskType: TaskType.completed,
                          taskModel: controller.newcompleteList[index],
                          onStatusUpdate: controller.getNewCompleted,
                        );
                      },
                    ),
                  );
                }
              ),
            ),
          ],
        ),
      ),
    );
  }
}
