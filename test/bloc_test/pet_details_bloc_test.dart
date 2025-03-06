import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:zentails_wellness/core/error/failure.dart';
import 'package:zentails_wellness/features/home/domain/entity/pet_details_entity.dart';
import 'package:zentails_wellness/features/home/domain/use_case/get_pet_details_usecase.dart';
import 'package:zentails_wellness/features/home/presentation/view_model/pet_details/pet_details_bloc.dart';

// Mock dependencies
class MockGetPetDetailsUseCase extends Mock implements GetPetDetailsUseCase {}

void main() {
  late PetDetailsBloc petDetailsBloc;
  late MockGetPetDetailsUseCase mockGetPetDetailsUseCase;

  setUp(() {
    mockGetPetDetailsUseCase = MockGetPetDetailsUseCase();
    petDetailsBloc =
        PetDetailsBloc(getPetDetailsUseCase: mockGetPetDetailsUseCase);
  });

  tearDown(() {
    petDetailsBloc.close();
  });

  group('PetDetailsBloc', () {
    final testPetDetails = PetDetailsEntity(
      id: '1',
      name: 'Buddy',
      age: '3 years',
      breed: 'Labrador',
      availability: true,
      chargePerHour: '10',
      description: 'Friendly dog',
      healthRecord: const HealthRecordEntity(
          id: '1', petId: '1', lastCheckupDate: '2023-10-26'),
      medicalHistory: const [
        MedicalHistoryEntity(
            id: '1',
            healthRecordId: '1',
            condition: 'Allergy',
            treatmentDate: '2023-01-01')
      ],
      specialNeeds: const [
        SpecialNeedsEntity(
            id: '1', healthRecordId: '1', specialNeed: 'Special diet')
      ],
      vaccinations: const [
        VaccinationEntity(
            id: '1',
            healthRecordId: '1',
            vaccineName: 'Rabies',
            vaccinationDate: '2023-05-01')
      ],
    );

    // Test case 1: LoadPetDetails - Success
    blocTest<PetDetailsBloc, PetDetailsState>(
      'emits [isLoading: true, petDetails: petDetails, isSuccess: true] when LoadPetDetails is successful',
      build: () {
        when(() => mockGetPetDetailsUseCase.call('1'))
            .thenAnswer((_) async => Right(testPetDetails));
        return petDetailsBloc;
      },
      act: (bloc) => bloc.add(const LoadPetDetails(petId: '1')),
      expect: () => [
        const PetDetailsState(isLoading: true, isSuccess: false),
        PetDetailsState(
            isLoading: false, isSuccess: true, petDetails: testPetDetails),
      ],
    );

    // Test case 2: LoadPetDetails - Failure
    blocTest<PetDetailsBloc, PetDetailsState>(
      'emits [isLoading: true, errorMessage: "Failed to load pet details"] when LoadPetDetails fails',
      build: () {
        when(() => mockGetPetDetailsUseCase.call('1')).thenAnswer(
            (_) async => Left(ApiFailure(500, message: "Server error")));
        return petDetailsBloc;
      },
      act: (bloc) => bloc.add(const LoadPetDetails(petId: '1')),
      expect: () => [
        const PetDetailsState(isLoading: true, isSuccess: false),
        const PetDetailsState(
            isLoading: false,
            isSuccess: false,
            errorMessage: "Failed to load pet details"),
      ],
    );

    //Test Case 3: Initial State.
    test('initial state should be correct', () {
      expect(petDetailsBloc.state, PetDetailsState.initial());
    });
  });
}
