import 'package:flutter/material.dart';
import 'screens/price_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light().copyWith(
        primaryColor: Colors.black,
        scaffoldBackgroundColor: Colors.white,
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: const Color(0xFF2BFFF1), // Your accent color
        ),
        // androidOverscrollIndicator: AndroidOverscrollIndicator.glow,
      ),
      home: PriceScreen(),
    );
  }
}
