import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:zentails_wellness/features/onboarding/domain/entity/onboarding_entity.dart';
import 'package:zentails_wellness/features/onboarding/domain/use_case/get_onboarding_data.dart';
import 'package:zentails_wellness/features/onboarding/presentation/view_model/onboarding_bloc.dart';

// Mock dependencies
class MockGetOnboardingData extends Mock implements GetOnboardingData {}

void main() {
  late OnboardingBloc onboardingBloc;
  late MockGetOnboardingData mockGetOnboardingData;

  final testOnboardingItems = [
    OnboardingEntity(
      title: 'Welcome',
      subtitle: 'Explore our features.',
      imagePath: 'assets/welcome.png',
    ),
    OnboardingEntity(
      title: 'Get Started',
      subtitle: 'Let\'s begin your journey.',
      imagePath: 'assets/get_started.png',
    ),
  ];

  setUp(() {
    mockGetOnboardingData = MockGetOnboardingData();
    when(() => mockGetOnboardingData()).thenReturn(testOnboardingItems);
    onboardingBloc = OnboardingBloc(mockGetOnboardingData);
  });

  tearDown(() {
    onboardingBloc.close();
  });

  group('OnboardingBloc', () {
    // Test case 1: Initial state
    test('initial state should have correct onboarding items and index 0', () {
      expect(onboardingBloc.state.onboardingItems, testOnboardingItems);
      expect(onboardingBloc.state.currentIndex, 0);
    });

    // Test case 2: nextPage()
    blocTest<OnboardingBloc, OnboardingState>(
      'emits next page state when nextPage is called',
      build: () => onboardingBloc,
      act: (bloc) => bloc.nextPage(),
      expect: () => [
        predicate<OnboardingState>((state) =>
            state.onboardingItems == testOnboardingItems &&
            state.currentIndex == 1),
      ],
    );

    // Test case 3: skipToLastPage()
    blocTest<OnboardingBloc, OnboardingState>(
      'emits last page state when skipToLastPage is called',
      build: () => onboardingBloc,
      act: (bloc) => bloc.skipToLastPage(),
      expect: () => [
        predicate<OnboardingState>((state) =>
            state.onboardingItems == testOnboardingItems &&
            state.currentIndex == testOnboardingItems.length - 1),
      ],
    );

    // Test case 4: updateCurrentIndex()
    blocTest<OnboardingBloc, OnboardingState>(
      'emits updated index state when updateCurrentIndex is called',
      build: () => onboardingBloc,
      act: (bloc) => bloc.updateCurrentIndex(1),
      expect: () => [
        predicate<OnboardingState>((state) =>
            state.onboardingItems == testOnboardingItems &&
            state.currentIndex == 1),
      ],
    );
  });
}
