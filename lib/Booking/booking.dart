// ignore_for_file: use_build_context_synchronously

import 'package:demo1/Booking/flights.dart';
import 'package:demo1/booking/hotels.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomeBooking(),
    );
  }
}

class HomeBooking extends StatelessWidget {
  const HomeBooking({super.key});

  // Navigation helper function with loading indicator and transitions
  Future<void> _navigateToPage(BuildContext context, Widget page) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) =>
          const Center(child: CircularProgressIndicator()),
    );
    await Future.delayed(const Duration(milliseconds: 300)); // Simulated delay
    Navigator.pop(context); // Close loading dialog
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => page,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.easeInOut;
          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          var offsetAnimation = animation.drive(tween);
          return SlideTransition(position: offsetAnimation, child: child);
        },
      ),
    );
  }

  // Reusable button widget
  Widget _buildNavigationButton({
    required BuildContext context,
    required String label,
    required IconData icon,
    required Widget targetPage,
  }) {
    return InkWell(
      onTap: () {
        HapticFeedback.lightImpact(); // Haptic feedback on tap
        _navigateToPage(context, targetPage);
      },
      borderRadius: BorderRadius.circular(15),
      child: Container(
        width: 270,
        height: 130,
        margin: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: const Color(0xFFEAE4DD),
          borderRadius: BorderRadius.circular(15),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 50, color: Colors.black87),
            const SizedBox(height: 8),
            Text(
              label,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFE1D7C6), Color(0xFF295F98)],
            begin: Alignment(0.9, -0.5),
            end: Alignment(-0.9, 0.5),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(height: 60), // Increased top padding for spacing
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildNavigationButton(
                  context: context,
                  label: 'Hotels',
                  icon: Icons.apartment,
                  targetPage: HotelsPage(),
                ),
                _buildNavigationButton(
                  context: context,
                  label: 'Flights',
                  icon: Icons.flight,
                  targetPage: FlightsPage(),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  width: 65,
                  height: 65,
                  decoration: const BoxDecoration(
                    color: Color(0xFFCDC2A5),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 8,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child:
                      const Icon(Icons.home, size: 40, color: Colors.black87),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
