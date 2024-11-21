import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class MyBottomNavBar extends StatelessWidget {
  final void Function(int)? onTabChange;
  const MyBottomNavBar({super.key, required this.onTabChange});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      //padding: const EdgeInsets.symmetric(vertical: 10),
      height: 55,
      child: GNav(
        color: Colors.white,
        backgroundColor: Colors.grey,
        activeColor: Colors.grey.shade700,
        tabActiveBorder: Border.all(color: Colors.white),
        tabBackgroundColor: Colors.grey.shade100,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        tabBorderRadius: 12,
        gap: 6,
        onTabChange: (value) => onTabChange!(value),
        tabs: const[
          GButton(
            padding: EdgeInsets.all(7),
            icon: Icons.home,
            text: 'Home',
            ),
          GButton(
            padding: EdgeInsets.all(7),
            icon: Icons.checklist_rounded, //TODO cambiare icona in 3 righe
            text: 'Lists', 
          ),
          GButton(
            padding: EdgeInsets.all(7),
            icon: Icons.document_scanner_outlined,
            text: 'Scanner',
          ),
          GButton(
            padding: EdgeInsets.all(7),
            icon: Icons.euro_rounded, //TODO cambiare icona
            text: 'Budget', 
          ),
          GButton(
          padding: EdgeInsets.all(7),
            icon: Icons.receipt_long_rounded,
            text: 'Receipts', 
          ),
        ],
      ),
    );
  }
}