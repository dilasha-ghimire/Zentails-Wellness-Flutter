import 'package:flutter/material.dart';
import 'package:zentails_wellness/view/authentication_screen/login_view.dart'; // Importing LoginView

class RegistrationView extends StatefulWidget {
  const RegistrationView({super.key});

  @override
  State<RegistrationView> createState() => _RegistrationViewState();
}

class _RegistrationViewState extends State<RegistrationView> {
  // Controllers for registration input fields
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController contactNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF5D4037),
      body: Center(
        // Center the entire body
        child: SingleChildScrollView(
          child: _page(), // Call the method to build the main content
        ),
      ),
    );
  }

  Widget _page() {
    // Main container for the registration form
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 15),
          const Text(
            "Join Our Family",
            style: TextStyle(
              fontFamily: 'GreatVibes Regular',
              fontSize: 50,
              color: Color(0xFFFCF5D7), // Text color
            ),
          ),
          const SizedBox(height: 30),
          // Input fields for registration
          _inputField("Full Name", fullNameController),
          const SizedBox(height: 20),
          _inputField("Email", emailController),
          const SizedBox(height: 20),
          _inputField("Address", addressController),
          const SizedBox(height: 20),
          _inputField("Contact Number", contactNumberController),
          const SizedBox(height: 50),
          _registerBtn(), // Button to trigger registration
          const SizedBox(height: 30),
          _alreadyHaveAccount(context), // Link to login
        ],
      ),
    );
  }

  Widget _inputField(String hintText, TextEditingController controller) {
    return TextField(
      style: const TextStyle(color: Color(0xFFFCF5D7)), // Text color
      controller: controller, // Assign the controller
      decoration: InputDecoration(
        hintText: hintText, // Placeholder text
      ),
    );
  }

  Widget _registerBtn() {
    return ElevatedButton(
      onPressed: () {
        debugPrint(
            "Register button tapped"); // Debug log for registration button
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Registration successful!'), // Snackbar message
            backgroundColor: Colors.green, // Snackbar background color
          ),
        );
      },
      child: const SizedBox(
        width: double.infinity,
        child: Text(
          "Sign Up", // Button text
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }

  Widget _alreadyHaveAccount(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const LoginPage()), // Navigate to LoginPage
        );
      },
      child: const Text.rich(
        TextSpan(
          text: "Already have an account? ", // Prompt for existing users
          style: TextStyle(
            fontSize: 16,
            color: Color(0xFFFCF5D7),
          ),
          children: [
            TextSpan(
              text: "Sign In", // Sign In prompt
              style: TextStyle(
                decoration: TextDecoration.underline,
                decorationColor: Color(0xFFFCF5D7),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
