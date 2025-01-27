// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HotelsPage(),
    );
  }
}

class HotelsPage extends StatelessWidget {
  // List of hotel booking sites with their respective image URLs and target URLs
  final List<Map<String, String>> hotelData = [
    {
      'name': 'Booking.com',
      'image': 'assets/images/Booking.png',
      'url': 'https://www.booking.com'
    },
    {
      'name': 'Expedia',
      'image': 'assets/images/Expedia.png',
      'url': 'https://www.expedia.com'
    },
    {
      'name': 'Hotels.com',
      'image': 'assets/images/Hotelscom.png',
      'url': 'https://www.hotels.com'
    },
    {
      'name': 'Airbnb',
      'image': 'assets/images/Airbnb.png',
      'url': 'https://www.airbnb.com'
    },
  ];

  HotelsPage({super.key});

  // Function to open a URL
  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
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
            const SizedBox(height: 40), // Optional spacing from the top
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 0.85, // Adjust as needed
                  ),
                  itemCount: hotelData.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () => _launchURL(hotelData[index]['url']!),
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFFEAE4DD),
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 6,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(
                                hotelData[index]['image']!,
                                width: 80, // Adjust image size as needed
                                height: 80,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              hotelData[index]['name']!,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  width: 60,
                  height: 60,
                  decoration: const BoxDecoration(
                    color: Color(0xFFCDC2A5),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 6,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child:
                      const Icon(Icons.home, size: 36, color: Colors.black87),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
