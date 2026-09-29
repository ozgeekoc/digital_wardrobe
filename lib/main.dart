import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'home_screen.dart';
import 'theme.dart';

void main() {
  runApp(const ProviderScope(child: WardrobeApp()));
}

class WardrobeApp extends StatelessWidget {
  const WardrobeApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Gardırop',
        theme: appTheme,
        debugShowCheckedModeBanner: false,
        home: const HomeScreen(),
      );
}