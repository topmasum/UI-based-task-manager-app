import 'package:flutter/material.dart';

import '../widget/task_card.dart';
class Completedtask extends StatefulWidget {
  const Completedtask({super.key});

  @override
  State<Completedtask> createState() => _CompletedtaskState();
}

class _CompletedtaskState extends State<Completedtask> {
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
                 // return Taskcard(status: TaskStatus.completed,);
                }))
          ],
        ),
      ),
    );

  }
}
