import 'package:get/get.dart';
import '../../data/Urls.dart';
import '../../data/models/user_model.dart';
import '../../data/service/network_caller.dart';
import 'auth_controller.dart';

class Signin_controller extends GetxController{
  bool _Inprogress = false;
  bool get Inprogress => _Inprogress;
  String? _errormessage;
  String get errormessage => _errormessage!;

  Future<bool> signin(String email,String password) async {
    bool isSuccessful = false;
    _Inprogress = true;
    update();
    Map<String, String> reqbody = {
      'email': email,
      'password': password,
    };
    NetworkResponse response = await Networkcaller.postRequest(
      url: Url.loginUrl,
      body: reqbody,
    );
    if(response.isSuccess){
      user userModel=user.fromjson(response.body!['data']);
      String token=response.body!['token'];
      await authcontroller.saveUserData(token, userModel);
      isSuccessful=true;
      _errormessage=null;

    }else{
      _errormessage=response.message!;
    }
    _Inprogress = false;
    update();
    return isSuccessful;
  }


}