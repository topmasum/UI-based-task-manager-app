import 'package:get/get.dart';
import '../../data/Urls.dart';
import '../../data/service/network_caller.dart';

class ResetPasswordController extends GetxController {
  bool _inProgress = false;
  bool get inProgress => _inProgress;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<bool> resetPassword({
    required String email,
    required String otp,
    required String password,
  }) async {
    _inProgress = true;
    update();

    final response = await Networkcaller.postRequest(
      url: Url.resetPasswordUrl,
      body: {
        'email': email,
        'OTP': otp,
        'password': password,
      },
      useToken: false,
    );

    _inProgress = false;
    update();

    if (response.isSuccess) {
      _errorMessage = null;
      return true;
    } else {
      _errorMessage = response.message ?? 'Password reset failed';
      return false;
    }
  }
}
