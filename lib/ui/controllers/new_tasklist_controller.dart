import 'package:get/get.dart';

import '../../data/Urls.dart';
import '../../data/models/task_model.dart';
import '../../data/service/network_caller.dart';

class TasklistController extends GetxController{
  bool _Inprogress = false;
  bool get Inprogress => _Inprogress;
  String? _errormessage;
  String? get errormessage => _errormessage!;
  List<TaskModel> _newtaskList = [];
  List<TaskModel> get newtaskList => _newtaskList;

  Future<bool>getNewTask()async {
    bool isSuccessful = false;
    _Inprogress = true;
    update();
    NetworkResponse response = await Networkcaller.getRequest(
        url: Url.taskListUrl);
    if (response.isSuccess) {
      List<TaskModel> list = [];
      for (Map<String, dynamic>jsonData in response.body!['data']) {
        list.add(TaskModel.fromJson(jsonData));
      }
      _newtaskList = list;
      _errormessage=null;

    } else {
      _errormessage = response.message!;
    }
    _Inprogress=false;
    update();
    return isSuccessful;

  }

}