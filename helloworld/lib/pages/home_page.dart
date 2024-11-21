import 'package:flutter/material.dart';
import 'package:helloworld/pages/intro_page.dart';

import 'package:helloworld/components/bottom_nav_bar.dart';
import 'package:helloworld/pages/list_page.dart';
import 'package:helloworld/pages/first_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  void navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _pages = [
    const FirstPage(),
    const ListPage(),
    const ListPage(),
    const ListPage(),
    const ListPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      bottomNavigationBar: MyBottomNavBar(
        onTabChange: (index) => navigateBottomBar(index),
      ),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: const Padding(
                padding: EdgeInsets.only(left: 12.0),
                child: Icon(
                  Icons.menu,
                  color: Colors.black,
                ),
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        actions: [
          Builder(
            builder: (context) {
              return IconButton(
                icon: const Padding(
                  padding: EdgeInsets.only(right: 12.0),
                  child: Icon(
                    Icons.notifications_rounded,
                    color: Colors.black,
                  ),
                ),
                onPressed: () {
                  Scaffold.of(context).openEndDrawer();
                },
              );
            },
          ),
        ],
        flexibleSpace: const Padding(
          padding: EdgeInsets.only(top: 15.0),
          child: Center(
            child: Text(
              "SnapBasket",
              style: TextStyle(
                fontSize: 40,
                fontFamily: "Times New Roman",
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
      drawer: Drawer(
        backgroundColor: Colors.black,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                DrawerHeader(
                  child: Image.asset(
                    'lib/assets/logo.png',
                    color: Colors.white,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 25.0),
                  child: ListTile(
                    leading: Icon(Icons.home, color: Colors.white),
                    title: Text('Home', style: TextStyle(color: Colors.white)),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 25.0),
                  child: ListTile(
                    leading: Icon(Icons.info, color: Colors.white),
                    title: Text('About', style: TextStyle(color: Colors.white)),
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 25.0, bottom: 25),
                  child: ListTile(
                    leading: const Icon(Icons.logout, color: Colors.white),
                    title: const Text('Logout', style: TextStyle(color: Colors.white)),
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const IntroPage()),
                      );
                    }, // TODO dare conferma prima di effettuare il logout
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      endDrawer: const Drawer(
        backgroundColor: Colors.black,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                // Aggiungi i contenuti del drawer destro qui
                Padding(
                  padding: EdgeInsets.only(left: 25.0),
                  child: ListTile(
                    leading: Icon(Icons.settings, color: Colors.white),
                    title: Text('Settings', style: TextStyle(color: Colors.white)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      body: _pages[_selectedIndex],
    );
  }
}