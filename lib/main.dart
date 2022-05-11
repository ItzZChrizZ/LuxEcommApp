import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luxappv2/pages/landing-page.dart';

void main(List<String> args) {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.latoTextTheme(
          Theme.of(context).textTheme,
        ),
        colorScheme: ColorScheme.fromSwatch()
            .copyWith(secondary: const Color(0xffff1e00)),
      ),
      home: LandingPage(),
    );
  }
}
