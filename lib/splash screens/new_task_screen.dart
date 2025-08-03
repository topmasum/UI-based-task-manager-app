import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../ui/controllers/new_task_screen _controller.dart';
import '../widget/appbar.dart';
import '../widget/progress_indicator.dart';
import '../widget/screen_background.dart';
import '../widget/snackbar_message.dart';

class newtaskscreen extends StatelessWidget {
  newtaskscreen({super.key});
  static const String routeName = '/newtaskscreen';

  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final NewTaskController _controller = Get.find();
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
                  Text('New Task', style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _titleController,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      hintText: 'Title',
                    ),
                    validator: (String? value) =>
                    (value?.isEmpty ?? true) ? 'Please enter your title' : null,
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
                    validator: (String? value) =>
                    (value?.isEmpty ?? true) ? 'Please enter your description' : null,
                  ),
                  const SizedBox(height: 16),
                  Obx(() {
                    return _controller.isLoading.value
                        ? const progress_indicator()
                        : ElevatedButton(
                      onPressed: () => _submit(context),
                      child: const Icon(Icons.arrow_circle_right_outlined),
                    );
                  }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  void _submit(BuildContext context) async {
    if (_formKey.currentState?.validate() ?? false) {
      final success = await _controller.createNewTask(
        _titleController.text.trim(),
        _descriptionController.text.trim(),
      );

      if (success) {
        _titleController.clear();
        _descriptionController.clear();
        snackbar_message(context, 'Task added successfully');
        Navigator.pop(context, true);
      } else {
        snackbar_message(context, 'Failed to add task');
      }
    }
  }
}
