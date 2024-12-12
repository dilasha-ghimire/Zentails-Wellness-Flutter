import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
// Import the dashboard view with an alias to avoid naming conflicts
import 'package:zentails_wellness/view/dashboard_screen/dashboard_view.dart'
    as dashboard;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Controllers for the email/phone and password input fields
  TextEditingController emailOrPhoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF5D4037),
      body: SingleChildScrollView(
        // Make the body scrollable
        child: _page(), // Call the method that builds the main page content
      ),
    );
  }

  Widget _page() {
    // Create a main container for the login form
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _lottieAnimation(), // Display a Lottie animation
            const SizedBox(height: 10),
            const Text(
              "Welcome!",
              style: TextStyle(
                fontFamily: 'GreatVibes',
                fontSize: 48,
                color: Color(0xFFFCF5D7), // Text color
              ),
            ),
            const SizedBox(height: 30),
            // Input fields for email/phone and password
            _inputField("Email or Phone Number", emailOrPhoneController),
            const SizedBox(height: 20),
            _inputField("Password", passwordController, isPassword: true),
            const SizedBox(height: 50),
            _loginBtn(), // Button to trigger the login action
            const SizedBox(height: 30),
            _extraText(), // Additional text for account recovery
            const SizedBox(height: 10),
            _signUpBtn(), // Button to navigate to sign-up
            const SizedBox(height: 30),
            _loginDivider(), // Divider for visual separation
            const SizedBox(height: 20),
            _googleLoginBtn(), // Button for Google sign-in
          ],
        ),
      ),
    );
  }

  Widget _lottieAnimation() {
    // Display Lottie animation for visual appeal
    return SizedBox(
      height: 200,
      width: 1800,
      child: Lottie.asset(
          'assets/Lottie/login_scene.json'), // Path to Lottie asset
    );
  }

  Widget _inputField(String hintText, TextEditingController controller,
      {isPassword = false}) {
    // Define the border style for input fields
    var border = OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: const BorderSide(color: Color(0xFFFCF5D7)));

    return TextField(
      style: const TextStyle(color: Color(0xFFFCF5D7)), // Text color
      controller: controller, // Assign the controller
      decoration: InputDecoration(
        hintText: hintText, // Placeholder text
        hintStyle: const TextStyle(color: Color(0xFFFCF5D7)), // Hint text color
        enabledBorder: border, // Style for the border when the field is enabled
        focusedBorder: border, // Style for the border when the field is focused
      ),
      obscureText: isPassword, // Hide text if it's a password field
    );
  }

  Widget _loginBtn() {
    return ElevatedButton(
      onPressed: () {
        // Hardcoded login validation
        if (emailOrPhoneController.text == 'admin@admin.com' &&
            passwordController.text == 'admin@123') {
          // Navigate to DashboardView on successful login
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    const dashboard.DashboardView()), // Use the dashboard alias
          );
        } else {
          // Show a snackbar with an error message if login fails
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Invalid email or password'), // Error message
              backgroundColor: Colors.red, // Snackbar background color
            ),
          );
        }
      },
      style: ElevatedButton.styleFrom(
        foregroundColor: const Color(0xFF5D4037),
        backgroundColor: const Color(0xFFFCF5D7),
        shape: const StadiumBorder(),
        padding: const EdgeInsets.symmetric(vertical: 16), // Button padding
      ),
      child: const SizedBox(
          width: double.infinity,
          child: Text(
            "Sign in", // Button text
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20),
          )),
    );
  }

  Widget _extraText() {
    return const Text(
      "Can't access your account?", // Additional text for account help
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 16, color: Color(0xFFFCF5D7)), // Text color
    );
  }

  Widget _signUpBtn() {
    return GestureDetector(
      onTap: () {
        debugPrint("Sign Up tapped"); // Debug log for sign-up button
      },
      child: const Text(
        "Sign Up", // Text for sign-up button
        style: TextStyle(
          fontSize: 16,
          color: Color(0xFFFCF5D7),
          decoration: TextDecoration.underline, // Underline the text
          decorationColor: Color(0xFFFCF5D7),
        ),
      ),
    );
  }

  Widget _loginDivider() {
    return const Row(
      children: [
        Expanded(
          child: Divider(
            color: Color(0xFFFCF5D7), // Divider color
            thickness: 1, // Divider thickness
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            "or else login with", // Text to explain alternative login
            style:
                TextStyle(fontSize: 16, color: Color(0xFFFCF5D7)), // Text color
          ),
        ),
        Expanded(
          child: Divider(
            color: Color(0xFFFCF5D7), // Divider color
            thickness: 1, // Divider thickness
          ),
        ),
      ],
    );
  }

  Widget _googleLoginBtn() {
    return ElevatedButton(
      onPressed: () {
        debugPrint(
            "Continue with Google tapped"); // Debug log for Google button
      },
      style: ElevatedButton.styleFrom(
        foregroundColor: const Color(0xFF5D4037),
        backgroundColor: const Color(0xFFFCF5D7),
        shape: const StadiumBorder(),
        padding: const EdgeInsets.symmetric(vertical: 16), // Button padding
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/icons/google.svg', // Path to Google icon
            height: 24,
            width: 24,
          ),
          const SizedBox(width: 8), // Space between icon and text
          const Text(
            "Continue with Google", // Button text
            style: TextStyle(fontSize: 18),
          ),
        ],
      ),
    );
  }
}