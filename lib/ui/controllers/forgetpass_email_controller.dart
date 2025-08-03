import '../../data/Urls.dart';
import '../../data/service/network_caller.dart';
import 'package:get/get.dart';

class ForgetPassEmailController extends GetxController {
  bool inProgress = false;

  Future<bool> sendRecoveryEmail(String email) async {
    inProgress = true;
    update();

    final response = await Networkcaller.getRequest(
      url: Url.recoveryEmailUrl(email),
    );

    inProgress = false;
    update();

    if (response.isSuccess) {
      return true;
    } else {
      Get.snackbar('Error', response.message ?? 'Something went wrong');
      return false;
    }
  }
}
