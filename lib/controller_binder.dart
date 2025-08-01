import 'package:get/get.dart';
import 'package:task_manager/ui/controllers/Signin_controller.dart';
import 'package:task_manager/ui/controllers/new_tasklist_controller.dart';

class ControllerBinder extends Bindings{
  @override
  void dependencies() {
    Get.put(Signin_controller());
    Get.put(TasklistController());
  }

}