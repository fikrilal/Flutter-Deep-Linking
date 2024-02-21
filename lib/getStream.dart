import 'dart:async';

import 'package:supabase_flutter/supabase_flutter.dart';

class UserData {
  StreamController<bool> _isVerifiedController = StreamController<bool>.broadcast();
  final supabase = Supabase.instance.client;

  Stream<bool> get isVerifiedStream => _isVerifiedController.stream;

  void getUserData(String uniqueCode) {
    final stream = supabase.from('users').stream(primaryKey: ['id']).eq('uniqueCode', uniqueCode);

    // Listen to the stream and print the data
    stream.listen((List<dynamic> event) {
      if (event.isNotEmpty) {
        final userData = event.first;
        final isVerified = userData['isVerified'];

        if (isVerified != null) {
          _isVerifiedController.add(isVerified);
          if (isVerified) {
            print('Status TRUE');
          } else {
            print('Status FALSE');
          }
        } else {
          print('isVerified is null');
        }
      } else {
        print('No data found');
      }
    });
  }

  void dispose() {
    _isVerifiedController.close();
  }
}