import 'package:flutter/material.dart';
import 'package:task_manager/data/service/network_caller.dart';
import 'package:task_manager/widget/appbar.dart';
import 'package:task_manager/widget/screen_background.dart';

import '../data/Urls.dart';
import '../widget/progress_indicator.dart';
import '../widget/snackbar_message.dart';

class newtaskscreen extends StatefulWidget {
  const newtaskscreen({super.key});
  static const routeName = '/newtaskscreen';
  @override
  State<newtaskscreen> createState() => _newtaskscreenState();
}

class _newtaskscreenState extends State<newtaskscreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _addNewTaskInprogress = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TMappbar_widget(),
      body: screen_background(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 45),
                Text('New Task', style: Theme
                    .of(context)
                    .textTheme
                    .titleLarge),
                SizedBox(height: 16),
                TextFormField(
                  controller: _titleController,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    hintText: 'Title',
                  ),
                  validator: (String? value) {
                    if (value?.isEmpty ?? true) {
                      return 'Please enter your title';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _descriptionController,
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    hintText: 'Description',
                  ),
                  maxLines: 5,
                  validator: (String? value) {
                    if (value?.isEmpty ?? true) {
                      return 'Please enter your description';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                Visibility(
                  visible: _addNewTaskInprogress == false,
                  replacement: progress_indicator(),
                  child: ElevatedButton(
                    onPressed: _ontapsubmitbutton,
                    child: Icon(Icons.arrow_circle_right_outlined),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _ontapsubmitbutton() {
    if (_formKey.currentState!.validate()) {
      _addNewTask();
    }
    //Navigator.pop(context);
  }
  Future<void> _addNewTask() async {
    Map<String, String> _reqbody() {
      return {
        'title': _titleController.text.trim(),
        'description': _descriptionController.text.trim(),
        'status': 'New',
      };
    }
    setState(() {
      _addNewTaskInprogress = true;
    });

    NetworkResponse response = await Networkcaller.postRequest(
      url: Url.taskUrl,
      body: _reqbody(),
    );

    setState(() {
      _addNewTaskInprogress = false;
    });

    if (response.isSuccess) {
      _titleController.clear();
      _descriptionController.clear();
      snackbar_message(context, 'Task added successfully');
      _addNewTaskInprogress=false;

    } else {
      snackbar_message(context, response.message!);
    }

    @override
    void dispose() {
      _titleController.dispose();
      _descriptionController.dispose();
      super.dispose();
    }
  }
}
