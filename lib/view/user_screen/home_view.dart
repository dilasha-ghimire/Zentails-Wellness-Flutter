import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.menu,
            size: 24.0,
            color: Color(0xFF5D4037),
          ),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.notifications,
              size: 24.0,
              color: Color(0xFF5D4037),
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Image.asset(
                        'assets/images/onboarding_pages/Logo.png',
                        width: 100,
                        height: 100,
                      ),
                    ),
                  ),
                  const Expanded(
                    flex: 3,
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Welcome to',
                            style: TextStyle(
                              fontFamily: 'Montserrat SemiBold',
                              fontSize: 24.0,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF5D4037),
                            ),
                          ),
                          Text(
                            'Zentails Wellness',
                            style: TextStyle(
                              fontFamily: 'GreatVibes Regular',
                              fontSize: 36.0,
                              color: Color(0xFF5D4037),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: Text(
                  'Our Family',
                  style: TextStyle(
                    fontFamily: 'SansSerif',
                    fontSize: 20.0,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF5D4037),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.3,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    _buildFamilyCard('assets/test_images/img.jpg', 'Name 1'),
                    _buildFamilyCard('assets/test_images/img.jpg', 'Name 2'),
                    _buildFamilyCard('assets/test_images/img.jpg', 'Name 3'),
                    _buildFamilyCard('assets/test_images/img.jpg', 'Name 4'),
                    _buildFamilyCard('assets/test_images/img.jpg', 'Name 5'),
                    _buildFamilyCard('assets/test_images/img.jpg', 'Name 6'),
                    _buildFamilyCard('assets/test_images/img.jpg', 'Name 7'),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: Text(
                  'Hear from our friends',
                  style: TextStyle(
                    fontFamily: 'SansSerif',
                    fontSize: 20.0,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF5D4037),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.2,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    _buildReviewCard(
                        'Name 1',
                        'Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore.',
                        5),
                    _buildReviewCard(
                        'Name 2',
                        'Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore.',
                        5),
                    _buildReviewCard(
                        'Name 3',
                        'Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore.',
                        5),
                    _buildReviewCard(
                        'Name 4',
                        'Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore.',
                        5),
                    _buildReviewCard(
                        'Name 5',
                        'Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore.',
                        5),
                    _buildReviewCard(
                        'Name 6',
                        'Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore.',
                        5),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFamilyCard(String imagePath, String name) {
    return Card(
      color: const Color(0xFF5D4037),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.3,
        margin: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
                height: 170,
                width: double.infinity,
              ),
            ),
            const SizedBox(height: 8.0),
            Text(
              name,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4.0),
            GestureDetector(
              onTap: () {},
              child: const Text(
                'View More',
                style: TextStyle(
                  color: Colors.white,
                  decoration: TextDecoration.underline,
                  fontSize: 14.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReviewCard(String name, String reviewText, int rating) {
    return Card(
      color: const Color(0xFFFCF5D7),
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: Color(0xFF5D4037)),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.5,
        height: MediaQuery.of(context).size.height * 0.2,
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                const Icon(Icons.person, size: 40.0, color: Color(0xFF5D4037)),
                const SizedBox(width: 10.0),
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF5D4037),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            Text(
              reviewText,
              style: const TextStyle(
                fontSize: 14.0,
                color: Color(0xFF5D4037),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                rating,
                (index) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                  size: 16.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
