import 'package:flutter/material.dart';
import 'package:flutter_course_app/services/auth/auth_app_handlers.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final TextEditingController emailCTLR = TextEditingController();
  bool loader = false;

/*   static String? email(String? v) {
    if (v == null || v.trim().isEmpty) return 'Email required';
    final ok = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(v.trim());
    return ok ? null : 'Invalid email';
  } */

  bool isValidEmail(String email) {
    final emailRegex =
        RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(email.trim());
    return emailRegex;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.center,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    width: 300,
                    height: 300,
                    color: Colors.white, // contraste
                    child: Image.asset(
                      'assets/images/polling_orange_logo.png',
                      fit: BoxFit.contain, // pas de découpe du logo
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text("Forgot Password",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.black)),
              const SizedBox(height: 30),
              TextField(
                controller: emailCTLR,
                decoration: InputDecoration(
                  hintText: 'Email',
                  filled: true,
                  fillColor: Colors.grey.withValues(alpha: 0.3),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none),
                  prefixIcon: const Icon(
                    Icons.email,
                    color: Colors.black,
                  ),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(
                height: 20,
              ),
              loader
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: Colors.orange,
                      ),
                    )
                  : ElevatedButton(
                      onPressed: () async {
                        setState(() {
                          loader = true;
                        });

                        await AuthAppHandlers.handleResetEmail(context,
                            email: emailCTLR.text.toString());
                        setState(() {
                          loader = false;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        backgroundColor: Colors.orange,
                        foregroundColor: Colors.white,
                      ),
                      child: const Text("Send Password Reset Email"))
            ],
          ),
        ),
      ),
    ));
  }
}
