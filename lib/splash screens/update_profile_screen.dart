import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task_manager/widget/screen_background.dart';

import '../widget/appbar.dart';
class update_profile_screen extends StatefulWidget {
  const update_profile_screen({super.key});
  static const String routeName = '/update';

  @override
  State<update_profile_screen> createState() => _update_profile_screenState();
}

class _update_profile_screenState extends State<update_profile_screen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _lastnameController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ImagePicker _imagePicker=ImagePicker();
  XFile? _selectedImage;

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
                  SizedBox(height: 80,),
                  Text('Update Profile',
                      style: Theme.of(context).textTheme.titleLarge),
                  SizedBox(height: 24,),
                  Container(
                    height: 50,
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                    ),
                    child: Row(
                      children: [
                        image_picker(),
                        SizedBox(width: 10,),
                        Text(_selectedImage == null ? 'Select image': _selectedImage !.name,
                        maxLines: 1,
                        style: TextStyle(
                          overflow: TextOverflow.ellipsis
                        ),),
                      ]
                    ),
                  ),
                  SizedBox(height: 10,),
                  TextFormField(
                      controller: _emailController,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        hintText: 'Email',
                      ),
                      validator: (String ? value){
                        String email=value ?? '';
                        if(EmailValidator.validate(email)==false){
                          return 'Please enter your email';
                        }
                        return null;
                      }
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                      controller: _nameController,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        hintText: 'First name',
                      ),
                      validator: (String ? value){
                        if(value?.trim().isEmpty ?? true){
                          return 'Please enter your first name';
                        }
                        return null;
                      }
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                      controller: _lastnameController,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        hintText: 'Last name',
                      ),
                      validator: (String ? value){
                        if(value?.trim().isEmpty ?? true){
                          return 'Please enter your last name';
                        }
                        return null;
                      }
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                      controller: _mobileController,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        hintText: 'Mobile',
                      ),
                      validator: (String ? value){
                        if(value?.trim().isEmpty ?? true){
                          return 'Please enter mobile number';
                        }
                        return null;
                      }
                  ),
                  SizedBox(height: 10,),
                  TextFormField(
                      controller: _passwordController,
                      textInputAction: TextInputAction.done,
                      obscureText: true,
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        hintText: 'Password',
                      ),
                      validator: (String ? value){
                        if((value?.length ?? 0)<=6){
                          return 'Please enter your Password more then 6 character';
                        }
                        return null;
                      }
                  ),
                  SizedBox(height: 16,),
                  ElevatedButton(
                      onPressed: _onTapSignupButton,
                      child: Icon(Icons.arrow_circle_right_outlined)),
                  SizedBox(height: 20,),

                ],
              ),
            ),
          ),
        ),
      ),

    );
  }

  Widget image_picker() {
    return GestureDetector(
      onTap: _ontapimagepicker,
      child: Container(
                          height: 50,
                          width: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(8),
                              bottomLeft: Radius.circular(8),
                            ),
                            color: Colors.grey,
                          ),
                          alignment: Alignment.center,
                          child: Text('Photo',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700
                          )
                          ),
                        ),
      
    );
  }
  Future<void> _ontapimagepicker() async {
    final XFile? image = await _imagePicker.pickImage(source: ImageSource.gallery);
    if(image != null){
      _selectedImage= image;
      setState(() {});
    }
  }
  void _onTapSignupButton(){
  }
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    _mobileController.dispose();
    _lastnameController.dispose();
    super.dispose();
  }


}

