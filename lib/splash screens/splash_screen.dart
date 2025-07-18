import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task_manager/splash%20screens/signin_page.dart';
import 'package:task_manager/utils/assets_path.dart';
import 'package:task_manager/widget/screen_background.dart';

import '../ui/controllers/auth_controller.dart';
import 'main_nva_holder.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  static const String routeName = '/';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _moveToNextScreen();
  }

  Future<void> _moveToNextScreen() async {
    await Future.delayed(const Duration(seconds: 2));
    bool isLoggedIn = await authcontroller.isLoggedIn();
    if (isLoggedIn) {
      Navigator.pushReplacementNamed(context, MainNvaHolder.routeName);
    } else {
      Navigator.pushReplacementNamed(context, SigninScreen.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screen_background(
        child: Center(child: SvgPicture.asset(Asset.logopath)),
      ),
    );
  }
}
