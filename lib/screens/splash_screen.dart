import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';


import 'home_screen.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 3),
            () => Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) =>  const HomeScreen())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 400,
            height: 300,
            child: CachedNetworkImage(
              progressIndicatorBuilder: (context, url, value) => Center(
                child: CircularProgressIndicator(
                  value: value.progress,
                ),
              ),
              imageUrl:
                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTGH7Bt4I96QqNG29Vrxmtz40-1ZbT4aaDfYgxRgwrpCg&s",
              height: 150,
              width: 100,
            ),
          ),
        ],
      ),
    );
  }
}
