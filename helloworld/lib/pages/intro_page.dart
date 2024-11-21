import "package:flutter/material.dart";
import "package:helloworld/pages/home_page.dart";

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //logo
              Padding(
                padding: const EdgeInsets.all(25.0),
                child: Image.asset(
                  'lib/assets/logo.png',
                  height: 240
                ),
              ),
          
              //title
              const Text(
                'Hello, welcome to',
                style: TextStyle(
                  fontSize: 20,
                 ),
                ),
              
              const SizedBox(height: 12),
          
              //title
              const Text(
                'SnapBasket',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 40,
                 ),
                ),
              
              const SizedBox(height: 24),
          
              //sub title
              const Text(
                'Organize your shopping effortlessly and intelligently',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                 ),
                 textAlign: TextAlign.center,
                ),
          
              const SizedBox(height: 48),

              //start now button
              GestureDetector(
                onTap: () => Navigator.push(
                  context, 
                  MaterialPageRoute(
                    builder: (context) => const HomePage(), 
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.red.shade600,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.all(25),
                  child: const Center(
                    child: Text(
                      'Start now',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,  
                      )
                      ),
                  ),
                ),
              )
            ],
          ),
        ),
      )
      );
  }}
