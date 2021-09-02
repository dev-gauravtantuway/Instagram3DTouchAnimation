import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'isntagram_search_tab.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: InstagramSearchTab(),
    ),
  );
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.dark,
      systemNavigationBarDividerColor: Colors.white,
      systemNavigationBarColor: Colors.white,
    ),
  );
}
