import 'package:flutter/material.dart';

import '../widget/task_card.dart';
class Progresstaskscreen extends StatefulWidget {
  const Progresstaskscreen({super.key});

  @override
  State<Progresstaskscreen> createState() => _ProgresstaskscreenState();
}

class _ProgresstaskscreenState extends State<Progresstaskscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal:8),
        child: Column(
          children: [
            SizedBox(height: 10,),
            Expanded(child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context,index){
                  return Taskcard(status: TaskStatus.progress);
                }))
          ],
        ),
      ),
    );

  }

}
