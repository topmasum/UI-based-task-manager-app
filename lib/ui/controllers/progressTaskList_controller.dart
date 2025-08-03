import 'package:get/get.dart';
import '../../data/Urls.dart';
import '../../data/models/task_model.dart';
import '../../data/service/network_caller.dart';

class ProgressTaskController extends GetxController {
  RxBool inProgress = false.obs;
  RxList<TaskModel> progressList = <TaskModel>[].obs;

  Future<void> getProgressTasks() async {
    inProgress.value = true;
    NetworkResponse response = await Networkcaller.getRequest(url: Url.progressListUrl);
    if (response.isSuccess) {
      List<TaskModel> tempList = [];
      for (Map<String, dynamic> json in response.body!['data']) {
        tempList.add(TaskModel.fromJson(json));
      }
      progressList.value = tempList;
    } else {
      Get.snackbar("Error", response.message ?? "Something went wrong");
    }
    inProgress.value = false;
  }
}
