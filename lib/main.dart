import 'package:flutter/material.dart';
import 'package:flutter_project/providers/user_provider.dart';
import 'package:flutter_project/repository/user_repository.dart';
import 'package:flutter_project/theme/theme.dart';
// import 'package:flutter_project/homepage.dart';
import 'package:flutter_project/view/event/event_view.dart';
import 'package:provider/provider.dart';

void main() async {
  final UserRepository userRepository = UserRepository();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => UserProvider(userRepository),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: EventView(),
      // home: Homepage(),
      theme: AppTheme.lightTheme,
    );
  }
}
