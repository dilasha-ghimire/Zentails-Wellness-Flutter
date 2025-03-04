import 'package:flutter/material.dart';

class ReviewPage extends StatefulWidget {
  const ReviewPage({super.key});

  @override
  State<ReviewPage> createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(90),
        child: Padding(
          padding: const EdgeInsets.only(top: 30.0),
          child: AppBar(
            title: const Text(
              "Your Review",
              style: TextStyle(
                fontFamily: 'GreatVibes Regular',
                color: Color(0xFF5D4037),
                fontSize: 40,
              ),
            ),
            centerTitle: true,
          ),
        ),
      ),
      body: Center(
        child: Text(
          "History Screen",
        ),
      ),
    );
  }
}
