import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:zentails_wellness/core/error/failure.dart';
import 'package:zentails_wellness/features/home/domain/entity/pet_details_entity.dart';
import 'package:zentails_wellness/features/home/domain/repository/pet_details_repository.dart';
import 'package:zentails_wellness/features/home/domain/use_case/get_pet_details_usecase.dart';

// Mock class for the PetDetailsRepository
class MockPetDetailsRepository extends Mock implements IPetDetailsRepository {}

void main() {
  // Declare variables for the use case and the mock repository
  late GetPetDetailsUseCase getPetDetailsUseCase;
  late MockPetDetailsRepository mockPetDetailsRepository;

  // Initialize before each test
  setUp(() {
    mockPetDetailsRepository =
        MockPetDetailsRepository(); // Create mock instance
    getPetDetailsUseCase = GetPetDetailsUseCase(
        mockPetDetailsRepository); // Inject mock into use case
  });

  // Test data
  const testPetId = '123';
  final testPetDetails = PetDetailsEntity(
    id: testPetId,
    name: 'Buddy',
    age: '5',
    breed: 'Golden Retriever',
    availability: true,
    chargePerHour: '50',
    description: 'Friendly and playful',
    image: 'https://example.com/buddy.jpg',
    healthRecord: HealthRecordEntity(
      id: 'health-123',
      petId: testPetId,
      lastCheckupDate: '2023-09-01',
    ),
    medicalHistory: [
      MedicalHistoryEntity(
        id: 'med-123',
        healthRecordId: 'health-123',
        condition: 'Allergy',
        treatmentDate: '2023-08-15',
      ),
    ],
    specialNeeds: [
      SpecialNeedsEntity(
        id: 'need-123',
        healthRecordId: 'health-123',
        specialNeed: 'Regular grooming',
      ),
    ],
    vaccinations: [
      VaccinationEntity(
        id: 'vaccine-123',
        healthRecordId: 'health-123',
        vaccineName: 'Rabies',
        vaccinationDate: '2023-07-01',
      ),
    ],
  );

  // ====================================== SUCCESS TEST ======================================

  test("should return PetDetailsEntity when the call is successful", () async {
    // Arrange: Stub the repository method to return a Right (successful result)
    when(() => mockPetDetailsRepository.getPetDetails(testPetId))
        .thenAnswer((_) async => Right(testPetDetails));

    // Act: Call the use case
    final result = await getPetDetailsUseCase(testPetId);

    // Assert: Verify the result is the expected PetDetailsEntity
    expect(result, equals(Right(testPetDetails)));
    verify(() => mockPetDetailsRepository.getPetDetails(testPetId)).called(1);
    verifyNoMoreInteractions(mockPetDetailsRepository);
  });

  // ====================================== FAILURE TEST ======================================

  test("should return ApiFailure when the API call fails", () async {
    // Arrange: Stub the repository method to return an ApiFailure
    const apiFailure = ApiFailure(404, message: "Pet not found");
    when(() => mockPetDetailsRepository.getPetDetails(testPetId))
        .thenAnswer((_) async => const Left(apiFailure));

    // Act: Call the use case
    final result = await getPetDetailsUseCase(testPetId);

    // Assert: Verify the result is the expected ApiFailure
    expect(result, equals(const Left(apiFailure)));
    verify(() => mockPetDetailsRepository.getPetDetails(testPetId)).called(1);
    verifyNoMoreInteractions(mockPetDetailsRepository);
  });
}
