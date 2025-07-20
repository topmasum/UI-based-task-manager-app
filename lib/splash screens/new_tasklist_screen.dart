import 'package:flutter/material.dart';
import 'package:task_manager/data/service/network_caller.dart';
import 'package:task_manager/widget/snackbar_message.dart';

import '../data/Urls.dart';
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
  List<TaskModel> _newtaskList = [];
  @override
  void initState() {
    super.initState();
    _getNewTask();
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
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return task_count_sum_card(
                    title: 'Progress',
                    count: 12,
                  );
                },
                separatorBuilder: (context, index) => const SizedBox(width: 4),
                itemCount: 4,
              ),
            ),
            Expanded(child: Visibility(
              visible: _newTaskInprogress==false,
              replacement: Center(child: CircularProgressIndicator()),
              child: ListView.builder(
                  itemCount: _newtaskList.length,
                  itemBuilder: (context,index){
                    return Taskcard(status: TaskStatus.tNew, taskModel: _newtaskList[index],);
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
    snackbar_message(context, response.message!);
  }
  _newTaskInprogress=false;
  setState(() {});
}
  void _ontapaddnewtask(){
    Navigator.pushNamed(context, newtaskscreen.routeName);

  }
}




