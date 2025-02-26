import 'package:flutter/material.dart';

class HistoryView extends StatefulWidget {
  const HistoryView({super.key});

  @override
  State<HistoryView> createState() => _HistoryViewState();
}

class _HistoryViewState extends State<HistoryView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(90),
        child: Padding(
          padding: const EdgeInsets.only(top: 30.0),
          child: AppBar(
            title: const Text(
              "Your Order History",
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
