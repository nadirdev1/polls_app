import 'package:flutter/material.dart';

import 'package:flutter_course_app/services/auth/auth_app_handlers.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController emailCTLR = TextEditingController();
  final TextEditingController passwordCTLR = TextEditingController();
  bool obscurePassword = true;
  bool loader = false;

  @override
  void dispose() {
    emailCTLR.dispose();
    passwordCTLR.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
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
                const Text("Sign Up",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.black)),
                const SizedBox(height: 30),
                TextFormField(
                  controller: emailCTLR,
                  decoration: InputDecoration(
                    hintText: 'Email',
                    filled: obscurePassword,
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
                TextFormField(
                  controller: passwordCTLR,
                  obscureText: obscurePassword,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    filled: true,
                    fillColor: Colors.grey.withValues(alpha: 0.3),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none),
                    prefixIcon: const Icon(
                      Icons.lock,
                      color: Colors.black,
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        obscurePassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        setState(() {
                          obscurePassword = !obscurePassword;
                        });
                      },
                    ),
                  ),
                  keyboardType: TextInputType.text,
                ),
                const SizedBox(height: 32),
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
                          await AuthAppHandlers.handleSignUp(
                              email: emailCTLR.text.toString(),
                              password: passwordCTLR.text.toString(),
                              context);
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
                        child: const Text(
                          "Sign In",
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
