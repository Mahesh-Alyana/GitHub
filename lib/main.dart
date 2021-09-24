import 'package:flutter/material.dart';
import 'package:githubfinal/providers/repo_provider.dart';
import 'package:githubfinal/providers/user_provider.dart';
import 'package:githubfinal/screen/home_screen.dart';

import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: UserProvider()),
        ChangeNotifierProvider.value(value: RepositriesProvider()),
      ],
      child: MaterialApp(
        title: 'GitHub',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: HomeScreen(),
      ),
    );
  }
}
