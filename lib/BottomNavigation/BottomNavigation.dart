import 'package:flutter/material.dart';
import 'package:innerbhakti/Pages/Display_song/display_songs.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const DisplayScreen(),
    Center(child: Text('Explore Page')),
    Center(child: Text('Me Page')),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title:
              const Text("InnerBhakti", style: TextStyle(color: Colors.orange)),
          backgroundColor: Colors.white,
          elevation: 0,
          leading: const Icon(Icons.menu, color: Colors.orange),
          actions: const [
            Icon(Icons.notifications_none, color: Colors.orange),
            SizedBox(width: 10),
            Icon(Icons.add, color: Colors.orange),
            SizedBox(width: 10),
          ],
        ),
        body: _pages[_currentIndex],
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(12),
          child: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(30)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  spreadRadius: 5,
                  blurRadius: 10,
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(30)),
              child: BottomNavigationBar(
                backgroundColor: Colors.orange,
                currentIndex: _currentIndex,
                onTap: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
                selectedItemColor: Colors.black,
                unselectedItemColor: Colors.white,
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.menu_book),
                    label: 'Guide',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.explore),
                    label: 'Explore',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.person),
                    label: 'Me',
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
