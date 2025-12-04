import 'package:flutter/material.dart';
// Sesuaikan path import colors ini dengan struktur foldermu

class FacebookButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const FacebookButton({
    super.key,
    this.text = "Login With Facebook",
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        color: const Color(0xFF1877F2), // Warna Biru Khas Facebook
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
              // Ikon Facebook sudah ada bawaan di Flutter
              const Icon(Icons.facebook, size: 30, color: Colors.white), 
              const SizedBox(width: 10),
              Text(
                text,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white, // Teks putih di atas background biru
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}