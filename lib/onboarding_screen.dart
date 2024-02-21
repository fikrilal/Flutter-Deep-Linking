import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_deep_linking/register_screen.dart';
import 'package:flutter_deep_linking/user_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:crypto/crypto.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {

  void _launchSMS() async {
    final uniqueCode = _generateUniqueCode();
    print('Generated Unique Code: $uniqueCode'); // Tambahkan ini untuk debugging

    const phoneNumber = '+6285156023639'; // Pastikan nomor ini sesuai format dan bisa menerima SMS
    final message = 'Your unique code: $uniqueCode';
    final Uri smsUri = Uri(
      scheme: 'sms',
      path: phoneNumber,
      queryParameters: {'body': message},
    );
    print('SMS URI: $smsUri'); // Debug URI

    if (await canLaunchUrl(smsUri)) {
      await launchUrl(smsUri);
      final userDataStream = getUserData(uniqueCode);
      print('SMS launched'); // Konfirmasi bahwa SMS berhasil diluncurkan
      userDataStream.listen((List<dynamic> userData) {
        if (userData.isNotEmpty) {
          final isVerified = userData.first['isVerified'];
          if (isVerified != null) {
            if (isVerified) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const RegisterScreen()),
              );
            } else {
              print('Status FALSEEEEEEEEEE');
            }
          } else {
            print('isVerified is null');
          }
        } else {
          print('No data found');
        }
      });

    } else {
      print('Could not launch $smsUri');
    }
  }

  String _generateUniqueCode() {
    // Generate random salt value
    final random = Random.secure();
    final saltBytes = Uint8List(16);
    for (int i = 0; i < saltBytes.length; i++) {
      saltBytes[i] = random.nextInt(256); // Generate random byte
    }

    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final bytes = utf8.encode('${base64.encode(saltBytes)}$timestamp');
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: _launchSMS,
          child: Text('Kirim SMS'),
        ),
      ),
    );
  }
}
