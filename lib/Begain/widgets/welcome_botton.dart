import 'package:flutter/material.dart';
//import 'package:myapp/screens/signup_screen.dart';

class WelcomeBotton extends StatelessWidget {
  const WelcomeBotton({super.key, 
  this.buttonText,
   this.onTap, 
   this.color,
    this.textColor});
    
  final String? buttonText;
  final Widget? onTap;
  final Color? color;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (e) => onTap!,
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(30),
        margin: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 10,
        ),
        decoration:  BoxDecoration(
            color: color!,
            // Suggested code may be subject to a license. Learn more: ~LicenseLog:3271410784.
            borderRadius:const BorderRadius.only(
              topLeft: Radius.circular(50),
            )),
        child: Text(
          buttonText!,
          textAlign: TextAlign.center,
          style:  TextStyle(
            color: textColor!,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
