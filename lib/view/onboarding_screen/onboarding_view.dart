import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:zentails_wellness/view/authentication_screen/login_view.dart';
import 'package:zentails_wellness/view/onboarding_screen/container_image.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  final controller =
      PageController(); // Manages and controls the `PageView` navigation.
  bool isLastPage =
      false; // Tracks whether the user is on the last onboarding page.

  @override
  void initState() {
    super.initState();

    // Lock orientation to portrait mode
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
  }

  @override
  void dispose() {
    // Reset orientation settings when leaving the screen
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);

    super.dispose();
    controller.dispose(); // Disposes the `PageController` to free up resources.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: controller, // Connects the `PageView` to the controller.
        onPageChanged: (index) {
          setState(() {
            isLastPage =
                index == 3; // Updates the state when the last page is reached.
          });
        },
        children: [
          Center(
            child: buildImageContainer(
              context,
              const Color(
                  0xFFFCF5D7), // Background color for the first onboarding screen.
              "Welcome to\nZentails Wellness", // Heading for the first onboarding page.
              "Discover the joy of pet therapy\nand unlock a pawsitive path to\nrelaxation and healing.", // Description text for the page.
              "assets/images/onboarding_pages/Logo.png", // Path to the image asset.
              isCircular: true, // Configures the image style as circular.
              imageWidth: MediaQuery.of(context).size.width *
                  0.70, // Dynamically sets the width.
              imageHeight: MediaQuery.of(context).size.width *
                  0.70, // Dynamically sets the height.
            ),
          ),
          Center(
            child: buildImageContainer(
              context,
              const Color(0xFFFCF5D7),
              "Discover Our\nTherapy Companions",
              "Explore heartwarming pet\nprofiles and choose your\nperfect therapy companion.",
              "assets/images/onboarding_pages/TherapyPets.png",
              imageWidth: MediaQuery.of(context).size.width *
                  0.70, // Dynamically sets the width.
              imageHeight: MediaQuery.of(context).size.width *
                  0.70, // Dynamically sets the height.
            ),
          ),
          Center(
            child: buildImageContainer(
              context,
              const Color(0xFFFCF5D7),
              "Easy Booking,\nAnytime!",
              "Select your preferred date, time, and\nduration for a seamless therapy\nsession booking experience.",
              "assets/images/onboarding_pages/EasyBooking.jpeg",
              imageWidth: MediaQuery.of(context).size.width *
                  0.70, // Dynamically sets the width.
              imageHeight: MediaQuery.of(context).size.width *
                  0.70, // Dynamically sets the height.
            ),
          ),
          Center(
            child: buildImageContainer(
              context,
              const Color(0xFFFCF5D7),
              "Start Your Wellness\nJourney Today",
              "Join us today to experience the\nbenefits of personalized pet therapy.\nPurely pawsitive, always!",
              "assets/images/onboarding_pages/TherapySessions.jpeg",
              imageWidth: MediaQuery.of(context).size.width *
                  0.70, // Dynamically sets the width.
              imageHeight: MediaQuery.of(context).size.width *
                  0.70, // Dynamically sets the height.
            ),
          ),
        ],
      ),
      bottomSheet: Container(
        color: const Color(
            0xFFFCF5D7), // Sets the background color of the bottom sheet.
        padding: const EdgeInsets.symmetric(
            horizontal: 15), // Adds horizontal padding to the content.
        height: 70, // Defines the height of the bottom sheet.
        child: Row(
          mainAxisAlignment: MainAxisAlignment
              .spaceBetween, // Aligns the children with space between them.
          children: [
            TextButton(
              onPressed: () {
                controller.jumpToPage(
                    3); // Skips to the last onboarding page when pressed.
              },
              child: const Text(
                "Skip", // Text displayed on the skip button.
                style: TextStyle(
                    fontSize: 18,
                    color:
                        Color(0xFF5D4037)), // Styling for the skip button text.
              ),
            ),
            Center(
              child: SmoothPageIndicator(
                effect: const WormEffect(
                  spacing: 15, // Space between dots.
                  dotColor:
                      Color.fromARGB(255, 141, 126, 121), // Inactive dot color.
                  activeDotColor: Color(0xFF5D4037), // Active dot color.
                ),
                onDotClicked: (index) {
                  controller.animateToPage(
                      index, // Navigates to the clicked dot's page.
                      duration: const Duration(milliseconds: 600),
                      curve: Curves.easeInOut);
                },
                controller:
                    controller, // Connects the indicator to the `PageView` controller.
                count: 4, // Total number of pages.
              ),
            ),
            isLastPage
                ? TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const LoginView(), // Navigates to the login page.
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10), // Adds padding around the button text.
                      decoration: BoxDecoration(
                        color: const Color(
                            0xFF5D4037), // Sets the button's background color.
                        borderRadius: BorderRadius.circular(
                            20), // Applies rounded corners.
                      ),
                      child: const Text(
                        "Get Started", // Text displayed on the button.
                        style: TextStyle(
                          fontSize: 18,
                          color: Color(0xFFFCF5D7), // Sets the text color.
                        ),
                      ),
                    ),
                  )
                : TextButton(
                    onPressed: () {
                      controller.nextPage(
                        duration: const Duration(
                            milliseconds: 600), // Animates to the next page.
                        curve: Curves.easeInOut, // Adds a smooth easing effect.
                      );
                    },
                    child: const Text(
                      "Next", // Text displayed on the next button.
                      style: TextStyle(
                          fontSize: 18,
                          color: Color(
                              0xFF5D4037)), // Styling for the next button text.
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
