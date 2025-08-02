import 'package:get/get.dart';

import '../../data/Urls.dart';
import '../../data/models/task_count_model.dart';
import '../../data/service/network_caller.dart';

class TaskListCount extends GetxController{
  bool _Inprogress = false;
  bool get Inprogress => _Inprogress;
  String? _errormessage;
  String? get errormessage => _errormessage!;
  List<TaskCountModel> _newTaskStatusList = [];
  List<TaskCountModel> get newTaskStatusList => _newTaskStatusList;

  Future<bool> getNewTaskCountList() async {
    bool isSuccessful = false;
     _Inprogress = true;
    update();
    NetworkResponse response = await Networkcaller.getRequest(
      url: Url.taskstatuscountUrl,
    );
    if (response.isSuccess) {
      List<TaskCountModel> list = [];
      for (Map<String, dynamic> jsonData in response.body!['data']) {
        list.add(TaskCountModel.fromJson(jsonData));
      }
      _newTaskStatusList = list;
      _errormessage=null;

    } else {
      _errormessage = response.message!;
    }
    _Inprogress = false;
    update();
    return isSuccessful;

  }
}
