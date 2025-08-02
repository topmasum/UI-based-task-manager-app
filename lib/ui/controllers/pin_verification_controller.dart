import 'package:get/get.dart';
import '../../data/Urls.dart';
import '../../data/service/network_caller.dart';

class PinVerificationController extends GetxController {
  bool _inProgress = false;
  bool get inProgress => _inProgress;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<bool> verifyPin(String email, String pin) async {
    _inProgress = true;
    update();

    final url = Url.verifyPinUrl(email, pin);
    final response = await Networkcaller.getRequest(url: url);

    _inProgress = false;
    update();

    if (response.isSuccess) {
      _errorMessage = null;
      return true;
    } else {
      _errorMessage = response.message ?? 'Verification failed';
      return false;
    }
  }
}
