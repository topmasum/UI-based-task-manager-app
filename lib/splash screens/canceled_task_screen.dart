import 'package:flutter/material.dart';

import '../widget/task_card.dart';
class CanceledTaskScreen extends StatefulWidget {
  const CanceledTaskScreen({super.key});

  @override
  State<CanceledTaskScreen> createState() => _CanceledTaskScreenState();
}

class _CanceledTaskScreenState extends State<CanceledTaskScreen> {
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
                  return Taskcard();
                }))
          ],
        ),
      ),
    );

  }
}
