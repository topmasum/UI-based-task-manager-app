import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../ui/controllers/canceled_tasklist_controller.dart';
import '../widget/task_card.dart';

class CanceledTaskScreen extends StatefulWidget {
  const CanceledTaskScreen({super.key});

  @override
  State<CanceledTaskScreen> createState() => _CanceledTaskScreenState();
}

class _CanceledTaskScreenState extends State<CanceledTaskScreen> {
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<CanceledTaskListController>().getNewCanceled();
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
              child: GetBuilder<CanceledTaskListController>(
                builder: (controller) {
                  return Visibility(
                    visible: controller.Inprogress == false,
                    replacement: Center(child: CircularProgressIndicator()),
                    child: ListView.builder(
                      itemCount: controller.newcanceledList.length,
                      itemBuilder: (context, index) {
                        return TaskCard(
                          taskType: TaskType.cancelled,
                          taskModel: controller.newcanceledList[index],
                          onStatusUpdate: controller.getNewCanceled,
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
