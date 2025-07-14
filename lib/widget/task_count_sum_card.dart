import 'package:flutter/material.dart';
class task_count_sum_card extends StatelessWidget {
  const task_count_sum_card({
    super.key,
    required this.title,
    required this.count,
  });

  final String title;
  final int count;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('$count', style: Theme.of(context).textTheme.titleLarge),
            Text(title,maxLines: 1,),
          ],
        ),
      ),
    );
  }
}