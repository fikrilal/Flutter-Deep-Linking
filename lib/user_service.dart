import 'package:supabase_flutter/supabase_flutter.dart';


   final SupabaseClient _supabase = Supabase.instance.client;

   Stream<List<dynamic>> getUserData(String uniqueCode) {
    final stream = _supabase.from('users').stream(primaryKey: ['id']).eq('uniqueCode', uniqueCode);

    // Listen to the stream
    stream.listen((List<dynamic> event) {
      if (event.isNotEmpty) {
        final userData = event.first;
        final isVerified = userData['isVerified'];

        if (isVerified != null) {
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
    return stream;
  }

