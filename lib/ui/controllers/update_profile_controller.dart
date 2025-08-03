import 'dart:convert';
import 'dart:typed_data';
import 'package:get/get.dart';
import '../../data/Urls.dart';
import '../../data/models/user_model.dart';
import '../../data/service/network_caller.dart';
import 'auth_controller.dart'; // You already use this globally

class ProfileUpdateController extends GetxController {
  bool _inProgress = false;
  bool get inProgress => _inProgress;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<bool> updateProfile({
    required String email,
    required String firstName,
    required String lastName,
    required String mobile,
    String? password,
    Uint8List? imageBytes,
  }) async {
    _inProgress = true;
    update();

    Map<String, String> requestBody = {
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'mobile': mobile,
    };

    if (password != null && password.trim().isNotEmpty) {
      requestBody['password'] = password.trim();
    }

    if (imageBytes != null) {
      requestBody['photo'] = base64Encode(imageBytes);
    }

    NetworkResponse response = await Networkcaller.postRequest(
      url: Url.updateProfileUrl,
      body: requestBody,
    );

    _inProgress = false;

    if (response.isSuccess) {
      final newUser = user(
        id: authcontroller.userModel!.id,
        email: email,
        firstName: firstName,
        lastName: lastName,
        mobile: mobile,
        photo: imageBytes == null
            ? authcontroller.userModel!.photo
            : base64Encode(imageBytes),
      );
      await authcontroller.UpdateUserData(newUser);
      update();
      return true;
    } else {
      _errorMessage = response.message!;
      update();
      return false;
    }
  }
}
