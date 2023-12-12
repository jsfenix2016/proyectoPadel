import 'package:flutter/material.dart';

class LogoCustomApp extends StatelessWidget {
  const LogoCustomApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      heightFactor: 1,
      child: Padding(
        padding: const EdgeInsets.only(left: 12.0, right: 12),
        child: SizedBox(
          child: Image.asset(
            fit: BoxFit.fill,
            scale: 0.5,
            'assets/images/logo.png',
            height: 70,
            width: double.infinity,
          ),
        ),
      ),
    );
  }
}
