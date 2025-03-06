import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:zentails_wellness/features/auth/presentation/view/registration_view.dart';
import 'package:zentails_wellness/features/auth/presentation/view_model/register/register_bloc.dart';
import 'package:zentails_wellness/features/auth/presentation/widget/register_widgets/register_button.dart';
import 'package:zentails_wellness/features/auth/presentation/widget/register_widgets/register_have_account.dart';
import 'package:zentails_wellness/features/auth/presentation/widget/register_widgets/register_input_field.dart';

// Mock RegisterBloc
class MockRegisterBloc extends Mock implements RegisterBloc {
  // Mock the stream property
  @override
  Stream<RegisterState> get stream => Stream<RegisterState>.empty();
}

void main() {
  late MockRegisterBloc mockRegisterBloc;

  setUp(() {
    mockRegisterBloc = MockRegisterBloc();

    // Mock the initial state
    when(() => mockRegisterBloc.state).thenReturn(RegisterState.initial());
  });

  // Test Case 1: RegistrationView Renders Correctly
  testWidgets('RegistrationView renders correctly',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<RegisterBloc>.value(
          value: mockRegisterBloc,
          child: RegistrationView(),
        ),
      ),
    );

    // Verify that the "Join Our Family" text is displayed
    expect(find.text('Join Our Family'), findsOneWidget);

    // Verify that all input fields are rendered
    expect(find.byType(RegisterInputField), findsNWidgets(4));
    expect(find.byType(RegistrationPasswordInputField), findsNWidgets(2));

    // Verify that the RegisterButton and AlreadyHaveAccount widgets are rendered
    expect(find.byType(RegisterButton), findsOneWidget);
    expect(find.byType(AlreadyHaveAccount), findsOneWidget);
  });

  // Test Case 2: RegisterButton Triggers RegisterUser Event
  testWidgets('RegisterButton triggers RegisterUser event',
      (WidgetTester tester) async {
    // Mock the state
    when(() => mockRegisterBloc.state).thenReturn(RegisterState.initial());

    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<RegisterBloc>.value(
          value: mockRegisterBloc,
          child: RegistrationView(),
        ),
      ),
    );

    // Enter text into the input fields
    await tester.enterText(find.byType(RegisterInputField).at(0), 'John Doe');
    await tester.enterText(
        find.byType(RegisterInputField).at(1), 'john.doe@example.com');
    await tester.enterText(find.byType(RegisterInputField).at(2), '1234567890');
    await tester.enterText(
        find.byType(RegisterInputField).at(3), '123 Main St');
    await tester.enterText(
        find.byType(RegistrationPasswordInputField).at(0), 'password123');
    await tester.enterText(
        find.byType(RegistrationPasswordInputField).at(1), 'password123');

    // Tap the RegisterButton
    await tester.tap(find.byType(RegisterButton));
    await tester.pump();

    // Verify that the RegisterUser event is added to the bloc
    verify(() => mockRegisterBloc.add(RegisterUser(
          context: any(named: 'context'),
          fullName: 'John Doe',
          email: 'john.doe@example.com',
          contactNumber: '1234567890',
          address: '123 Main St',
          password: 'password123',
          confirmPassword: 'password123',
        ))).called(1);
  });

  // Test Case 3: AlreadyHaveAccount Navigates to LoginView
  testWidgets('AlreadyHaveAccount navigates to LoginView',
      (WidgetTester tester) async {
    // Mock the state
    when(() => mockRegisterBloc.state).thenReturn(RegisterState.initial());

    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<RegisterBloc>.value(
          value: mockRegisterBloc,
          child: RegistrationView(),
        ),
      ),
    );

    // Tap the AlreadyHaveAccount widget
    await tester.tap(find.byType(AlreadyHaveAccount));
    await tester.pump();

    // Verify that the NavigateLoginEvent is added to the bloc
    verify(() => mockRegisterBloc.add(NavigateLoginEvent(
          context: any(named: 'context'),
          destination: any(named: 'destination'),
        ))).called(1);
  });

  // Test Case 4: RegistrationPasswordInputField Toggles Password Visibility
  testWidgets('RegistrationPasswordInputField toggles password visibility',
      (WidgetTester tester) async {
    final controller = TextEditingController();

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: RegistrationPasswordInputField(
            hintText: 'Password',
            controller: controller,
            isPassword: true,
          ),
        ),
      ),
    );

    // Verify that the visibility icon is initially set to "visibility_off"
    expect(find.byIcon(Icons.visibility_off), findsOneWidget);
    expect(find.byIcon(Icons.visibility), findsNothing);

    // Tap the visibility icon to toggle password visibility
    await tester.tap(find.byIcon(Icons.visibility_off));
    await tester.pump();

    // Verify that the visibility icon is now set to "visibility"
    expect(find.byIcon(Icons.visibility), findsOneWidget);
    expect(find.byIcon(Icons.visibility_off), findsNothing);
  });
}
