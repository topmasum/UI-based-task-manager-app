import 'package:flutter/material.dart';
import 'package:task_manager/splash%20screens/progresstaskscreen.dart';

import '../widget/appbar.dart';
import 'canceled_task_screen.dart';
import 'completedtask.dart';
import 'new_tasklist_screen.dart';
class MainNvaHolder extends StatefulWidget {
   MainNvaHolder({super.key});
  static const String routeName = '/main_nav_holder';

  @override
  State<MainNvaHolder> createState() => _MainNvaHolderState();
}

class _MainNvaHolderState extends State<MainNvaHolder> {
  List<Widget> _screens=[
    NewTasklistScreen(),Progresstaskscreen(),Completedtask(),CanceledTaskScreen()
  ];
   int _selectedIndex=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TMappbar_widget(),
      body: _screens[_selectedIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
          onDestinationSelected: (int index){
            _selectedIndex=index;
            setState(() {
            });
          },
          destinations: [
            NavigationDestination(icon: Icon(Icons.new_label), label: 'New'),
            NavigationDestination(icon: Icon(Icons.arrow_circle_right_outlined), label: 'Progress'),
            NavigationDestination(icon: Icon(Icons.done_outline_sharp), label: 'Completed'),
            NavigationDestination(icon: Icon(Icons.cancel_outlined), label: 'Canceled'),

          ]
      ),

    );
  }
}


