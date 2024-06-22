import 'package:flutter/material.dart';

import 'package:news_app/constants/colors.dart';

import 'Page1.dart';
import 'Page2.dart';
import 'Page3.dart';
import 'Page4.dart';
import 'Page5.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const Page1(),
    const Page2(),
    const Page3(),
    const Page4(),
    const Page5(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomAppBar(
        height: 65,
        color: appColor,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                  onPressed: () => _selectPage(0),
                  child: Icon(Icons.home,size: _currentIndex ==0?30:25,color:
                  _currentIndex == 0 ? blackColor : buttonTextColor)
                ),
                TextButton(
                  onPressed: () => _selectPage(1),
                  child:Icon(Icons.child_care_rounded,size: _currentIndex ==0?30:25,color:
                  _currentIndex == 1 ? blackColor : buttonTextColor),
                ),
                TextButton(
                  onPressed: () => _selectPage(2),
                  child: Icon(Icons.car_crash,size: _currentIndex ==0?30:25,color:
                  _currentIndex == 2 ? blackColor : buttonTextColor),
                ),
                TextButton(
                  onPressed: () => _selectPage(3),
                  child: Icon(Icons.business,size: _currentIndex ==0?30:25,color:
                  _currentIndex == 3 ? blackColor : buttonTextColor),
                ),
                TextButton(
                  onPressed: () => _selectPage(4),
                  child: Icon(Icons.book_online,size: _currentIndex ==0?30:25,color:
                  _currentIndex == 4 ? blackColor : buttonTextColor),
                ),

              ],
            )
          ],
        ),
      ),
    );
  }

  void _selectPage(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
