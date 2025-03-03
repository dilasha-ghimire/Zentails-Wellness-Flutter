import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zentails_wellness/app/constants/api_endpoints.dart';
import 'package:zentails_wellness/features/home/presentation/view_model/home/pet_bloc.dart';
import 'package:zentails_wellness/features/home/presentation/view_model/pet_details/pet_details_bloc.dart';

class PetDetailsView extends StatefulWidget {
  const PetDetailsView({super.key});

  @override
  State<PetDetailsView> createState() => _PetDetailsViewState();
}

class _PetDetailsViewState extends State<PetDetailsView> {
  @override
  void initState() {
    super.initState();
    final selectedPetId = context.read<PetBloc>().state.selectedPetId;
    if (selectedPetId != null) {
      context.read<PetDetailsBloc>().add(LoadPetDetails(petId: selectedPetId));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pet Details"),
        foregroundColor: const Color(0xFFFCF5D7),
        backgroundColor: const Color(0xFF5D4037),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: const Color(0xFFFCF5D7),
          onPressed: () {
            context.read<PetBloc>().add(LoadPets(context: context));
            Navigator.pop(context);
          },
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          bool isTablet = constraints.maxWidth >= 600;
          double imageHeight = isTablet ? 300 : 200;
          double fontSize = isTablet ? 32 : 24;
          double descriptionFontSize = isTablet ? 24 : 16;
          double spacing = isTablet ? 30 : 20;
          double sectionFontSize = isTablet ? 26 : 22;
          double buttonFontSize = isTablet ? 28 : 22;
          double buttonPadding = isTablet ? 20 : 16;

          return BlocBuilder<PetDetailsBloc, PetDetailsState>(
            builder: (context, state) {
              if (state.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state.errorMessage != null) {
                return Center(child: Text(state.errorMessage!));
              }

              final pet = state.petDetails;
              if (pet == null) {
                return const Center(child: Text("No details available"));
              }

              return SingleChildScrollView(
                padding: EdgeInsets.all(spacing),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 5),
                    Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          '${ApiEndpoints.imageUrlForPets}${pet.image}',
                          fit: BoxFit.contain,
                          height: imageHeight,
                          width: imageHeight,
                        ),
                      ),
                    ),

                    // Pet Name & Breed
                    Text(
                      pet.name,
                      style: TextStyle(
                        fontSize: fontSize,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF5D4037),
                      ),
                    ),
                    Text(
                      pet.breed,
                      style: TextStyle(
                          fontSize: fontSize * 0.8, color: Colors.grey),
                    ),
                    const SizedBox(height: 10),

                    // Pet Age, Charge & Availability
                    Text("Age: ${pet.age} years",
                        style: TextStyle(fontSize: fontSize * 0.8)),
                    Text("Charge Per Hour: Rs.${pet.chargePerHour}",
                        style: TextStyle(fontSize: fontSize * 0.8)),
                    Text(
                      pet.availability ? "Available" : "Not Available",
                      style: TextStyle(
                          fontSize: fontSize * 0.8,
                          color: pet.availability ? Colors.green : Colors.red),
                    ),
                    const SizedBox(height: 20),

                    // Pet Description
                    if (pet.description != null)
                      Text(
                        pet.description!,
                        style: TextStyle(
                            fontSize: descriptionFontSize,
                            fontStyle: FontStyle.italic),
                      ),
                    const SizedBox(height: 20),

                    // Health Records
                    Text("Health Records",
                        style: TextStyle(
                            fontSize: sectionFontSize,
                            fontWeight: FontWeight.bold)),
                    if (pet.healthRecord != null)
                      ListTile(
                        title: Text(
                          "Last Checkup: ${pet.healthRecord!.lastCheckupDate}",
                          style: TextStyle(fontSize: fontSize * 0.8),
                        ),
                        leading: const Icon(Icons.health_and_safety,
                            color: Colors.blue),
                      ),
                    const SizedBox(height: 20),

                    // Medical History
                    Text("Medical History",
                        style: TextStyle(
                            fontSize: sectionFontSize,
                            fontWeight: FontWeight.bold)),
                    pet.medicalHistory.isNotEmpty
                        ? Column(
                            children: pet.medicalHistory.map((history) {
                              return ListTile(
                                title: Text(
                                  history.condition,
                                  style: TextStyle(fontSize: fontSize * 0.7),
                                ),
                                subtitle:
                                    Text("Date: ${history.treatmentDate}"),
                                leading: const Icon(Icons.medical_services,
                                    color: Colors.red),
                              );
                            }).toList(),
                          )
                        : const Text("No medical history available"),
                    const SizedBox(height: 20),

                    // Special Needs
                    Text("Special Needs",
                        style: TextStyle(
                            fontSize: sectionFontSize,
                            fontWeight: FontWeight.bold)),
                    pet.specialNeeds.isNotEmpty
                        ? Column(
                            children: pet.specialNeeds.map((need) {
                              return ListTile(
                                title: Text(
                                  need.specialNeed,
                                  style: TextStyle(fontSize: fontSize * 0.8),
                                ),
                                leading: const Icon(Icons.add_alert,
                                    color: Colors.orange),
                              );
                            }).toList(),
                          )
                        : const Text("No special needs recorded"),
                    const SizedBox(height: 20),

                    // Vaccination Records
                    Text("Vaccination Records",
                        style: TextStyle(
                            fontSize: sectionFontSize,
                            fontWeight: FontWeight.bold)),
                    pet.vaccinations.isNotEmpty
                        ? Column(
                            children: pet.vaccinations.map((vaccine) {
                              return ListTile(
                                title: Text(
                                  vaccine.vaccineName,
                                  style: TextStyle(fontSize: fontSize * 0.7),
                                ),
                                subtitle:
                                    Text("Date: ${vaccine.vaccinationDate}"),
                                leading: const Icon(Icons.vaccines,
                                    color: Colors.green),
                              );
                            }).toList(),
                          )
                        : const Text("No vaccination records available"),
                    const SizedBox(height: 10),

                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          textStyle: TextStyle(fontSize: buttonFontSize),
                          foregroundColor: const Color(0xFFFCF5D7),
                          backgroundColor: const Color(0xFF5D4037),
                          shape: const StadiumBorder(),
                          padding:
                              EdgeInsets.symmetric(vertical: buttonPadding),
                        ),
                        child: const Text("Book Therapy Session"),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
