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
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 45),
                  Text(
                      'New Task',
                      style: Theme.of(context).textTheme.titleLarge
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _titleController,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
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
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _descriptionController,
                    textInputAction: TextInputAction.done,
                    decoration: const InputDecoration(
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
                  const SizedBox(height: 16),
                  Visibility(
                    visible: !_addNewTaskInprogress,
                    replacement: const progress_indicator(),
                    child: ElevatedButton(
                      onPressed: _ontapsubmitbutton,
                      child: const Icon(Icons.arrow_circle_right_outlined),
                    ),
                  ),
                ],
              ),
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
  }

  Future<void> _addNewTask() async {
    setState(() => _addNewTaskInprogress = true);

    try {
      final response = await Networkcaller.postRequest(
        url: Url.taskUrl,
        body: {
          'title': _titleController.text.trim(),
          'description': _descriptionController.text.trim(),
          'status': 'New',
        },
      );

      if (response.isSuccess) {
        _titleController.clear();
        _descriptionController.clear();
        if (mounted) {
          snackbar_message(context, 'Task added successfully');
          Navigator.pop(context, true); // Return success
        }
      } else {
        if (mounted) {
          snackbar_message(context, response.message ?? 'Failed to add task');
        }
      }
    } catch (e) {
      if (mounted) {
        snackbar_message(context, 'An error occurred: $e');
      }
    } finally {
      if (mounted) {
        setState(() => _addNewTaskInprogress = false);
      }
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
}