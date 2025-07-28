import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:task_manager/splash%20screens/signin_page.dart';
import 'package:task_manager/splash%20screens/update_profile_screen.dart';
import '../ui/controllers/auth_controller.dart';

class TMappbar_widget extends StatelessWidget implements PreferredSizeWidget {
  const TMappbar_widget({super.key});

  @override
  Widget build(BuildContext context) {
    final userModel = authcontroller.userModel; // Local variable for safety

    return AppBar(
      backgroundColor: Colors.green,
      title: GestureDetector(
        onTap: () => _ontapProfile(context),
        child: Row(
          children: [
            CircleAvatar(
              backgroundImage: userModel?.photo != null
                  ? MemoryImage(base64Decode(userModel!.photo!))
                  : null,
              child: userModel?.photo == null
                  ? const Icon(Icons.person, color: Colors.white)
                  : null,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    userModel?.fullnaem ?? 'Guest User',
                    style: const TextStyle(fontSize: 15, color: Colors.white),
                  ),
                  Text(
                    userModel?.email ?? 'No email',
                    style: const TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
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
      context,
      SigninScreen.routeName,
          (route) => false,
    );
  }

  void _ontapProfile(BuildContext context) {
    if (ModalRoute.of(context)?.settings.name == update_profile_screen.routeName) {
      return;
    }
    Navigator.pushNamed(context, update_profile_screen.routeName);
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}