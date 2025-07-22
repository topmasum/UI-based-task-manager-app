import 'package:flutter/material.dart';

import '../data/Urls.dart';
import '../data/models/task_model.dart';
import '../data/service/network_caller.dart';
import '../widget/snackbar_message.dart';
import '../widget/task_card.dart';
class Completedtask extends StatefulWidget {
  const Completedtask({super.key});

  @override
  State<Completedtask> createState() => _CompletedtaskState();
}

class _CompletedtaskState extends State<Completedtask> {
  bool _newCompletedInprogress=false;
  List<TaskModel>_newcompleteList = [];
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
      _getNewCompleted();
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
              visible: _newCompletedInprogress==false,
              replacement: Center(child: CircularProgressIndicator()),
              child: ListView.builder(
                  itemCount: _newcompleteList.length,
                  itemBuilder: (context,index){
                    return Taskcard(status: TaskStatus.completed, taskModel: _newcompleteList[index],);
                  }),
            ))
          ],
        ),
      ),
    );

  }
  Future<void>_getNewCompleted()async {
    _newCompletedInprogress = true;
    setState(() {});
    NetworkResponse response = await Networkcaller.getRequest(
        url: Url.completedListUrl);
    if (response.isSuccess) {
      List<TaskModel> list = [];
      for (Map<String, dynamic>jsonData in response.body!['data']) {
        list.add(TaskModel.fromJson(jsonData));
      }
      _newcompleteList = list;

    } else {
      snackbar_message(context, response.message!);
    }
    _newCompletedInprogress=false;
    setState(() {});
  }
}
