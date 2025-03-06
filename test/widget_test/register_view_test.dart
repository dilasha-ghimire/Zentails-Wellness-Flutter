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

  // Test Case 2: RegistrationPasswordInputField Toggles Password Visibility
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
