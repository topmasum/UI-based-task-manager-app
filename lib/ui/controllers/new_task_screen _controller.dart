import 'package:get/get.dart';
import '../../data/Urls.dart';
import '../../data/service/network_caller.dart';

class NewTaskController extends GetxController {
  RxBool isLoading = false.obs;

  Future<bool> createNewTask(String title, String description) async {
    isLoading.value = true;

    final response = await Networkcaller.postRequest(
      url: Url.taskUrl,
      body: {
        'title': title,
        'description': description,
        'status': 'New',
      },
    );
    isLoading.value = false;
    return response.isSuccess;
  }
}
