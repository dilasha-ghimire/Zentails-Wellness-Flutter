import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zentails_wellness/app/constants/api_endpoints.dart';
import 'package:zentails_wellness/features/home/domain/entity/pet_entity.dart';
import 'package:zentails_wellness/features/home/presentation/view/user_screen/pet_details_view.dart';
import 'package:zentails_wellness/features/home/presentation/view_model/home/pet_bloc.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  TextEditingController searchController = TextEditingController();
  List<PetEntity> filteredPets = [];
  List<PetEntity> allPets = [];

  @override
  void initState() {
    super.initState();
    context.read<PetBloc>().add(LoadPets(context: context));
  }

// 🔍 Search function (updates filteredPets list dynamically)
  void filterPets(String query) {
    if (query.isEmpty) {
      setState(() {
        filteredPets = allPets; // Reset to full list when empty
      });
    } else {
      setState(() {
        filteredPets = allPets
            .where(
                (pet) => pet.name.toLowerCase().contains(query.toLowerCase()))
            .toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 🏡 Header Section
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10.0),
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
              ),
              const SizedBox(height: 20),

              // 🔍 Search Button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: searchController,
                        onChanged: (value) {
                          filterPets(value); // 🔍 Live filtering
                        },
                        decoration: InputDecoration(
                          hintText: "Search...",
                          hintStyle: const TextStyle(color: Color(0xFF5D4037)),
                          filled: true,
                          fillColor: const Color(0xFFFCF5D7),
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 15.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide:
                                const BorderSide(color: Color(0xFF5D4037)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide:
                                const BorderSide(color: Color(0xFF5D4037)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: const BorderSide(
                                color: Color(0xFF5D4037), width: 2),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // 🐾 "Our Family" Section
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: Text(
                  'Our Family',
                  style: TextStyle(
                    fontFamily: 'SansSerif',
                    fontSize: 30.0,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF5D4037),
                  ),
                ),
              ),

              // 🐶 Pet Cards Section
              BlocListener<PetBloc, PetState>(
                listener: (context, state) {
                  if (state.reloadData) {
                    context.read<PetBloc>().add(LoadPets(context: context));
                  }
                },
                child: BlocBuilder<PetBloc, PetState>(
                  builder: (context, state) {
                    if (state.isLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (allPets.isEmpty) {
                      allPets = state.pets; // Store full job list
                      filteredPets = allPets; // Initialize filtered list
                    }
                    if (filteredPets.isEmpty) {
                      return const Center(
                        child: Padding(
                          padding: EdgeInsets.all(20.0),
                          child: Text(
                            "No pets available",
                            style: TextStyle(
                                fontSize: 16, color: Color(0xFF5D4037)),
                          ),
                        ),
                      );
                    }
                    return SizedBox(
                      child: GridView.builder(
                        padding: const EdgeInsets.all(16),
                        itemCount: filteredPets.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 16,
                          crossAxisSpacing: 16,
                          childAspectRatio: 0.8,
                        ),
                        itemBuilder: (context, index) {
                          final pet = filteredPets[index];
                          return GestureDetector(
                            onTap: () {
                              context
                                  .read<PetBloc>()
                                  .add(SelectPet(petId: pet.id));
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const PetDetailsView()),
                              );
                            },
                            child: LayoutBuilder(
                              builder: (context, constraints) {
                                double cardWidth =
                                    constraints.maxWidth; // Get dynamic width
                                double imageSize = cardWidth *
                                    0.8; // Scale image size within the card

                                return Container(
                                  width:
                                      cardWidth, // Ensures no unnecessary extra space
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF5D4037),
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment
                                        .spaceAround, // Distributes content evenly
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(12),
                                        child: Image.network(
                                          '${ApiEndpoints.imageUrlForPets}${pet.image}',
                                          fit: BoxFit
                                              .contain, // Ensures proper scaling
                                          height: imageSize,
                                          width: imageSize,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: cardWidth * 0.03),
                                        child: Column(
                                          children: [
                                            Text(
                                              pet.name,
                                              style: TextStyle(
                                                color: const Color(0xFFFCF5D7),
                                                fontSize: cardWidth * 0.08,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              textAlign: TextAlign
                                                  .center, // Center text properly
                                            ),
                                            SizedBox(height: cardWidth * 0.02),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                const Icon(Icons.pets,
                                                    size: 16,
                                                    color: Color(0xFFFCF5D7)),
                                                const SizedBox(width: 5),
                                                Text(
                                                  pet.breed,
                                                  style: TextStyle(
                                                    color:
                                                        const Color(0xFFFCF5D7),
                                                    fontSize: cardWidth * 0.06,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: cardWidth * 0.02),
                                            Text(
                                              "Rs.${pet.chargePerHour}/hr",
                                              style: TextStyle(
                                                fontSize: cardWidth * 0.06,
                                                color: const Color.fromARGB(
                                                    255, 138, 185, 139),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
