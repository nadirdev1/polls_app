// lib/services/auth/auth_app_handlers.dart
import 'package:flutter/material.dart';
import 'package:flutter_course_app/services/auth/auth_firebase_services.dart';
import 'package:flutter_course_app/utils/app_handlers.dart';

class AuthAppHandlers {
  static AuthServices authServices = AuthServices();

  /// Sign-up (inscription)
  static Future<void> handleSignUp(
    BuildContext context, {
    required String email,
    required String password,
    VoidCallback? onSuccess,
  }) async {
    final AuthResult result =
        await authServices.signUpWithEmail(email, password);
    if (context.mounted) handleAuthResult(result, onSuccess, context);
  }

  /// Sign-in (connexion)
  static Future<void> handleSignIn(
    BuildContext context, {
    required String email,
    required String password,
    VoidCallback? onSuccess,
  }) async {
    final AuthResult result =
        await authServices.signInWithEmail(email, password);

    if (context.mounted) handleAuthResult(result, onSuccess, context);
  }

  static Future<void> handleLogout(
    BuildContext context,
    VoidCallback? onSuccess,
  ) async {
    final AuthResult result = await authServices.signOut();
    if (context.mounted) handleAuthResult(result, onSuccess, context);

    /*  if (context.mounted) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        '/signin',
        (route) => false,
      );
    } */
  }

  static Future<void> handleResetEmail(
    BuildContext context, {
    required String email,
    VoidCallback? onSuccess,
  }) async {
    final AuthResult result = await authServices.sendPasswordReset(email);
    if (context.mounted) handleAuthResult(result, onSuccess, context);
  }

  static void handleAuthResult(
      AuthResult result, VoidCallback? onSuccess, BuildContext context) {
    AppHandlers.showSnackBar(context: context, message: result.message);
    if (result.success) {
      if (onSuccess != null) onSuccess();
    }
  }
}
