import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mindpeers_intro/features/core/constants/app_colors.dart';
import 'package:mindpeers_intro/features/core/injector/injector.dart';
import 'package:mindpeers_intro/features/core/observers/app_bloc_observers.dart';
import 'package:mindpeers_intro/features/onboarding/bloc/onboarding_bloc.dart';
import 'package:mindpeers_intro/features/onboarding/views/screens/start_screen.dart';
import 'package:sizer/sizer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  configureInjector();

  Bloc.observer = AppBlocObserver();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MultiBlocProvider(
          providers: [
            BlocProvider<OnboardingBloc>(
              create: (context) => getIt<OnboardingBloc>(),
            ),
          ],
          child: MaterialApp(
            title: 'Mindpeers',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              scaffoldBackgroundColor: AppColors.backgroundColor,
              brightness: Brightness.dark,
            ),
            home: const IntroScreen(),
          ),
        );
      },
    );
  }
}
