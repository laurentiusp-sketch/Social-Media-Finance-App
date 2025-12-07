import 'package:fintech_app2/views/page/chat_page.dart';
import 'package:fintech_app2/views/page/profile_page.dart';
import 'package:fintech_app2/controllers/auth/auth_service.dart';
import 'package:fintech_app2/main.dart';
import 'package:flutter/material.dart';
import '../../../../views/page/colors.dart';
import '../../../../views/page/finance_literacy_tab.dart';
import '../../../../views/page/for_you_tab.dart';
import '../../../../views/page/explore_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  int _bottomNavIndex = 0;
  int _homeTabIndex = 0;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Widget _selectedMainPage() {
    final pages = [
      _buildHomeView(),
      const ExplorePage(),
      const ChatPage(),
      const ProfilePage(),
    ];

    return pages[_bottomNavIndex];
  }

  Future<void> _handleLogout() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.primaryBackground,
          title: const Text('Logout', style: TextStyle(color: Colors.white)),
          content: const Text(
            'Are you sure you want to logout?',
            style: TextStyle(color: Colors.white70),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text(
                'Cancel',
                style: TextStyle(color: Colors.white70),
              ),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
                try {
                  await AuthService().signOut();
                  if (mounted) {
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => const MyApp()),
                      (Route<dynamic> route) => false,
                    );
                  }
                } catch (e) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text('Logout failed: $e')));
                }
              },
              child: const Text(
                'Logout',
                style: TextStyle(color: Colors.redAccent),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBackground,
      body: Stack(
        children: [
          _selectedMainPage(),

          // ADD BUTTON (ONLY ON HOME)
          if (_bottomNavIndex == 0)
            Positioned(
              right: 30,
              bottom: 135,
              child: FloatingActionButton(
                onPressed: () {},
                backgroundColor: Colors.white,
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const Icon(
                  Icons.add,
                  color: AppColors.primaryBackground,
                  size: 30,
                ),
              ),
            ),

          _buildBottomNav(),
        ],
      ),
    );
  }

  Widget _buildHomeView() {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 30),
            _buildHeader(),
            const SizedBox(height: 25),
            _buildStories(),
            const SizedBox(height: 25),
            _buildHomeTabs(),
            const SizedBox(height: 25),
            _homeTabIndex == 0 ? const FinanceLiteracyTab() : const ForYouTab(),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }

  Widget _buildHomeTabs() {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: [
          _buildTabButton("Finance Literacy", 0),
          _buildTabButton("For You", 1),
        ],
      ),
    );
  }

  Widget _buildTabButton(String text, int index) {
    bool isActive = _homeTabIndex == index;

    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _homeTabIndex = index),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isActive
                ? Colors.white.withOpacity(0.2)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(30),
            border: isActive ? Border.all(color: Colors.white12) : null,
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                color: isActive ? Colors.white : Colors.white60,
                fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                fontSize: 14,
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ----------------------------
  // BOTTOM NAVIGATION BAR
  // ----------------------------
  Widget _buildBottomNav() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        margin: const EdgeInsets.only(bottom: 50, left: 30, right: 30),
        height: 60,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(40),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 15,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildNavIcon(Icons.home_filled, 0),
            _buildNavIcon(Icons.search, 1),
            _buildNavIcon(Icons.send_rounded, 2),
            _buildNavIcon(Icons.person_outline, 3),
          ],
        ),
      ),
    );
  }

  Widget _buildNavIcon(IconData icon, int index) {
    bool isActive = _bottomNavIndex == index;

    return GestureDetector(
      onTap: () => setState(() => _bottomNavIndex = index),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: isActive ? AppColors.primaryBackground : Colors.transparent,
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          color: isActive ? Colors.white : Colors.grey,
          size: isActive ? 24 : 28,
        ),
      ),
    );
  }

  // ----------------------------
  // HEADER
  // ----------------------------
  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Finegram",
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
                fontFamily: 'Serif',
              ),
            ),
            Text(
              "Good Morning, Putra",
              style: TextStyle(
                color: Colors.white.withOpacity(0.7),
                fontSize: 12,
              ),
            ),
          ],
        ),
        Row(
          children: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.settings, color: Colors.white, size: 28),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.notifications_outlined,
                color: Colors.white,
                size: 28,
              ),
            ),
            IconButton(
              onPressed: _handleLogout,
              icon: const Icon(Icons.logout, color: Colors.white, size: 28),
            ),
          ],
        ),
      ],
    );
  }

  // ----------------------------
  // STORIES
  // ----------------------------
  Widget _buildStories() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildMyStatusItem(),
          const SizedBox(width: 10),
          _buildAnimatedStoryItem(
            "Mike Khowzaski",
            "https://media.tenor.com/KUXIWC9D5_UAAAAi/my-hero-academia-boku-no-hero-academia.gif",
            isUnread: true,
          ),
          _buildAnimatedStoryItem(
            "Together Cinematic Production",
            "https://lh3.googleusercontent.com/a/ACg8ocIZSepz8g3knglAh35qDVpFXy5Alla_KlV87mT5If1AgmioCDI=s317-c-no",
            isUnread: true,
          ),
          _buildAnimatedStoryItem(
            "Matthew",
            "https://i.pravatar.cc/150?img=11",
          ),
        ],
      ),
    );
  }

  Widget _buildMyStatusItem() {
    return Container(
      width: 95,
      margin: const EdgeInsets.only(right: 5),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white30, width: 2),
                ),
              ),
              Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primaryBackground,
                  border: Border.all(
                    color: AppColors.primaryBackground,
                    width: 4,
                  ),
                ),
                child: const CircleAvatar(
                  backgroundImage: NetworkImage(
                    "https://i.pravatar.cc/150?img=12",
                  ),
                ),
              ),
              Positioned(
                bottom: 2,
                right: 2,
                child: Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColors.primaryBackground,
                      width: 2.5,
                    ),
                  ),
                  child: const Icon(Icons.add, color: Colors.white, size: 18),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            "Your Story",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white70, fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _buildAnimatedStoryItem(
    String name,
    String imageUrl, {
    bool isUnread = false,
  }) {
    return Container(
      width: 95,
      margin: const EdgeInsets.only(right: 5),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              isUnread
                  ? RotationTransition(
                      turns: _animationController,
                      child: Container(
                        width: 80,
                        height: 80,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: SweepGradient(
                            colors: [
                              Color.fromARGB(255, 39, 160, 176),
                              Color.fromARGB(255, 54, 244, 149),
                              Color.fromARGB(255, 0, 102, 255),
                              Color.fromARGB(255, 110, 39, 176),
                              Color.fromARGB(255, 39, 160, 176),
                            ],
                          ),
                        ),
                      ),
                    )
                  : Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.grey, width: 2),
                      ),
                    ),
              Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primaryBackground,
                  border: Border.all(
                    color: AppColors.primaryBackground,
                    width: 4,
                  ),
                ),
                child: CircleAvatar(backgroundImage: NetworkImage(imageUrl)),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            name,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white, fontSize: 12),
          ),
        ],
      ),
    );
  }
}
