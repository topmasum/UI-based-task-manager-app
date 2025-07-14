import 'package:flutter/material.dart';
import 'package:task_manager/splash%20screens/signin_page.dart';

class TMappbar_widget extends StatelessWidget implements PreferredSizeWidget {
  const TMappbar_widget({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.green,
      title: Row(
        children: [
          const CircleAvatar(),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('Masum Billah',
                    style: TextStyle(fontSize: 15, color: Colors.white)),
                Text('masum@gmail.com',
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
    );
  }

  void _ontapLogout(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(
        context, SigninScreen.routeName, (route) => false);
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
