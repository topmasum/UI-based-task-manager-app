import 'package:flutter/material.dart';

void snackbar_message(BuildContext context,String message){
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));

}