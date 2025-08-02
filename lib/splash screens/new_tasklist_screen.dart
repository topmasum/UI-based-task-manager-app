import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../ui/controllers/new_tasklist_controller.dart';
import '../ui/controllers/tasklist_count_controller.dart';
import '../widget/task_card.dart';
import '../widget/task_count_sum_card.dart';
import 'new_task_screen.dart';

class NewTasklistScreen extends StatefulWidget {
  const NewTasklistScreen({super.key});

  @override
  State<NewTasklistScreen> createState() => _NewTasklistScreenState();
}

class _NewTasklistScreenState extends State<NewTasklistScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<TasklistController>().getNewTask();
      Get.find<TaskListCount>().getNewTaskCountList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            SizedBox(height: 16),
            SizedBox(
              height: 100,
              child: GetBuilder<TaskListCount>(
                builder: (controller) {
                  return Visibility(
                    visible: controller.Inprogress == false,
                    replacement: Center(child: CircularProgressIndicator()),
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: controller.newTaskStatusList.length,
                      itemBuilder: (context, index) {
                        return task_count_sum_card(
                          title: controller.newTaskStatusList[index].id,
                          count: controller.newTaskStatusList[index].count,
                        );
                      },
                      separatorBuilder:
                          (context, index) => const SizedBox(width: 4),
                    ),
                  );
                }
              ),
            ),
            Expanded(
              child: GetBuilder<TasklistController>(
                builder: (controller) {
                  return Visibility(
                    visible: controller.Inprogress == false,
                    replacement: Center(child: CircularProgressIndicator()),
                    child: ListView.builder(
                      itemCount: controller.newtaskList.length,
                      itemBuilder: (context, index) {
                        return TaskCard(
                          taskType: TaskType.tNew,
                          taskModel: controller.newtaskList[index],
                          onStatusUpdate: _refreshAllData,
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
      floatingActionButton: FloatingActionButton(
        onPressed: _ontapaddnewtask,
        child: Icon(Icons.add),
      ),
    );
  }

  Future<void> _ontapaddnewtask() async {
    final result = await Navigator.pushNamed(
      context,
      newtaskscreen.routeName,
    );
    if (result == true) {
      await _refreshAllData();
    }
  }

  Future<void> _refreshAllData() async {
    Get.find<TasklistController>().getNewTask();
    Get.find<TaskListCount>().getNewTaskCountList();
  }
}
