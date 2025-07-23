import 'package:flutter/material.dart';
import 'package:task_manager/data/service/network_caller.dart';
import 'package:task_manager/widget/snackbar_message.dart';

import '../data/Urls.dart';
import '../data/models/task_count_model.dart';
import '../data/models/task_model.dart';
import '../widget/task_card.dart';
import '../widget/task_count_sum_card.dart';
import 'new_task_screen.dart';

class NewTasklistScreen extends StatefulWidget {
  const NewTasklistScreen({super.key});

  @override
  State<NewTasklistScreen> createState() => _NewTasklistScreenState();
}

class _NewTasklistScreenState extends State<NewTasklistScreen> {

  bool _newTaskInprogress=false;
  bool _newTaskStatusInprogress=false;
  List<TaskModel> _newtaskList = [];
  List<TaskCountModel> _newTaskStatusList = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
      _getNewTask();
      _getNewTaskCountList();

    }) ;


  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal:16),
        child: Column(
          children: [
            SizedBox(height: 16,),
            SizedBox(
              height: 100,
              child: Visibility(
                visible: _newTaskStatusInprogress==false,
                replacement: Center(child: CircularProgressIndicator()),
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: _newTaskStatusList.length,
                  itemBuilder: (context, index) {
                    return task_count_sum_card(
                      title: _newTaskStatusList[index].id,
                      count: _newTaskStatusList[index].count,
                    );
                  },
                  separatorBuilder: (context, index) => const SizedBox(width: 4),
                ),
              ),
            ),
            Expanded(child: Visibility(
              visible: _newTaskInprogress==false,
              replacement: Center(child: CircularProgressIndicator()),
              child: ListView.builder(
                  itemCount: _newtaskList.length,
                  itemBuilder: (context,index){
                    return TaskCard(taskType: TaskType.tNew, taskModel: _newtaskList[index],
                      onStatusUpdate:
                      _getNewTask,
                    );
                  }),
            ))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _ontapaddnewtask,
        child: Icon(Icons.add),
      ),
    );

  }
  Future<void>_getNewTaskCountList()async {
    _newTaskStatusInprogress = true;
    setState(() {});
    NetworkResponse response = await Networkcaller.getRequest(
        url: Url.taskstatuscountUrl);
    if (response.isSuccess) {
      List<TaskCountModel> list = [];
      for (Map<String, dynamic>jsonData in response.body!['data']) {
        list.add(TaskCountModel.fromJson(jsonData));
      }
      _newTaskStatusList = list;

    } else {
      if(mounted){
        snackbar_message(context, response.message!);
      }
    }
    _newTaskStatusInprogress=false;
    if(mounted){
      setState(() {});
    }
  }
Future<void>_getNewTask()async {
  _newTaskInprogress = true;
  setState(() {});
  NetworkResponse response = await Networkcaller.getRequest(
      url: Url.taskListUrl);
  if (response.isSuccess) {
    List<TaskModel> list = [];
    for (Map<String, dynamic>jsonData in response.body!['data']) {
      list.add(TaskModel.fromJson(jsonData));
    }
    _newtaskList = list;

  } else {
    if(mounted){
      snackbar_message(context, response.message!);
    }
  }
  _newTaskInprogress=false;
  if(mounted){
    setState(() {});
  }
}
  void _ontapaddnewtask(){
    Navigator.pushNamed(context, newtaskscreen.routeName);

  }
}




