import 'package:get/get.dart';
import '../../data/Urls.dart';
import '../../data/service/network_caller.dart';

class ForgetPassController extends GetxController {
  bool _inProgress = false;
  bool get inProgress => _inProgress;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<bool> sendRecoveryEmail(String email) async {
    _inProgress = true;
    update(); // Notify UI

    final response = await Networkcaller.getRequest(
      url: Url.recoveryEmailUrl(email),
    );

    _inProgress = false;
    update();

    if (response.isSuccess) {
      _errorMessage = null;
      return true;
    } else {
      _errorMessage = response.message ?? 'Something went wrong';
      return false;
    }
  }
}
