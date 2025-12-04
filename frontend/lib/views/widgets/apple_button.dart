import 'package:flutter/material.dart';
// Sesuaikan path import colors ini dengan struktur foldermu

class AppleButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const AppleButton({
    super.key,
    this.text = "Login With Apple",
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.black, // Apple identik dengan warna hitam solid
        borderRadius: BorderRadius.circular(30),
        // Kita kasih border tipis biar batasnya jelas di background gelap
        border: Border.all(color: Colors.white24), 
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(30),
          onTap: onPressed,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Ikon Apple sudah ada bawaan di Flutter
              const Icon(Icons.apple, size: 30, color: Colors.white), 
              const SizedBox(width: 10),
              Text(
                text,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white, // Teks putih
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}