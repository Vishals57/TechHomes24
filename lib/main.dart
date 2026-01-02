import 'package:flutter/material.dart';
import 'screens/login/login_screen.dart';

void main() {
  runApp(const ProSocSecureApp());
}

class ProSocSecureApp extends StatelessWidget {
  const ProSocSecureApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ProSocSecure',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Inter', // Or whichever font your Figma uses
      ),
      home: const LoginScreen(),
    );
  }
}
