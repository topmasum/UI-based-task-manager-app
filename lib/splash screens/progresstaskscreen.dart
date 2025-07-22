import 'package:flutter/material.dart';

import '../data/Urls.dart';
import '../data/models/task_model.dart';
import '../data/service/network_caller.dart';
import '../widget/snackbar_message.dart';
import '../widget/task_card.dart';
class Progresstaskscreen extends StatefulWidget {
  const Progresstaskscreen({super.key});

  @override
  State<Progresstaskscreen> createState() => _ProgresstaskscreenState();
}

class _ProgresstaskscreenState extends State<Progresstaskscreen> {
  bool _newProgressInprogress=false;
  List<TaskModel> _newprogressList = [];
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
      _getNewProgress();
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
              visible: _newProgressInprogress==false,
              replacement: Center(child: CircularProgressIndicator()),
              child: ListView.builder(
                  itemCount: _newprogressList.length,
                  itemBuilder: (context,index){
                    return Taskcard(status: TaskStatus.progress, taskModel: _newprogressList[index],);
                  }),
            ))
          ],
        ),
      ),
    );

  }
  Future<void>_getNewProgress()async {
    _newProgressInprogress = true;
    setState(() {});
    NetworkResponse response = await Networkcaller.getRequest(
        url: Url.progressListUrl);
    if (response.isSuccess) {
      List<TaskModel> list = [];
      for (Map<String, dynamic>jsonData in response.body!['data']) {
        list.add(TaskModel.fromJson(jsonData));
      }
      _newprogressList = list;

    } else {
      snackbar_message(context, response.message!);
    }
    _newProgressInprogress=false;
    setState(() {});
  }
}
