import 'package:get/get.dart';
import '../../data/Urls.dart';
import '../../data/service/network_caller.dart';

class PinVerificationController extends GetxController {
  bool inProgress = false;

  Future<bool> verifyPin(String email, String pin) async {
    inProgress = true;
    update(); // Notify UI

    final url = Url.verifyPinUrl(email, pin);
    final response = await Networkcaller.getRequest(url: url);

    inProgress = false;
    update(); // Notify UI

    if (response.isSuccess) {
      return true;
    } else {
      Get.snackbar('Verification Failed', response.message ?? 'Something went wrong');
      return false;
    }
  }
}
