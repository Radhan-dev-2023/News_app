import 'package:flutter/material.dart';
import 'package:news_app/constants/colors.dart';

void showSnackBar(BuildContext context,String content){
  ScaffoldMessenger.of(context).showSnackBar(
     SnackBar(
      backgroundColor: appColor,
      content: Text(content,style: const TextStyle(color: buttonTextColor),),
    ),
  );
}