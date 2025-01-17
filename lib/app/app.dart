import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zentails_wellness/app/di/di.dart';
import 'package:zentails_wellness/core/theme/app_theme.dart';
import 'package:zentails_wellness/features/auth/presentation/view_model/login/login_bloc.dart';
import 'package:zentails_wellness/features/auth/presentation/view_model/register/register_bloc.dart';
import 'package:zentails_wellness/features/onboarding/presentation/view_model/onboarding_bloc.dart';
import 'package:zentails_wellness/features/splash/presentation/view/splash_view.dart';
import 'package:zentails_wellness/features/splash/presentation/view_model/splash_cubit.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => getIt<SplashCubit>(),
        ),
        BlocProvider(
          create: (_) => getIt<LoginBloc>(),
        ),
        BlocProvider(
          create: (_) => getIt<RegisterBloc>(),
        ),
        BlocProvider(
          create: (_) => getIt<OnboardingBloc>(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Zentails Wellness',
        theme: getApplicationTheme(),
        home: const SplashView(),
      ),
    );
  }
}