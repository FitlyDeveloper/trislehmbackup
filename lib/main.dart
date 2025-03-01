import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'Features/onboarding_screen.dart';
import 'firebase_options.dart';
import 'core/utils/device_size_adapter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase on all platforms
  try {
    await FirebaseService.initialize();
    print('Firebase initialized successfully');
  } catch (e) {
    print('Failed to initialize Firebase: $e');
    // Continue without Firebase - the app will use mock services
  }

  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) => const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      builder: (context, child) {
        // Apply DevicePreview builder
        child = DevicePreview.appBuilder(context, child);

        // Apply our custom responsive sizing
        final mediaQuery = MediaQuery.of(context);
        final screenSize = mediaQuery.size;

        // Calculate the scale factor to maintain aspect ratio
        final widthScale = screenSize.width / DeviceSizeAdapter.referenceWidth;
        final heightScale =
            screenSize.height / DeviceSizeAdapter.referenceHeight;
        final scale = widthScale < heightScale ? widthScale : heightScale;

        // Apply font scale to maintain consistent text sizes
        final textScaleFactor = scale;

        return MediaQuery(
          data: mediaQuery.copyWith(
            textScaleFactor: textScaleFactor,
          ),
          child: child!,
        );
      },
      debugShowCheckedModeBanner: false,
      title: 'Gym App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const OnboardingScreen(),
    );
  }
}
