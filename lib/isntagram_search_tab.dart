import 'dart:async';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '3d_touch_dialog.dart';

class InstagramSearchTab extends StatefulWidget {
  @override
  _InstagramSearchTabState createState() => _InstagramSearchTabState();
}

class _InstagramSearchTabState extends State<InstagramSearchTab>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  int currentIndex = 0;
  int currentImageHeight = 0;
  bool isTapped = false;
  double targetValue = 0.8;

  Future<int> _calculateImageDimension(String currentImage) {
    Completer<int> completer = Completer();
    Image image = Image.asset(currentImage);
    image.image.resolve(ImageConfiguration()).addListener(
      ImageStreamListener(
        (ImageInfo image, bool synchronousCall) {
          var myImage = image.image;
          int imageHeight = myImage.height;
          completer.complete(imageHeight);
        },
      ),
    );
    return completer.future;
  }

  List<String> listOfImages = [
    'assets/images/1.jpg',
    'assets/images/2.jpg',
    'assets/images/3.jpg',
    'assets/images/4.jpg',
    'assets/images/5.jpg',
    'assets/images/6.jpg',
    'assets/images/7.jpg',
    'assets/images/8.jpg',
    'assets/images/9.jpg',
    'assets/images/10.jpg',
    'assets/images/11.jpg',
    'assets/images/12.jpg',
    'assets/images/13.jpg',
    'assets/images/14.jpg',
    'assets/images/15.jpg',
    'assets/images/1.jpg',
    'assets/images/2.jpg',
    'assets/images/3.jpg',
    'assets/images/4.jpg',
    'assets/images/5.jpg',
    'assets/images/6.jpg',
    'assets/images/7.jpg',
    'assets/images/8.jpg',
    'assets/images/9.jpg',
  ];

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    )..addStatusListener((status) {
        if (status == AnimationStatus.forward) {
          isTapped = true;
        } else if (status == AnimationStatus.dismissed) {
          setState(() {
            isTapped = false;
          });
        }
      });

    _calculateImageDimension(listOfImages[currentIndex]).then((size) {
      currentImageHeight = size;
    });

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return ImageFiltered(
                imageFilter: ImageFilter.blur(
                  sigmaY: _controller.value * 10,
                  sigmaX: _controller.value * 10,
                ),
                child: child,
              );
            },
            child: Stack(
              children: [
                GridView.builder(
                  padding: EdgeInsets.only(bottom: 55, top: 90),
                  physics: BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  itemCount: listOfImages.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 2,
                    mainAxisSpacing: 2,
                  ),
                  itemBuilder: (context, index) => GestureDetector(
                    onLongPressStart: (_) {
                      _controller.forward();
                      setState(() {
                        currentIndex = index;
                        targetValue = 1;
                      });
                    },
                    onLongPressEnd: (_) {
                      _controller.reverse();
                      setState(() {
                        targetValue = 0.8;
                      });
                    },
                    child: Image.asset(
                      listOfImages[index],
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: SizedBox(
                    height: 90,
                    child: AppBar(
                      backgroundColor: Colors.white,
                      shadowColor: Colors.black26,
                      title: Container(
                        height: 35,
                        decoration: BoxDecoration(
                            color: Colors.black.withOpacity(.09),
                            borderRadius: BorderRadius.circular(10)),
                        child: Row(
                          children: [
                            SizedBox(width: 15),
                            Icon(
                              CupertinoIcons.search,
                              color: Colors.black87,
                              size: 22,
                            ),
                            SizedBox(width: 15),
                            Text(
                              'Search',
                              style: TextStyle(
                                color: Colors.black38,
                                fontWeight: FontWeight.w400,
                                fontSize: 19,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: 55,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 15,
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Icon(
                          CupertinoIcons.home,
                          color: Colors.black87,
                          size: 27,
                        ),
                        Icon(
                          CupertinoIcons.search,
                          color: Colors.black87,
                          size: 27,
                        ),
                        Icon(
                          CupertinoIcons.play_circle,
                          color: Colors.black87,
                          size: 27,
                        ),
                        Icon(
                          CupertinoIcons.heart,
                          color: Colors.black87,
                          size: 27,
                        ),
                        Icon(
                          CupertinoIcons.circle_filled,
                          color: Colors.black87,
                          size: 27,
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  height: isTapped == true ? size.height : 0,
                  width: isTapped == true ? size.width : 0,
                  color: Colors.black12,
                ),
              ],
            ),
          ),
          isTapped == true
              ? TweenAnimationBuilder<double>(
                  tween: Tween<double>(begin: 0.8, end: targetValue),
                  curve: Curves.easeOutBack,
                  duration: Duration(milliseconds: 400),
                  child: FadeTransition(
                    opacity: CurvedAnimation(
                      parent: _controller,
                      curve: Interval(0.0, .9, curve: Curves.ease),
                      reverseCurve: Curves.easeInCubic,
                    ),
                    child: PopUpDialog(
                      currentImage: listOfImages,
                      currentIndex: currentIndex,
                      imageHeight: currentImageHeight,
                    ),
                  ),
                  builder: (context, size, child) {
                    return Transform.scale(
                      scale: size,
                      child: child,
                    );
                  },
                )
              : SizedBox(),
        ],
      ),
    );
  }
}
