import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:zentails_wellness/core/error/failure.dart';
import 'package:zentails_wellness/features/home/domain/entity/book_appointment_entity.dart';
import 'package:zentails_wellness/features/home/domain/repository/book_appointment_repository.dart';
import 'package:zentails_wellness/features/home/domain/use_case/book_appointment_usecase.dart';

// Mock class for the BookAppointmentRepository
class MockBookAppointmentRepository extends Mock
    implements IAppointmentRepository {}

void main() {
  // Declare variables for the use case and the mock repository
  late BookAppointmentUseCase bookAppointmentUseCase;
  late MockBookAppointmentRepository mockBookAppointmentRepository;

  // Initialize before each test
  setUp(() {
    mockBookAppointmentRepository =
        MockBookAppointmentRepository(); // Create mock instance
    bookAppointmentUseCase = BookAppointmentUseCase(
        mockBookAppointmentRepository); // Inject mock into use case
  });

  // Test data
  const testParams = BookAppointmentParams(
    date: '2023-10-01',
    startTime: 9,
    endTime: 10,
    status: 'pending',
    petId: '123',
  );

  // ====================================== SUCCESS TEST ======================================

  test("should return void when appointment booking is successful", () async {
    // Arrange: Stub the repository method to return a Right (successful result)
    when(() => mockBookAppointmentRepository.bookAppointment(
          BookAppointmentEntity(
            date: testParams.date,
            startTime: testParams.startTime,
            endTime: testParams.endTime,
            status: testParams.status,
            petId: testParams.petId,
          ),
        )).thenAnswer((_) async => const Right(null));

    // Act: Call the use case
    final result = await bookAppointmentUseCase(testParams);

    // Assert: Verify the result is the expected void (Right)
    expect(result, equals(const Right(null)));
    verify(() => mockBookAppointmentRepository.bookAppointment(
          BookAppointmentEntity(
            date: testParams.date,
            startTime: testParams.startTime,
            endTime: testParams.endTime,
            status: testParams.status,
            petId: testParams.petId,
          ),
        )).called(1);
    verifyNoMoreInteractions(mockBookAppointmentRepository);
  });

  // ====================================== FAILURE TEST ======================================

  test("should return ApiFailure when API call fails", () async {
    // Arrange: Stub the repository method to return an ApiFailure
    const apiFailure = ApiFailure(500, message: "Server error");
    when(() => mockBookAppointmentRepository.bookAppointment(
          BookAppointmentEntity(
            date: testParams.date,
            startTime: testParams.startTime,
            endTime: testParams.endTime,
            status: testParams.status,
            petId: testParams.petId,
          ),
        )).thenAnswer((_) async => const Left(apiFailure));

    // Act: Call the use case
    final result = await bookAppointmentUseCase(testParams);

    // Assert: Verify the result is the expected ApiFailure
    expect(result, equals(const Left(apiFailure)));
    verify(() => mockBookAppointmentRepository.bookAppointment(
          BookAppointmentEntity(
            date: testParams.date,
            startTime: testParams.startTime,
            endTime: testParams.endTime,
            status: testParams.status,
            petId: testParams.petId,
          ),
        )).called(1);
    verifyNoMoreInteractions(mockBookAppointmentRepository);
  });
}
