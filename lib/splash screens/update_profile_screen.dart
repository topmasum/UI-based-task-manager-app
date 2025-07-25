import 'dart:convert';
import 'dart:typed_data'; // For Uint8List
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task_manager/ui/controllers/auth_controller.dart';
import 'package:task_manager/widget/screen_background.dart';
import 'package:task_manager/widget/snackbar_message.dart';

import '../data/Urls.dart';
import '../data/models/user_model.dart';
import '../data/service/network_caller.dart';
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
  final ImagePicker _imagePicker = ImagePicker();
  XFile? _selectedImage;
  bool updateImageInProgress = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _emailController.text = authcontroller.userModel?.email ?? '';
    _nameController.text = authcontroller.userModel?.firstName ?? '';
    _lastnameController.text = authcontroller.userModel?.lastName ?? '';
    _mobileController.text = authcontroller.userModel?.mobile ?? '';
  }

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
                  SizedBox(height: 80),
                  Text(
                    'Update Profile',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  SizedBox(height: 24),
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
                        SizedBox(width: 10),
                        Text(
                          _selectedImage == null
                              ? 'Select image'
                              : _selectedImage!.name,
                          maxLines: 1,
                          style: TextStyle(overflow: TextOverflow.ellipsis),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: _emailController,
                    enabled: false,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      hintText: 'Email',
                    ),
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
                    validator: (String? value) {
                      if (value?.trim().isEmpty ?? true) {
                        return 'Please enter your first name';
                      }
                      return null;
                    },
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
                    validator: (String? value) {
                      if (value?.trim().isEmpty ?? true) {
                        return 'Please enter your last name';
                      }
                      return null;
                    },
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
                    validator: (String? value) {
                      if (value?.trim().isEmpty ?? true) {
                        return 'Please enter mobile number';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: _passwordController,
                    textInputAction: TextInputAction.done,
                    obscureText: true,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      hintText: 'Password',
                    ),
                    validator: (String? value) {
                      int len = value?.length ?? 0;
                      if (len > 0 && len <= 6) {
                        return 'Please enter your Password more then 6 character';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),
                  Visibility(
                    visible: updateImageInProgress == false,
                    replacement: Center(child: CircularProgressIndicator()),
                    child: ElevatedButton(
                      onPressed: _onTapSignupButton,
                      child: Icon(Icons.arrow_circle_right_outlined),
                    ),
                  ),
                  SizedBox(height: 20),
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
        child: Text(
          'Photo',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
        ),
      ),
    );
  }

  Future<void> _ontapimagepicker() async {
    final XFile? image = await _imagePicker.pickImage(
      source: ImageSource.gallery,
    );
    if (image != null) {
      _selectedImage = image;
      setState(() {});
    }
  }

  void _onTapSignupButton() {
    if (_formKey.currentState!.validate()) {
      _updateImage();
    }
  }

  Future<void> _updateImage() async {
    updateImageInProgress = true;

    if (mounted) {
      setState(() {});
    }
     Uint8List? imageBytes;
    Map<String, String> requestbody = {
      "email": _emailController.text,
      "firstName": _nameController.text.trim(),
      "lastName": _lastnameController.text.trim(),
      "mobile": _mobileController.text,
    };
    if (_passwordController.text.isNotEmpty) {
      requestbody['password'] = _passwordController.text;
    }
    if (_selectedImage != null) {
       imageBytes = await _selectedImage!.readAsBytes();
      requestbody['photo'] = base64Encode(imageBytes);
    }
    NetworkResponse response = await Networkcaller.postRequest(
      url: Url.updateProfileUrl,
      body: requestbody,
    );
    if (response.isSuccess) {
      user userModels = user(
        id: authcontroller.userModel!.id,
        email: _emailController.text.trim(),
        firstName: _nameController.text.trim(),
        lastName: _lastnameController.text.trim(),
        mobile: _mobileController.text.trim(),
        photo: imageBytes == null ? authcontroller.userModel!.photo : base64Encode(imageBytes),
      );
      await authcontroller.UpdateUserData(userModels,);
      _passwordController.clear();
      updateImageInProgress = false;
      if (mounted) {
        setState(() {});
      }
    } else {
      updateImageInProgress = false;
      if (mounted) {
        snackbar_message(context, 'Successfully Updated');
      } else {
        snackbar_message(context, response.message!);
      }
    }
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
