import 'package:flutter/material.dart';
import 'package:travel_ai/profile%20_screen.dart';

import 'destinations.dart';
import 'home.dart';
import 'login.dart';
import 'register.dart';
import 'splash.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Travel App',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        '/login': (context) => LoginScreen(),
        '/signup': (context) => SignUpScreen(),
        '/home': (context) => HomeScreen(),
        '/travelDestinations': (context) => TravelDestinationsScreen(),
        '/register': (context) => ProfileScreen(),
      },
    );
  }
}
