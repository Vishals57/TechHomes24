import 'package:flutter/material.dart';
import '../../core/app_colors.dart';
import 'login_screen.dart';
import '../home/home_resident.dart';

class ResidentLoginScreen extends StatefulWidget {
  const ResidentLoginScreen({super.key});

  @override
  State<ResidentLoginScreen> createState() => _ResidentLoginScreenState();
}

class _ResidentLoginScreenState extends State<ResidentLoginScreen> {
  final _societyIdController = TextEditingController();
  final _flatController = TextEditingController();
  final _mobileController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _isPasswordTab = true; // Toggle between Password and OTP tabs

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
            _buildHeader(),
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
                      _buildTabSwitcher(), // Password/OTP toggle
                      const SizedBox(height: 25),
                      _buildDemoInfo(), //
                      const SizedBox(height: 25),
                      _customLabel("Society ID"),
                      _customTextField(
                        _societyIdController,
                        "Enter Society ID",
                        Icons.business,
                      ),
                      const SizedBox(height: 20),
                      _customLabel("Flat Number"),
                      _customTextField(
                        _flatController,
                        "e.g., A-301",
                        Icons.person_outline,
                      ),
                      const SizedBox(height: 20),
                      _customLabel("Mobile Number"),
                      _customTextField(
                        _mobileController,
                        "+91 98765 43210",
                        Icons.phone_android_outlined,
                      ),
                      const SizedBox(height: 20),
                      _customLabel("Password"),
                      _passwordField(),
                      _rememberMeRow(),
                      const SizedBox(height: 25),
                      _primaryButton("Login"), //
                      _orLoginAsDivider(),
                      _secondaryButton("Society Admin", () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginScreen(),
                          ),
                        );
                      }),
                      const SizedBox(height: 30),
                      _footerHelpText(),
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

  Widget _buildHeader() {
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
          "Resident Portal",
          style: TextStyle(color: Colors.white70, fontSize: 14),
        ),
        const SizedBox(height: 15),
        const Text(
          "Resident Login",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        const Text(
          "Access your community portal",
          style: TextStyle(color: Colors.white54, fontSize: 13),
        ),
      ],
    );
  }

  Widget _buildTabSwitcher() {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: AppColors.inputFill,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            child: _tabItem(
              "Password",
              _isPasswordTab,
              () => setState(() => _isPasswordTab = true),
            ),
          ),
          Expanded(
            child: _tabItem(
              "OTP",
              !_isPasswordTab,
              () => setState(() => _isPasswordTab = false),
            ),
          ),
        ],
      ),
    );
  }

  Widget _tabItem(String title, bool isActive, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: isActive ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          boxShadow:
              isActive
                  ? [const BoxShadow(color: Colors.black12, blurRadius: 4)]
                  : [],
        ),
        alignment: Alignment.center,
        child: Text(
          title,
          style: TextStyle(
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
            color: Colors.black87,
          ),
        ),
      ),
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
              fontSize: 12,
            ),
          ),
          Text(
            "Society: GFS001",
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
          ),
          Text(
            "Flat: A-301",
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
          ),
          Text(
            "Mobile: 9876543210",
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
          ),
          Text(
            "Password: resident123",
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
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
            Checkbox(
              value: false,
              onChanged: (v) {},
              activeColor: AppColors.primaryBlue,
            ),
            const Text("Remember me", style: TextStyle(fontSize: 13)),
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
        // BYPASS: Direct navigation to HomeResident
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const HomeResident()),
          (route) => false,
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

  Widget _orLoginAsDivider() => Padding(
    padding: const EdgeInsets.symmetric(vertical: 20),
    child: Row(
      children: [
        const Expanded(child: Divider()),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            "or login as",
            style: TextStyle(color: Colors.grey.shade400, fontSize: 13),
          ),
        ),
        const Expanded(child: Divider()),
      ],
    ),
  );

  Widget _secondaryButton(String text, VoidCallback onTap) => SizedBox(
    width: double.infinity,
    height: 50,
    child: OutlinedButton(
      onPressed: onTap,
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

  Widget _footerHelpText() => Center(
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Need help logging in? ",
              style: TextStyle(fontSize: 13),
            ),
            GestureDetector(
              onTap: () {},
              child: const Text(
                "Contact your society admin",
                style: TextStyle(color: AppColors.primaryBlue, fontSize: 13),
              ),
            ),
          ],
        ),
        const SizedBox(height: 25),
        const Text(
          "← Back to Home",
          style: TextStyle(color: Colors.grey, fontSize: 13),
        ),
      ],
    ),
  );
}
