import 'package:flutter/material.dart';

class FinanceLiteracyTab extends StatelessWidget {
  const FinanceLiteracyTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // FEED 1 (MALEFINCE AI - Simple)
        _buildTwitterIGCard(
          name: "Malefince AI", 
          handle: "@malfince_ai.finance", 
          time: "2h", 
          content: [
            const TextSpan(text: "Financial literacy isn't about being rich, it's about being smart with your money. Mulailah budgeting dari sekarang! 💡📈"),
          ],
          avatarUrl: "https://i.pravatar.cc/150?img=33",
          contentImageUrl: "https://images.unsplash.com/photo-1579621970563-ebec7560ff3e?ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=80"
        ),
        
        const SizedBox(height: 20),
        
        // FEED 2 (BANK INDONESIA - News Style)
        _buildTwitterIGCard(
          name: "Bank Indonesia", 
          handle: "@bank.indonesia", 
          time: "5h", 
          category: "Economy News",
          headline: "BI-Rate Held at 4.75%: Maintaining Stability",
          content: [
            const TextSpan(text: "The Bank Indonesia Board of Governors decided on 18-19th November 2025 to hold the BI-Rate at 4.75%, while also maintaining the Deposit Facility (DF) rate at 3.75% and the Lending Facility (LF) rate at 5.50%. 🚀"),
          ],
          showImage: true,  
          avatarUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQrVJ0HD3GIEdm483jqqVNGOZTpaOdYQwWX2A&s",
          contentImageUrl: "https://plus.unsplash.com/premium_photo-1681487769650-a0c3fbaed85a?q=80&w=1255&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"
        ),

        const SizedBox(height: 20), 

        // FEED 3 (MALEFINCE AI - RICH TEXT / BOLD)
        _buildTwitterIGCard(
          name: "Malefince AI", 
          handle: "@malfince_ai.finance", 
          time: "2h", 
          category: "Saving Money",
          headline: "Financial literacy isn’t about being rich it’s about being smart with your money.",
          content: [
            const TextSpan(text: "Halo semuanya! Hari ini kita bahas sedikit tentang pentingnya literasi finansial bagi mahasiswa dan anak muda.\n\n"),
            const TextSpan(text: "Mulailah dari hal kecil: belajar membuat budget bulanan, mengenali pengeluaran yang tidak perlu, dan menyisihkan sebagian untuk tabungan atau investasi kecil-kecilan 💰\n\n"),
            const TextSpan(text: "Dengan memahami dasar-dasar keuangan sejak dini, kamu bisa lebih siap menghadapi masa depan tanpa panik soal uang.\n\n"),
            const TextSpan(
              text: "Yuk, mulai bijak kelola keuangan dari sekarang! 🌱",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
          avatarUrl: "https://i.pravatar.cc/150?img=33",
          contentImageUrl: "https://images.unsplash.com/photo-1579621970563-ebec7560ff3e?ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=80"
        ),
        
        const SizedBox(height: 100),
      ],
    );
  }

  // WIDGET KARTU FEED
  Widget _buildTwitterIGCard({
    required String name,
    required String handle,
    required String time,
    required List<InlineSpan> content,
    required String avatarUrl,
    bool showImage = true,
    String? headline,        
    String? category,        
    String? contentImageUrl, 
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(radius: 20, backgroundImage: NetworkImage(avatarUrl)),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(child: Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15), overflow: TextOverflow.ellipsis)),
                        const SizedBox(width: 4),
                        const Icon(Icons.verified, color: Colors.blue, size: 14),
                        const SizedBox(width: 6),
                        Text(time, style: const TextStyle(color: Colors.grey, fontSize: 13)),
                      ],
                    ),
                    Text(handle, style: const TextStyle(color: Colors.grey, fontSize: 13)),
                  ],
                ),
              ),
              const Icon(Icons.more_horiz, color: Colors.grey),
            ],
          ),
          
          const SizedBox(height: 12),

          // Kategori & Headline
          if (category != null)
            Container(
              margin: const EdgeInsets.only(bottom: 8),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(color: Colors.grey[100], borderRadius: BorderRadius.circular(5), border: Border.all(color: Colors.grey[300]!)),
              child: Text(category.toUpperCase(), style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.black54)),
            ),

          if (headline != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(headline, style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 16, height: 1.2)),
            ),

          // Content
          Text.rich(
            TextSpan(
              style: const TextStyle(fontSize: 15, height: 1.4, color: Colors.black87),
              children: content,
            ),
          ),

          const SizedBox(height: 12),

          // Gambar
          if (showImage)
            Container(
              height: 200, width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(contentImageUrl ?? "https://images.unsplash.com/photo-1579621970563-ebec7560ff3e?ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=80"),
                ),
              ),
            ),

          const SizedBox(height: 15),
          
          // 👇 GARIS PEMISAH DIPERTEBAL DI SINI (Thickness 1.0)
          Divider(color: Colors.grey[300], thickness: 1.0),
          
          const SizedBox(height: 5),

          // Footer
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween, 
                  children: [
                    _interactionIcon(Icons.favorite_border, "5.000"),       
                    _interactionIcon(Icons.chat_bubble_outline, "10.000"),  
                    _interactionIcon(Icons.remove_red_eye_outlined, "15.000"), 
                    _interactionIcon(Icons.cached, "8.000"),                
                  ],
                ),
              ),
              const SizedBox(width: 20), 
              const Row(
                children: [
                  Icon(Icons.bookmark_border, size: 24, color: Colors.black87),
                  SizedBox(width: 15),
                  Icon(Icons.send_outlined, size: 24, color: Colors.black87), 
                ],
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _interactionIcon(IconData icon, String count) {
    return Row(
      children: [
        Icon(icon, size: 20, color: Colors.black87),
        const SizedBox(width: 4),
        Text(count, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Colors.black87)),
      ],
    );
  }
}