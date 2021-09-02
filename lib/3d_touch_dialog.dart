import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PopUpDialog extends StatelessWidget {
  final List<String> currentImage;
  final int currentIndex;
  final int imageHeight;

  const PopUpDialog({
    Key? key,
    required this.currentIndex,
    required this.currentImage,
    required this.imageHeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: (imageHeight * .72745) + 110 - 20,
      width: size.width,
      margin: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          Container(
            height: 55,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.black.withOpacity(.1),
                  width: .5,
                ),
              ),
            ),
            child: Row(
              children: [
                SizedBox(width: 10),
                CircleAvatar(backgroundColor: Colors.black),
                SizedBox(width: 10),
                Text(
                  'dev.gaurav_tantuway',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Image.asset(
              currentImage[currentIndex],
              fit: BoxFit.fitHeight,
            ),
          ),
          Container(
            height: 55,
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: Colors.black.withOpacity(.1),
                  width: .5,
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Icon(CupertinoIcons.heart, size: 27),
                Icon(CupertinoIcons.person_crop_circle, size: 27),
                Icon(CupertinoIcons.paperplane, size: 27),
                Icon(Icons.more_vert_rounded, size: 27),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
