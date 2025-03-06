import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:zentails_wellness/core/error/failure.dart';
import 'package:zentails_wellness/features/home/domain/entity/get_booking_entity.dart';
import 'package:zentails_wellness/features/home/domain/use_case/get_appointment_usecase.dart';
import 'package:zentails_wellness/features/home/presentation/view_model/get_appointment/get_appointment_bloc.dart';

// Mock dependencies
class MockGetAppointmentsUseCase extends Mock
    implements GetAppointmentsUseCase {}

class MockBuildContext extends Mock implements BuildContext {}

void main() {
  late GetAppointmentBloc getAppointmentBloc;
  late MockGetAppointmentsUseCase mockGetAppointmentsUseCase;
  late MockBuildContext mockBuildContext;

  setUp(() {
    mockGetAppointmentsUseCase = MockGetAppointmentsUseCase();
    mockBuildContext = MockBuildContext();
    getAppointmentBloc =
        GetAppointmentBloc(getAppointmentsUseCase: mockGetAppointmentsUseCase);
  });

  tearDown(() {
    getAppointmentBloc.close();
  });

  final testAppointments = [
    TherapyBookingEntity(
      id: '1',
      date: '2023-11-15',
      startTime: 10,
      endTime: 11,
      duration: 60,
      totalCharge: 50,
      status: 'Confirmed',
      userId: const UserBookingEntity(
        id: 'user1',
        fullName: 'John Doe',
        email: 'john@example.com',
        contactNumber: '1234567890',
        address: '123 Main St',
        profilePicture: 'profile.jpg',
        active: true,
      ),
      petId: const PetBookingEntity(
        id: 'pet1',
        name: 'Buddy',
        age: '3 years',
        breed: 'Labrador',
        description: 'Friendly dog',
        availability: true,
        chargePerHour: '10',
        image: 'buddy.jpg',
      ),
    ),
  ];

  group('GetAppointmentBloc Tests', () {
    // Test case 1: Initial State
    test('initial state should be correct', () {
      expect(getAppointmentBloc.state, GetAppointmentState.initial());
    });
    // Test case 2: LoadAppointments - Success
    blocTest<GetAppointmentBloc, GetAppointmentState>(
      'emits [isLoading: true, appointments: appointments, isSuccess: true] when LoadAppointments is successful',
      build: () {
        when(() => mockGetAppointmentsUseCase.call())
            .thenAnswer((_) async => Right(testAppointments));
        return getAppointmentBloc;
      },
      act: (bloc) => bloc.add(LoadAppointments(context: mockBuildContext)),
      expect: () => [
        const GetAppointmentState(
            isLoading: true,
            isSuccess: false,
            reloadData: false,
            appointments: [],
            errorMessage: null,
            selectedAppointmentId: null),
        GetAppointmentState(
            isLoading: false,
            isSuccess: true,
            reloadData: false,
            appointments: testAppointments,
            errorMessage: null,
            selectedAppointmentId: null),
      ],
    );

    // Test case 3: LoadAppointments - Failure
    blocTest<GetAppointmentBloc, GetAppointmentState>(
      'emits [isLoading: true, errorMessage: "Failed to load appointments"] when LoadAppointments fails',
      build: () {
        when(() => mockGetAppointmentsUseCase.call()).thenAnswer((_) async =>
            Left(ApiFailure(500, message: 'Failed to load appointments')));
        return getAppointmentBloc;
      },
      act: (bloc) => bloc.add(LoadAppointments(context: mockBuildContext)),
      expect: () => [
        const GetAppointmentState(
            isLoading: true,
            isSuccess: false,
            reloadData: false,
            appointments: [],
            errorMessage: null,
            selectedAppointmentId: null),
        const GetAppointmentState(
            isLoading: false,
            isSuccess: false,
            reloadData: false,
            appointments: [],
            errorMessage: "Failed to load appointments",
            selectedAppointmentId: null),
      ],
    );

    // Test case 4: SelectAppointment
    blocTest<GetAppointmentBloc, GetAppointmentState>(
      'emits [selectedAppointmentId: appointmentId] when SelectAppointment is called',
      build: () => getAppointmentBloc,
      act: (bloc) => bloc.add(const SelectAppointment(appointmentId: '1')),
      expect: () => [
        const GetAppointmentState(
            isLoading: false,
            isSuccess: false,
            reloadData: false,
            appointments: [],
            errorMessage: null,
            selectedAppointmentId: '1'),
      ],
    );
  });
}
