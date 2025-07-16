import 'package:flutter/material.dart';
import 'package:task_manager/widget/appbar.dart';
import 'package:task_manager/widget/screen_background.dart';
class newtaskscreen extends StatefulWidget {
  const newtaskscreen({super.key});
static const routeName='/newtaskscreen';
  @override
  State<newtaskscreen> createState() => _newtaskscreenState();
}

class _newtaskscreenState extends State<newtaskscreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
                SizedBox(height: 45,),
                Text('New Task', style: Theme
                    .of(context)
                    .textTheme
                    .titleLarge,),
                SizedBox(height: 16,),
                TextFormField(
                  controller: _titleController,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    hintText: 'Title',
                  ),
                  validator: (String ? value) {
                    if (value?.isEmpty ?? true) {
                      return 'Please enter your title';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16,),
                TextFormField(
                  controller: _descriptionController,
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    hintText: 'Description',
                  ),
                  maxLines: 5,
                  validator: (String ? value) {
                    if (value?.isEmpty ?? true) {
                      return 'Please enter your description';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16,),
                ElevatedButton(onPressed: _ontapsubmitbutton,
                    child: Icon(Icons.arrow_circle_right_outlined))
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _ontapsubmitbutton() {
    if (_formKey.currentState!.validate()) {

    }
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
}

