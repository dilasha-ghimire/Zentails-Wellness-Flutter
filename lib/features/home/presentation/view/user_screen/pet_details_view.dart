import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zentails_wellness/app/constants/api_endpoints.dart';
import 'package:zentails_wellness/core/common/snackbar/my_snackbar.dart';
import 'package:zentails_wellness/features/home/presentation/view_model/book_appointment/book_appointment_bloc.dart';
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
                      child: BlocListener<BookAppointmentBloc,
                          BookAppointmentState>(
                        listener: (context, state) {
                          if (state.isSuccess) {
                            showMySnackBar(
                              context: context,
                              message: "Appointment booked successfully!",
                              color: Colors.green,
                            );
                            Future.delayed(const Duration(seconds: 2), () {
                              // ignore: use_build_context_synchronously
                              Navigator.of(context).pop(); // Navigate back
                            });
                          } else if (!state.isSuccess && !state.isLoading) {
                            Future.delayed(const Duration(seconds: 2), () {
                              // ignore: use_build_context_synchronously
                              Navigator.of(context).pop(); // Navigate back
                            });
                          }
                        },
                        child: ElevatedButton(
                          onPressed: () {
                            _showBookingDialog(context, pet.id);
                          },
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

  void _showBookingDialog(BuildContext context, String petId) {
    final TextEditingController dateController = TextEditingController();
    final TextEditingController startTimeController = TextEditingController();
    final TextEditingController endTimeController = TextEditingController();

    void selectDate(BuildContext context) async {
      final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2101),
        builder: (context, child) {
          return Theme(
            data: ThemeData(
              dialogTheme: DialogThemeData(backgroundColor: Color(0xFFFCF5D7)),
            ),
            child: child!,
          );
        },
      );
      if (pickedDate != null) {
        dateController.text =
            "${pickedDate.toLocal()}".split(' ')[0]; // Format as YYYY-MM-DD
      }
    }

    void selectStartTime(BuildContext context) async {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
        builder: (context, child) {
          return Theme(
            data: ThemeData(
              dialogTheme: DialogThemeData(backgroundColor: Color(0xFFFCF5D7)),
            ),
            child: child!,
          );
        },
      );
      if (pickedTime != null) {
        // ignore: use_build_context_synchronously
        startTimeController.text = pickedTime.format(context); // Format time
      }
    }

    void selectEndTime(BuildContext context) async {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
        builder: (context, child) {
          return Theme(
            data: ThemeData(
              dialogTheme: DialogThemeData(backgroundColor: Color(0xFFFCF5D7)),
            ),
            child: child!,
          );
        },
      );
      if (pickedTime != null) {
        // ignore: use_build_context_synchronously
        endTimeController.text = pickedTime.format(context); // Format time
      }
    }

    int convertTimeToInt(String time) {
      final TimeOfDay parsedTime = TimeOfDay(
        hour:
            int.parse(time.split(':')[0]) % 12 + (time.contains('PM') ? 12 : 0),
        minute: int.parse(time.split(':')[1].split(' ')[0]),
      );
      return parsedTime.hour * 100 + parsedTime.minute;
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return LayoutBuilder(builder: (context, constraints) {
          bool isTablet = constraints.maxWidth >= 600;
          double dialogWidth = isTablet
              ? constraints.maxWidth * 0.6
              : constraints.maxWidth * 0.9;
          double dialogHeight = isTablet
              ? constraints.maxHeight * 0.22
              : constraints.maxHeight * 0.27;
          double dialogPadding = isTablet ? 30 : 10;
          double buttonWidth = isTablet ? 200 : 150;

          return AlertDialog(
            backgroundColor: const Color(0xFFFCF5D7),
            title: Center(
                child: const Text(
              "Book Therapy Session",
              style: TextStyle(color: Color(0xFF5D4037)),
            )),
            content: SingleChildScrollView(
              child: SizedBox(
                width: dialogWidth,
                height: dialogHeight,
                child: Padding(
                  padding: EdgeInsets.all(dialogPadding),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: 10),
                      TextField(
                        controller: dateController,
                        decoration: InputDecoration(
                          labelText: "Date",
                          labelStyle: const TextStyle(color: Color(0xFF5D4037)),
                          hintText: "YYYY-MM-DD",
                          hintStyle: const TextStyle(color: Color(0xFF5D4037)),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Color(0xFF5D4037)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Color(0xFF5D4037)),
                          ),
                        ),
                        readOnly: true,
                        onTap: () => selectDate(context),
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: startTimeController,
                        decoration: InputDecoration(
                          labelText: "Start Time",
                          labelStyle: const TextStyle(color: Color(0xFF5D4037)),
                          hintText: "HH:MM AM/PM",
                          hintStyle: const TextStyle(color: Color(0xFF5D4037)),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Color(0xFF5D4037)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Color(0xFF5D4037)),
                          ),
                        ),
                        readOnly: true,
                        onTap: () => selectStartTime(context),
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: endTimeController,
                        decoration: InputDecoration(
                          labelText: "End Time",
                          labelStyle: const TextStyle(color: Color(0xFF5D4037)),
                          hintText: "HH:MM AM/PM",
                          hintStyle: const TextStyle(color: Color(0xFF5D4037)),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Color(0xFF5D4037)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Color(0xFF5D4037)),
                          ),
                        ),
                        readOnly: true,
                        onTap: () => selectEndTime(context),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    width: buttonWidth,
                    child: ElevatedButton(
                      onPressed: () {
                        String date = dateController.text; // Date as string
                        int startTime = convertTimeToInt(
                            startTimeController.text); // Start time as integer
                        int endTime = convertTimeToInt(
                            endTimeController.text); // End time as integer

                        context.read<BookAppointmentBloc>().add(
                              BookAppointmentRequested(
                                context: context,
                                date: date,
                                startTime: startTime,
                                endTime: endTime,
                                status: "scheduled", // Set the status if needed
                                petId: petId,
                              ),
                            );
                        Navigator.of(context).pop();
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: const Color(0xFFFCF5D7),
                        backgroundColor: const Color(0xFF5D4037),
                      ),
                      child: const Text("Book Appointment"),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // Close the dialog
                    },
                    child: const Text(
                      "Cancel",
                      style: TextStyle(color: Color(0xFF5D4037)),
                    ),
                  ),
                ],
              ),
            ],
          );
        });
      },
    );
  }
}
