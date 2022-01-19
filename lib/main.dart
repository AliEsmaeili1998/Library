import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:persian_fonts/persian_fonts.dart';

import 'screens/homepage.dart';
import 'colors.dart';

void main() {
  runApp(const MyLibrary());
}

class MyLibrary extends StatelessWidget {
  const MyLibrary({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Library',
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('fa', ''),
      ],
      locale: const Locale('fa', ''),
      theme: ThemeData(
        scaffoldBackgroundColor: MyColors.background,
        textTheme: PersianFonts.vazirTextTheme,
      ),
      home: const HomePage(),
    );
  }
}