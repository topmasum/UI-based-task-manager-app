import 'package:flutter/material.dart';
class Taskcard extends StatelessWidget {
  const Taskcard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Title text',style: Theme.of(context).textTheme.titleMedium,),
            Text('Description',style: TextStyle(color: Colors.grey),),
            Text('Date: 15/07/2025'),
            const SizedBox(height: 8,),
            Row(
              children: [
                Chip(label: Text('New',
                    style:
                    TextStyle(color: Colors.white)
                ),
                    backgroundColor: Colors.green,
                    padding: EdgeInsets.symmetric(horizontal:16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    )
                ),
                Spacer(),
                IconButton(onPressed: (){}, icon: Icon(Icons.edit)),
                IconButton(onPressed: (){}, icon: Icon(Icons.delete)),
              ],
            )
          ],
        ),
      ),
    );
  }
}