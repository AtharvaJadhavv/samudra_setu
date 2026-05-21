/*
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'welcome.dart';
import 'login.dart';
import 'signup.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SamudraSetu',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // Using a light theme so text inside the white form containers is visible
        brightness: Brightness.light,
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
      ),
      // Set the first screen the user sees to your WelcomeScreen
      initialRoute: '/',
      // Define all the possible navigation paths in your app
      routes: {
        '/': (context) => const WelcomeScreen(),
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignUpScreen(),
      },
    );
  }
}*/
/*
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'welcome.dart';
import 'login.dart';
import 'signup.dart';
import 'homepage.dart'; // Import the new homepage file

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SamudraSetu',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
        primarySwatch: Colors.teal,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const WelcomeScreen(),
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignUpScreen(),
         '/home': (context) => const HomeScreen(), // Add the home screen route
      },
    );
  }
}*/
// lib/main.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'welcome.dart';
import 'login.dart';
import 'signup.dart';
import 'homepage.dart';
import 'map.dart';
import 'report.dart';
import 'social.dart';
import 'alert.dart';
import 'profile.dart';
import 'sos.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SamudraSetu',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
        // Using a primary color that fits the app's theme
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF0A4E6C)),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const WelcomeScreen(),
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignUpScreen(),
        '/home': (context) => const HomeScreen(),
        '/map': (context) => const MapScreen(),
        '/report': (context) => const ReportScreen(),
        '/social': (context) => const SocialScreen(),
        '/alert': (context) => const AlertsScreen(),
        '/profile': (context) => const ProfileScreen(),
        '/sos': (context) => const SosScreen(),
      },
    );
  }
}