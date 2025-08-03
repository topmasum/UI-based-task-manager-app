import 'package:get/get.dart';
import '../../data/Urls.dart';
import '../../data/service/network_caller.dart';

class SignupController extends GetxController {
  bool _inProgress = false;
  bool get inProgress => _inProgress;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<bool> signup({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required String mobile,
  }) async {
    _inProgress = true;
    update();

    final Map<String, String> requestBody = {
      'email': email,
      'password': password,
      'firstName': firstName,
      'lastName': lastName,
      'mobile': mobile,
    };

    final response = await Networkcaller.postRequest(
      url: Url.registrationUrl,
      body: requestBody,
    );

    _inProgress = false;
    if (response.isSuccess) {
      _errorMessage = null;
      update();
      return true;
    } else {
      _errorMessage = response.message!;
      update();
      return false;
    }
  }
}
