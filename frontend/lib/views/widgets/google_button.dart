import 'package:flutter/material.dart';
import '../../../../views/page/colors.dart';

class GoogleButton extends StatelessWidget {
  final String text; // Bisa diisi "Login with Google" atau "Sign Up with Google"
  final VoidCallback onPressed;

  const GoogleButton({
    super.key,
    this.text = "Login With Google", // Default text
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white, // Background putih
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(30),
          onTap: onPressed,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Ganti dengan Image.asset('assets/images/google.png') kalau sudah ada
              const Icon(Icons.g_mobiledata, size: 30, color: Colors.red), 
              const SizedBox(width: 10),
              Text(
                text,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textDark,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}