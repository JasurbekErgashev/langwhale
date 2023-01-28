import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './theme.dart';
import './screens/home_screen.dart';
import './providers/data_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => DataProvider()),
      ],
      child: const LangWhale(),
    ),
  );
}

class LangWhale extends StatelessWidget {
  const LangWhale({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'LangWhale',
      theme: LangWhaleTheme.theme(),
      home: const HomeScreen(),
    );
  }
}
