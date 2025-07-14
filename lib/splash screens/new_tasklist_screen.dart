import 'package:flutter/material.dart';

import '../widget/task_card.dart';
import '../widget/task_count_sum_card.dart';

class NewTasklistScreen extends StatefulWidget {
  const NewTasklistScreen({super.key});

  @override
  State<NewTasklistScreen> createState() => _NewTasklistScreenState();
}

class _NewTasklistScreenState extends State<NewTasklistScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal:16),
        child: Column(
          children: [
            SizedBox(height: 16,),
            SizedBox(
              height: 100,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return task_count_sum_card(
                    title: 'Progress',
                    count: 12,
                  );
                },
                separatorBuilder: (context, index) => const SizedBox(width: 4),
                itemCount: 4,
              ),
            ),
            Expanded(child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context,index){
                  return Taskcard();
                }))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _ontapaddnewtask,
        child: Icon(Icons.add),
      ),
    );

  }
  void _ontapaddnewtask(){

  }
}




