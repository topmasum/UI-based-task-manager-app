import 'package:flutter/material.dart';

import '../data/Urls.dart';
import '../data/models/task_model.dart';
import '../data/service/network_caller.dart';
import '../widget/snackbar_message.dart';
import '../widget/task_card.dart';
class CanceledTaskScreen extends StatefulWidget {
  const CanceledTaskScreen({super.key});

  @override
  State<CanceledTaskScreen> createState() => _CanceledTaskScreenState();
}

class _CanceledTaskScreenState extends State<CanceledTaskScreen> {
  bool _newCanceledInprogress=false;
  List<TaskModel>_newcanceledList = [];
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
      _getNewCanceled();
    });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal:8),
        child: Column(
          children: [
            SizedBox(height: 10,),
            Expanded(child: Visibility(
              visible: _newCanceledInprogress==false,
              replacement: Center(child: CircularProgressIndicator()),
              child: ListView.builder(
                  itemCount: _newcanceledList.length,
                  itemBuilder: (context,index){
                    return Taskcard(status: TaskStatus.canceled, taskModel: _newcanceledList[index],);
                  }),
            ))
          ],
        ),
      ),
    );

  }
  Future<void>_getNewCanceled()async {
    _newCanceledInprogress = true;
    setState(() {});
    NetworkResponse response = await Networkcaller.getRequest(
        url: Url.canceledListUrl);
    if (response.isSuccess) {
      List<TaskModel> list = [];
      for (Map<String, dynamic>jsonData in response.body!['data']) {
        list.add(TaskModel.fromJson(jsonData));
      }
      _newcanceledList = list;

    } else {
      snackbar_message(context, response.message!);
    }
    _newCanceledInprogress=false;
    setState(() {});
  }
}
