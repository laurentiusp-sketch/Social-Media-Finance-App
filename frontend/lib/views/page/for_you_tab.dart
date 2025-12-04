import 'package:flutter/material.dart';

class ForYouTab extends StatelessWidget {
  const ForYouTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // FEED 1 (TEKNOLOGI / AI)
        _buildTwitterIGCard(
          name: "Sam Altman", 
          handle: "@sama", 
          time: "1h", 
          category: "Technology",
          headline: "AGI is coming sooner than you think.",
          content: [
            const TextSpan(text: "Just saw the latest model benchmark. The reasoning capability is off the charts. We are entering a new era of human-machine collaboration. 🤖✨"),
          ],
          avatarUrl: "https://i.pravatar.cc/150?img=60", 
          contentImageUrl: "https://images.unsplash.com/photo-1620712943543-bcc4688e7485?q=80&w=1000&auto=format&fit=crop"
        ),
        
        const SizedBox(height: 20),
        
        // FEED 2 (TRAVEL)
        _buildTwitterIGCard(
          name: "Wonderful Indonesia", 
          handle: "@pesonaindonesia", 
          time: "4h", 
          category: "Travel",
          headline: "Hidden Gem: Sumba, Nusa Tenggara Timur 🏝️",
          content: [
            const TextSpan(text: "Siapa yang butuh healing? 🌊\n"),
            const TextSpan(text: "Sumba menawarkan keindahan savana yang eksotis dan pantai yang masih sangat alami. Wajib masuk bucket list tahun ini! \n\n"),
            const TextSpan(
              text: "#DiIndonesiaAja", 
              style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)
            ),
          ],
          showImage: true,  
          avatarUrl: "https://i.pravatar.cc/150?img=20",
          contentImageUrl: "https://images.unsplash.com/photo-1596423736737-11d4da0306bb?q=80&w=1000&auto=format&fit=crop"
        ),

        const SizedBox(height: 20),

        // FEED 3 (GAMING)
        _buildTwitterIGCard(
          name: "Tech Setup War", 
          handle: "@setup_wars", 
          time: "8h", 
          category: "Gaming",
          headline: null, 
          content: [
            const TextSpan(text: "Rate this minimalist setup from 1 to 10! 🔥\n\n", style: TextStyle(fontWeight: FontWeight.bold)),
            const TextSpan(text: "Specs:\n- RTX 5090\n- Intel Core Ultra 9\n- 64GB RAM DDR5"),
          ],
          avatarUrl: "https://i.pravatar.cc/150?img=15",
          contentImageUrl: "https://images.unsplash.com/photo-1593640408182-31c70c8268f5?q=80&w=1000&auto=format&fit=crop"
        ),

        const SizedBox(height: 20),

        // FEED 4 (MOTIVASI)
        _buildTwitterIGCard(
          name: "Daily Stoic", 
          handle: "@dailystoic", 
          time: "1d", 
          category: "Mindset",
          headline: "Focus on what you can control.",
          content: [
            const TextSpan(text: "You have power over your mind - not outside events. Realize this, and you will find strength.\n\n"),
            const TextSpan(
              text: "- Marcus Aurelius", 
              style: TextStyle(fontStyle: FontStyle.italic, fontWeight: FontWeight.bold, color: Colors.black54)
            ),
          ],
          showImage: false, 
          avatarUrl: "https://i.pravatar.cc/150?img=50",
          contentImageUrl: null
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

          Text.rich(
            TextSpan(
              style: const TextStyle(fontSize: 15, height: 1.4, color: Colors.black87),
              children: content,
            ),
          ),

          const SizedBox(height: 12),

          if (showImage)
            Container(
              height: 200, width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(contentImageUrl ?? "https://picsum.photos/200/300"),
                ),
              ),
            ),

          const SizedBox(height: 15),
          
          // 👇 GARIS PEMISAH DIPERTEBAL DI SINI JUGA
          Divider(color: Colors.grey[300], thickness: 1.0),
          
          const SizedBox(height: 5),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween, 
                  children: [
                    _interactionIcon(Icons.favorite_border, "24k"),       
                    _interactionIcon(Icons.chat_bubble_outline, "452"),  
                    _interactionIcon(Icons.remove_red_eye_outlined, "1.2M"), 
                    _interactionIcon(Icons.cached, "5k"),                
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