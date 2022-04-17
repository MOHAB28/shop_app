import 'package:flutter/material.dart';
import '../helpers/cache_helper.dart';
import '../constance/color.dart';
import './login.dart';

import 'package:page_view_indicators/page_view_indicators.dart';

class BoardingData {
  final String? title;
  final String? image;
  final String? body;

  const BoardingData({
    @required this.image,
    @required this.title,
    @required this.body,
  });
}

class OnBoarding extends StatefulWidget {
  @override
  _OnBoardingState createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  static const List items = <BoardingData>[
    BoardingData(
      image: 'assets/images/welcome.jpg',
      title: 'On Boarding 1 Tile',
      body: 'On Boarding 1 Body',
    ),
    BoardingData(
      image: 'assets/images/welcome.jpg',
      title: 'On Boarding 2 Tile',
      body: 'On Boarding 2 Body',
    ),
    BoardingData(
      image: 'assets/images/welcome.jpg',
      title: 'On Boarding 3 Tile',
      body: 'On Boarding 3 Body',
    ),
  ];
  final _currentPageNotifier = ValueNotifier<int>(0);
  final controller = PageController();
  var isNav = false;

  void save() {
    CacheHelper.setBoolean(
      key: 'onBoarding',
      value: true,
    ).then((value) {
      if (value) {
        print(value);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => LoginScreen(),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: save,
            child: Text(
              'SKIP',
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: controller,
                itemBuilder: (ctx, i) => boardingItem(data: items[i]),
                itemCount: items.length,
                physics: BouncingScrollPhysics(),
                onPageChanged: (int index) {
                  _currentPageNotifier.value = index;
                  if (index == items.length - 1) {
                    setState(() {
                      isNav = true;
                    });
                  } else {
                    setState(() {
                      isNav = false;
                    });
                  }
                },
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            Row(
              children: [
                CirclePageIndicator(
                  itemCount: items.length,
                  currentPageNotifier: _currentPageNotifier,
                  dotColor: Colors.grey,
                  selectedDotColor: defualtColor,
                ),
                const Spacer(),
                FloatingActionButton(
                  child: Icon(
                    !isNav ? Icons.arrow_forward_ios_rounded : Icons.done,
                  ),
                  onPressed: () {
                    if (isNav) {
                      save();
                    } else {
                      controller.nextPage(
                        duration: const Duration(milliseconds: 750),
                        curve: Curves.fastLinearToSlowEaseIn,
                      );
                    }
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget boardingItem({
    @required BoardingData? data,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Image.asset(data!.image!),
        ),
        const SizedBox(
          height: 30.0,
        ),
        Text(
          data.title!,
          style: const TextStyle(
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 30.0,
        ),
        Text(
          data.body!,
        ),
      ],
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
