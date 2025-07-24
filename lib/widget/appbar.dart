import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:task_manager/splash%20screens/signin_page.dart';
import 'package:task_manager/splash%20screens/update_profile_screen.dart';

import '../ui/controllers/auth_controller.dart';

class TMappbar_widget extends StatelessWidget implements PreferredSizeWidget {
  const TMappbar_widget({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.green,
      title: GestureDetector(
        onTap:() => _ontapProfile(context),
        child: Row(
          children: [
             CircleAvatar(
              backgroundImage:authcontroller.userModel?.photo==null ? null:
              MemoryImage(
                  base64Decode(authcontroller.userModel!.photo!
                  )),

            ),
             SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:  [
                  Text(authcontroller.userModel!.fullnaem,
                      style: TextStyle(fontSize: 15, color: Colors.white)),
                  Text(authcontroller.userModel!.email,
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                          fontWeight: FontWeight.normal)),
                ],
              ),
            ),
            IconButton(
              onPressed: () => _ontapLogout(context),
              icon: const Icon(Icons.logout),
            )
          ],
        ),
      ),
    );

  }

  Future<void> _ontapLogout(BuildContext context) async {
    await authcontroller.removeUserData();
    Navigator.pushNamedAndRemoveUntil(
        context, SigninScreen.routeName, (route) => false);
  }
  void _ontapProfile(BuildContext context){
    if(ModalRoute.of(context)!.settings.name==update_profile_screen.routeName)
      {
        return;
      }else{
      Navigator.pushNamed(context, update_profile_screen.routeName );

    }
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
