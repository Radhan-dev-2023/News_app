import 'package:flutter/cupertino.dart';

Widget mediumSpacing(BuildContext context,double height){
  return SizedBox(
    height: MediaQuery.of(context).size.height*height,
  );
}