import 'package:flutter/material.dart';
import 'package:news_app/constants/colors.dart';

void showMyDialog(BuildContext context,String content) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text(
          "NEWS-READER",
          style: TextStyle(
            fontSize: 18,
            color: textColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(
          content,
          style: const TextStyle(
            fontSize: 18,
            color: errorColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: <Widget>[
          TextButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: buttonColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(7),
              ),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text(
              "OK",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: buttonTextColor,
              ),
            ),
          ),
        ],
      );
    },
  );
}