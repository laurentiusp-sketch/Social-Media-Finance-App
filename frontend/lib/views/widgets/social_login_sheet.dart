import 'package:flutter/material.dart';
import '../../../../views/page/colors.dart';
import '../../controllers/auth/auth_service.dart';
import 'google_button.dart';
import 'facebook_button.dart';
import 'apple_button.dart';

class SocialLoginSheet extends StatelessWidget {
  const SocialLoginSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(30),
      width: double.infinity,
      decoration: const BoxDecoration(
        color: AppColors.primaryBackground,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 50, height: 5,
            decoration: BoxDecoration(color: Colors.white54, borderRadius: BorderRadius.circular(10)),
          ),
          const SizedBox(height: 30),
          const Text("Choose Login Method", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
          const SizedBox(height: 30),

          // 1. Google (LOGIC SUDAH DIPASANG)
          GoogleButton(
            text: "Continue with Google",
            onPressed: () async {
              // Panggil Loading (Opsional)
              print("Mencoba Login Google...");
              
              // PANGGIL SERVICE
              final user = await AuthService().signInWithGoogle();

              if (user != null) {
                print("Login Berhasil! User: ${user.user?.email}");
                // Tutup Sheet
                if (context.mounted) Navigator.pop(context);
              } else {
                print("Login Gagal atau Dibatalkan user.");
              }
            },
          ),
          
          const SizedBox(height: 15),
          
          // 2. Apple
          AppleButton(
            text: "Continue with Apple",
            onPressed: () {
              print("Login Apple Clicked"); // Belum ada logic
              Navigator.pop(context);
            },
          ),
          const SizedBox(height: 15),

          // 3. Facebook
          FacebookButton(
            text: "Continue with Facebook",
            onPressed: () {
              print("Login Facebook Clicked"); // Belum ada logic
              Navigator.pop(context);
            },
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}