import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'onboarding_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://wdyalgfnyfruthiznsyy.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6IndkeWFsZ2ZueWZydXRoaXpuc3l5Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDY2NTI3ODcsImV4cCI6MjAyMjIyODc4N30.W4YIhdZS06_PgjRnAqPMDMrMfh4wEC2YaY9PGAbUka0',
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: OnboardingScreen(),
    );
  }
}