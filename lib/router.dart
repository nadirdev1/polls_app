import 'package:flutter/material.dart';
import 'package:flutter_course_app/screens/create_poll_screen.dart';
import 'package:flutter_course_app/screens/forget_password_screen.dart';
import 'package:flutter_course_app/screens/home_show_poll_screen.dart';
import 'package:flutter_course_app/screens/settings_screen.dart';
import 'package:flutter_course_app/screens/sign_in_screen.dart';
import 'package:flutter_course_app/screens/sign_up_screen.dart';

final Map<String, WidgetBuilder> appRoutes = {
  '/signin': (context) => const SignInScreen(),
  '/signup': (context) => const SignUpScreen(),
  '/home': (context) => const HomeShowPollScreen(),
  '/reset_password': (context) => const ForgetPasswordScreen(),
  '/settings': (context) => const SettingsScreen(),
  '/create': (context) {
    final String currentUserId =
        ModalRoute.of(context)!.settings.arguments as String;
    return CreatePollScreen(currentUserId: currentUserId);
  }
};
