import 'package:flutter/material.dart';

// This function creates a reusable widget for onboarding pages, combining an image, title, and subtitle with customizable design elements.
Widget buildImageContainer(
  BuildContext context,
  Color color,
  String title,
  String subtitle,
  String imagePath, {
  bool isCircular = false,
  double? imageWidth,
  double? imageHeight,
}) {
  return SafeArea(
    child: Container(
      color: color, // Sets the background color of the container.
      padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical:
              30), // Adds padding inside the container for layout spacing.
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment
              .center, // Aligns the child widgets horizontally to the center.
          children: [
            Container(
              decoration: BoxDecoration(
                shape: isCircular
                    ? BoxShape.circle
                    : BoxShape
                        .rectangle, // Determines if the image should be circular or rectangular.
                borderRadius: isCircular
                    ? null
                    : BorderRadius.circular(
                        20), // Adds rounded corners for non-circular images.
                boxShadow: [
                  // Adds shadow effect for a more visually appealing design.
                  BoxShadow(
                    color: Colors.black.withOpacity(isCircular
                        ? 0.3
                        : 0.5), // Adjusts shadow opacity based on shape.
                    blurRadius: 15,
                    spreadRadius: 5,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: isCircular
                    ? BorderRadius.circular(100)
                    : BorderRadius.circular(
                        20), // Ensures the image respects the shape specified.
                child: Image.asset(
                  imagePath, // Loads the image from the given asset path.
                  fit: BoxFit
                      .cover, // Ensures the image fits well inside its container.
                  width:
                      imageWidth ?? // Uses provided image width or defaults based on shape.
                          (isCircular
                              ? MediaQuery.of(context).size.width * 0.6
                              : MediaQuery.of(context).size.width * 0.8),
                  height:
                      imageHeight ?? // Uses provided image height or defaults based on shape.
                          (isCircular
                              ? MediaQuery.of(context).size.width * 0.5
                              : MediaQuery.of(context).size.height * 0.4),
                ),
              ),
            ),
            const SizedBox(
                height:
                    50), // Adds spacing between the image and the title text.
            Text(
              title, // Displays the title text.
              textAlign: TextAlign.center, // Centers the title horizontally.
              style: const TextStyle(
                fontFamily:
                    'GreatVibes Regular', // Applies a decorative font to the title.
                fontWeight: FontWeight.w500,
                fontSize: 45,
                color: Color(
                    0xFF5D4037), // Uses a theme-specific color for the text.
              ),
            ),
            const SizedBox(
                height: 25), // Adds spacing between the title and subtitle.
            Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 30), // Adds padding around the subtitle text.
              child: Text(
                subtitle, // Displays the subtitle text.
                textAlign:
                    TextAlign.center, // Centers the subtitle horizontally.
                style: const TextStyle(
                  fontFamily:
                      'SansSerif', // Uses a simpler font for better readability.
                  fontSize: 18,
                  color: Color.fromARGB(255, 93, 71,
                      65), // A complementary color for subtitle text.
                  height: 1.5, // Increases line height for better text spacing.
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
