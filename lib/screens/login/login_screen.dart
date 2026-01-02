import 'package:flutter/material.dart';
import '../../core/app_colors.dart';
import '../../repositories/auth_repository.dart';
import 'resident_login_screen.dart'; // Ensure these files exist
import 'security_login_screen.dart'; // Ensure these files exist
import '../home/home_admin.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _suidController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordVisible = false;
  final AuthRepository _authRepo = AuthRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.backgroundDark, AppColors.backgroundLight],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: 60),
            _buildLogoHeader(),
            const SizedBox(height: 30),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                ),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 30,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildDemoInfo(),
                      const SizedBox(height: 25),
                      _customLabel("Society Unique ID (SUID)"),
                      _customTextField(
                        _suidController,
                        "Enter Society ID",
                        Icons.business,
                      ),
                      const SizedBox(height: 20),
                      _customLabel("Username"),
                      _customTextField(
                        _usernameController,
                        "Enter username",
                        Icons.person_outline,
                      ),
                      const SizedBox(height: 20),
                      _customLabel("Password"),
                      _passwordField(),
                      _rememberMeRow(),
                      const SizedBox(height: 25),
                      _primaryButton("Login to Dashboard"),
                      _orDivider(),
                      _secondaryButton(
                        "Login as Resident",
                        () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ResidentLoginScreen(),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      _secondaryButton(
                        "Login as Security",
                        () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SecurityLoginScreen(),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      _footerSection(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- Widget Components ---

  Widget _buildLogoHeader() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: const Icon(
            Icons.shield_outlined,
            size: 48,
            color: AppColors.primaryBlue,
          ),
        ),
        const SizedBox(height: 12),
        const Text(
          "ProSocSecure",
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Text(
          "Society Management",
          style: TextStyle(color: Colors.white70, fontSize: 14),
        ),
        const SizedBox(height: 15),
        const Text(
          "Society Admin Login",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        const Text(
          "Access your society management dashboard",
          style: TextStyle(color: Colors.white54, fontSize: 13),
        ),
      ],
    );
  }

  Widget _buildDemoInfo() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.demoBoxBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.demoBoxBorder),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Demo Credentials:",
            style: TextStyle(
              color: Colors.blue,
              fontWeight: FontWeight.bold,
              fontSize: 13,
            ),
          ),
          Text(
            "SUID: GFS001",
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
          ),
          Text(
            "Username: admin",
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
          ),
          Text(
            "Password: admin123",
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }

  Widget _customLabel(String label) => Padding(
    padding: const EdgeInsets.only(bottom: 8.0),
    child: Text(
      label,
      style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
    ),
  );

  Widget _customTextField(
    TextEditingController ctrl,
    String hint,
    IconData icon,
  ) {
    return TextFormField(
      controller: ctrl,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.grey, size: 20),
        hintText: hint,
        filled: true,
        fillColor: AppColors.inputFill,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _passwordField() {
    return TextFormField(
      controller: _passwordController,
      obscureText: !_isPasswordVisible,
      decoration: InputDecoration(
        prefixIcon: const Icon(
          Icons.lock_outline,
          color: Colors.grey,
          size: 20,
        ),
        suffixIcon: IconButton(
          icon: Icon(
            _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
            color: Colors.grey,
            size: 20,
          ),
          onPressed:
              () => setState(() => _isPasswordVisible = !_isPasswordVisible),
        ),
        hintText: "Enter password",
        filled: true,
        fillColor: AppColors.inputFill,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _rememberMeRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            SizedBox(
              width: 24,
              child: Checkbox(
                value: false,
                onChanged: (v) {},
                activeColor: AppColors.primaryBlue,
              ),
            ),
            const Text(
              " Remember me",
              style: TextStyle(fontSize: 13, color: Colors.black87),
            ),
          ],
        ),
        TextButton(
          onPressed: () {},
          child: const Text(
            "Forgot password?",
            style: TextStyle(color: AppColors.primaryBlue, fontSize: 13),
          ),
        ),
      ],
    );
  }

  Widget _primaryButton(String text) => SizedBox(
    width: double.infinity,
    height: 55,
    child: ElevatedButton(
      onPressed: () {
        // BYPASS: Direct navigation to HomeAdmin
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const HomeAdmin()),
          (route) => false, // This removes all previous screens from the stack
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryBlue,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 0,
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );

  Widget _orDivider() => Padding(
    padding: const EdgeInsets.symmetric(vertical: 20),
    child: Row(
      children: [
        const Expanded(child: Divider()),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text("or", style: TextStyle(color: Colors.grey.shade400)),
        ),
        const Expanded(child: Divider()),
      ],
    ),
  );

  // UPDATED: Now accepts a callback function for navigation
  Widget _secondaryButton(String text, VoidCallback onPressed) => SizedBox(
    width: double.infinity,
    height: 50,
    child: OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        side: const BorderSide(color: Colors.black12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
  );

  Widget _footerSection() => Center(
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Don't have an account? ",
              style: TextStyle(fontSize: 13),
            ),
            GestureDetector(
              onTap: () {},
              child: const Text(
                "Register your society",
                style: TextStyle(
                  color: AppColors.primaryBlue,
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 25),
        const Text(
          "© 2025 ProSocSecure. All rights reserved.",
          style: TextStyle(fontSize: 12, color: Colors.grey),
        ),
      ],
    ),
  );
}
