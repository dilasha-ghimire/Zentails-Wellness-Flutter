import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zentails_wellness/features/home/presentation/view_model/get_appointment/get_appointment_bloc.dart';

class HistoryView extends StatefulWidget {
  const HistoryView({super.key});

  @override
  State<HistoryView> createState() => _HistoryViewState();
}

class _HistoryViewState extends State<HistoryView> {
  @override
  void initState() {
    super.initState();
    _loadAppointments();
  }

  Future<void> _loadAppointments() async {
    context.read<GetAppointmentBloc>().add(
          LoadAppointments(context: context),
        );
  }

  @override
  Widget build(BuildContext context) {
    // Get screen dimensions
    final screenSize = MediaQuery.of(context).size;
    final isTablet = screenSize.width > 600; // Adjust this threshold as needed

    // Define responsive sizes
    double titleSize = isTablet ? 45.0 : 40.0;
    double descriptionFontSize = isTablet ? 24 : 16;
    double spacing = isTablet ? 30 : 13;
    double sectionFontSize = isTablet ? 26 : 22;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(90),
        child: Padding(
          padding: const EdgeInsets.only(top: 30.0),
          child: AppBar(
            title: Text(
              "Your Order History",
              style: TextStyle(
                fontFamily: 'GreatVibes Regular',
                color: const Color(0xFF5D4037),
                fontSize: titleSize, // Use responsive fontSize
              ),
            ),
            centerTitle: true,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(spacing), // Use responsive spacing
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BlocListener<GetAppointmentBloc, GetAppointmentState>(
                listener: (context, state) {
                  if (state.reloadData) {
                    context
                        .read<GetAppointmentBloc>()
                        .add(LoadAppointments(context: context));
                  }
                },
                child: BlocBuilder<GetAppointmentBloc, GetAppointmentState>(
                  builder: (context, state) {
                    if (state.isLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state.errorMessage != null) {
                      return Center(
                        child: Text(state.errorMessage!),
                      );
                    } else if (state.appointments.isEmpty) {
                      return const Center(
                        child: Text('No appointments found.'),
                      );
                    } else {
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: state.appointments.length,
                        itemBuilder: (context, index) {
                          final appointment = state.appointments[index];
                          return Card(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                color: const Color(0xFF5D4037),
                                width: 2.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            color: const Color(0xFFFCF5D7),
                            elevation: 0,
                            margin: EdgeInsets.symmetric(vertical: spacing),
                            child: Padding(
                              padding: EdgeInsets.all(spacing),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Name: ${appointment.petId.name}',
                                    style: TextStyle(
                                      fontSize: sectionFontSize,
                                      fontWeight: FontWeight.bold,
                                      color: const Color(0xFF5D4037),
                                    ),
                                  ),
                                  Text(
                                    'Breed: ${appointment.petId.breed}',
                                    style: TextStyle(
                                      fontSize: descriptionFontSize,
                                      fontStyle: FontStyle.italic,
                                      color:
                                          const Color.fromARGB(110, 16, 8, 5),
                                    ),
                                  ),
                                  Text(
                                    'Therapy Session Date: ${_formatDate(appointment.date)}',
                                    style: TextStyle(
                                      fontSize: descriptionFontSize,
                                      color: const Color(0xFF5D4037),
                                    ),
                                  ),
                                  Text(
                                    'Start Time: ${_formatTime(appointment.startTime)}',
                                    style: TextStyle(
                                      fontSize: descriptionFontSize,
                                      color: const Color(0xFF5D4037),
                                    ),
                                  ),
                                  Text(
                                    'End Time: ${_formatTime(appointment.endTime)}',
                                    style: TextStyle(
                                      fontSize: descriptionFontSize,
                                      color: const Color(0xFF5D4037),
                                    ),
                                  ),
                                  Text(
                                    'Duration: ${appointment.duration} hours',
                                    style: TextStyle(
                                      fontSize: descriptionFontSize,
                                      color: const Color(0xFF5D4037),
                                    ),
                                  ),
                                  Text(
                                    'Total Charge: Rs.${appointment.totalCharge}',
                                    style: TextStyle(
                                      fontSize: descriptionFontSize,
                                      color: const Color(0xFF5D4037),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      'Status: ${appointment.status}',
                                      style: TextStyle(
                                        fontSize: descriptionFontSize,
                                        color: appointment.status == 'complete'
                                            ? Colors.green
                                            : const Color(0xFF5D4037),
                                        fontWeight:
                                            appointment.status == 'scheduled'
                                                ? FontWeight.bold
                                                : FontWeight.normal,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Method to format date to YYYY-MM-DD
  String _formatDate(String dateString) {
    DateTime dateTime = DateTime.parse(dateString);
    return '${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}';
  }

  // Updated method to format time from minutes to HH:mm AM/PM
  String _formatTime(int timeInMinutes) {
    final double hoursDecimal = timeInMinutes / 100;
    final int hours = hoursDecimal.floor();
    final int minutes = ((hoursDecimal - hours) * 100).round();
    final String period = hours >= 12 ? 'PM' : 'AM';
    final int formattedHours = hours % 12 == 0 ? 12 : hours % 12;
    return '${formattedHours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')} $period';
  }
}
