import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:zentails_wellness/features/auth/presentation/view/login_view.dart';
import 'package:zentails_wellness/features/auth/presentation/view_model/login/login_bloc.dart';
import 'package:zentails_wellness/features/auth/presentation/widget/login_widgets/login_button.dart';
import 'package:zentails_wellness/features/auth/presentation/widget/login_widgets/login_input_field.dart';
import 'package:zentails_wellness/features/auth/presentation/widget/login_widgets/login_sign_up_button.dart';

// Mock classes
class MockLoginBloc extends Mock implements LoginBloc {
  // Override the state property to return a specific state
  @override
  LoginState get state => LoginState.initial();
}

// Fake classes for fallback values
class FakeLoginEvent extends Fake implements LoginEvent {}

void main() {
  late MockLoginBloc mockLoginBloc;

  setUpAll(() {
    // Register fallback values for LoginEvent
    registerFallbackValue(FakeLoginEvent());
  });

  setUp(() {
    mockLoginBloc = MockLoginBloc();
  });

  // Group for LoginView tests
  group('LoginView Tests', () {
    // Test Case 1: LoginView renders correctly
    testWidgets('LoginView renders correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<LoginBloc>.value(
            value: mockLoginBloc,
            child: LoginView(),
          ),
        ),
      );

      expect(find.text('Welcome!'), findsOneWidget);
      expect(find.byType(LoginInputField), findsOneWidget);
      expect(find.byType(LoginPasswordInputField), findsOneWidget);
      expect(find.byType(LoginButton), findsOneWidget);
      expect(find.byType(SignUpButton), findsOneWidget);
    });

    // Test Case 2: LoginPasswordInputField toggles password visibility
    testWidgets('LoginPasswordInputField toggles password visibility',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: LoginPasswordInputField(
              hintText: 'Password',
              controller: TextEditingController(),
              isPassword: true,
            ),
          ),
        ),
      );

      expect(find.byType(TextField), findsOneWidget);
      expect(find.byIcon(Icons.visibility_off), findsOneWidget);

      await tester.tap(find.byIcon(Icons.visibility_off));
      await tester.pump();

      expect(find.byIcon(Icons.visibility), findsOneWidget);
    });
  });
}
