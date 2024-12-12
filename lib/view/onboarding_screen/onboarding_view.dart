import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  final controller = PageController();
  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(bottom: 80),
        child: PageView(
          controller: controller,
          children: [
            // First page
            Container(
              color: Colors.red,
              child: const Center(child: Text("Page 1")),
            ),

            // Second page
            Container(
              color: Colors.green,
              child: const Center(child: Text("Page 2")),
            ),

            // Third page
            Container(
              color: Colors.blue,
              child: const Center(child: Text("Page 3")),
            ),

            // Fourth page
            Container(
              color: Colors.yellow,
              child: const Center(child: Text("Page 4")),
            ),
          ],
        ),
      ),
      bottomSheet: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 40,
          ),
          height: 70,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // TextButton for `Skip`
              TextButton(
                  onPressed: () {
                    controller.jumpToPage(3);
                  },
                  child: const Text(
                    "Skip",
                    style: TextStyle(fontSize: 18),
                  )),

              Center(
                child: SmoothPageIndicator(
                    effect: WormEffect(
                        spacing: 15,
                        dotColor: Colors.purple.shade200,
                        activeDotColor: Colors.purple),
                    onDotClicked: (index) {
                      controller.animateToPage(index,
                          duration: const Duration(milliseconds: 600),
                          curve: Curves.easeInOut);
                    },
                    controller: controller,
                    count: 4),
              ),

              // TextButton for `Next`
              TextButton(
                  onPressed: () {
                    controller.nextPage(
                        duration: const Duration(milliseconds: 600),
                        curve: Curves.easeInOut);
                  },
                  child: const Text(
                    "Next",
                    style: TextStyle(fontSize: 18),
                  )),
            ],
          )),
    );
  }
}
