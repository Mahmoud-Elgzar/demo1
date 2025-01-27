import 'package:flutter/material.dart';

class CustomScaffold extends StatelessWidget {
  const CustomScaffold({super.key,  this.child});
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
// Suggested code may be subject to a license. Learn more: ~LicenseLog:1964644190.
        children: [
          //Container(
           // decoration: const BoxDecoration(
             // image: DecorationImage(
              //  image: AssetImage('assets/images/bg1.jpg'),
              //  fit: BoxFit.cover,
            //  ),
           // ),

             Image.asset(
              'assets/images/bg1.jpg',
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
         // ),
           SafeArea(child: child!,
          ),
        ],
      ),
    
    
    );
  }
}
  