import 'package:flutter/material.dart';
import '../../../../views/page/colors.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/primary_button.dart'; // Import tombol utama
import '../widgets/google_button.dart';  // Import tombol google

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBackground,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 500),
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Create Account',
                    style: TextStyle(
                      fontSize: 32, fontWeight: FontWeight.bold, color: AppColors.white
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    'Please fill in the input below.',
                    style: TextStyle(color: Colors.white70, fontSize: 16),
                  ),
                  
                  const SizedBox(height: 30),

                  // Form Input
                  const CustomTextField(hintText: "Full Name", icon: Icons.person_outline),
                  const CustomTextField(hintText: "Phone or Email", icon: Icons.email_outlined),
                  const CustomTextField(hintText: "Password", icon: Icons.lock_outline, isPassword: true),
                  const CustomTextField(hintText: "Confirm Password", icon: Icons.lock_outline, isPassword: true),

                  const SizedBox(height: 20),

                  // 1. PAKE PRIMARY BUTTON (Khusus Register)
                  PrimaryButton(
                    text: "Register",
                    onPressed: () {
                       print("Register form submitted");
                    },
                  ),
                  
                  const SizedBox(height: 20),
                  const Center(
                    child: Text("Or sign up with", style: TextStyle(color: Colors.white54)),
                  ),
                  const SizedBox(height: 15),
                  
                  // 2. PAKE GOOGLE BUTTON (Khusus Google)
                  GoogleButton(
                    text: "Sign Up with Google",
                    onPressed: (){
                      print("Google Sign Up Clicked");
                    },
                  ),
                  
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}