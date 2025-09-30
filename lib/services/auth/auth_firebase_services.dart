// lib/services/auth/auth_firebase_services.dart
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_course_app/services/auth/error_mapper.dart';

class AuthResult {
  final bool success;
  final String message;
  final User? user;
  AuthResult({required this.success, required this.message, this.user});
}

class AuthServices {
  final FirebaseAuth _auth;
  AuthServices({FirebaseAuth? auth}) : _auth = auth ?? FirebaseAuth.instance;

  bool get isLoggedIn => _auth.currentUser != null;
  User? get currentUser => _auth.currentUser;

  Future<AuthResult> signInWithEmail(String email, String password) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return AuthResult(
          success: true, message: "Sign-in successful", user: credential.user);
    } on FirebaseAuthException catch (e) {
      return AuthResult(
          success: false, message: AuthErrorMapper.fromException(e));
    } catch (e) {
      return AuthResult(
          success: false, message: "Unexpected error: ${e.toString()}");
    }
  }

  Future<AuthResult> signUpWithEmail(String email, String password) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return AuthResult(
          success: true, message: "Sign-up successful", user: credential.user);
    } on FirebaseAuthException catch (e) {
      return AuthResult(
          success: false, message: AuthErrorMapper.fromException(e));
    } catch (e) {
      return AuthResult(
          success: false, message: "Unexpected error: ${e.toString()}");
    }
  }

  Future<AuthResult> sendPasswordReset(String email) async {
    try {
      final trimmed = email.trim();
      if (trimmed.isEmpty) {
        return AuthResult(success: false, message: 'Email is required');
      }
      await _auth.sendPasswordResetEmail(email: trimmed);
      return AuthResult(success: true, message: 'Password reset email sent');
    } on FirebaseAuthException catch (e) {
      return AuthResult(
          success: false, message: AuthErrorMapper.fromException(e));
    } catch (e) {
      return AuthResult(
          success: false, message: 'Unexpected error: ${e.toString()}');
    }
  }

  Future<AuthResult> signOut() async {
    try {
      await _auth.signOut();
      return AuthResult(success: true, message: "logged out succesfully");
    } on FirebaseAuthException catch (e) {
      return AuthResult(
          success: false, message: AuthErrorMapper.fromException(e));
    } catch (e) {
      return AuthResult(
          success: false, message: "Message error : ${e.toString()}");
    }
  }
}
