import 'package:get/get.dart';

import '../../data/Urls.dart';
import '../../data/models/task_model.dart';
import '../../data/service/network_caller.dart';

class CanceledTaskListController extends GetxController{
  bool _Inprogress = false;
  bool get Inprogress => _Inprogress;
  String? _errormessage;
  String? get errormessage => _errormessage!;
  List<TaskModel> _newcanceledList = [];
  List<TaskModel> get newcanceledList => _newcanceledList;

  Future<bool>getNewCanceled()async {
    bool isSuccessful = false;
    _Inprogress = true;
    update();
    NetworkResponse response = await Networkcaller.getRequest(
        url: Url.canceledListUrl);
    if (response.isSuccess) {
      List<TaskModel> list = [];
      for (Map<String, dynamic>jsonData in response.body!['data']) {
        list.add(TaskModel.fromJson(jsonData));
      }
      _newcanceledList = list;
      _errormessage=null;
    } else {
      _errormessage=response.message!;
    }
    _Inprogress=false;
    update();
    return isSuccessful;
  }
}