import 'package:get/get.dart';
import 'package:task_manager/ui/controllers/Signin_controller.dart';
import 'package:task_manager/ui/controllers/canceled_tasklist_controller.dart';
import 'package:task_manager/ui/controllers/completed_task_controller.dart';
import 'package:task_manager/ui/controllers/new_tasklist_controller.dart';
import 'package:task_manager/ui/controllers/progressTaskList_controller.dart';
import 'package:task_manager/ui/controllers/signup_controller.dart';
import 'package:task_manager/ui/controllers/tasklist_count_controller.dart';
import 'package:task_manager/ui/controllers/update_profile_controller.dart';

class ControllerBinder extends Bindings{
  @override
  void dependencies() {
    Get.put(Signin_controller());
    Get.put(TasklistController());
    Get.put(TaskListCount());
    Get.put(CanceledTaskListController());
    Get.put(CompletedTaskController());
    Get.put(SignupController());
    Get.put(ProfileUpdateController());
    Get.put(ProgressTaskController());



  }

}