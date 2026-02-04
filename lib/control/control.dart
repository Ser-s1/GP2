import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:final_projict/screens/registration.dart';
import 'package:final_projict/screens/login.dart';


final supabase = Supabase.instance.client;

class AuthControl {
  
  Future<void> signUp(String email, String password) async {
    try {
      await supabase.auth.signUp(
        email: email,
        password: password,
      );
      print(true);
    } catch (e) {
      print("Sign up error: $e");
    }
  }

  Future<void> signIn(String email, String password) async {
    try {
      await supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );
      true;
    } catch (e) {
      print("Login error: $e");
    }
  }

  Future<void> signInWithOtp(String email) async {
    await supabase.auth.signInWithOtp(email: email);
  }

  void listenToAuthChanges() {
    supabase.auth.onAuthStateChange.listen((data) {
      final AuthChangeEvent event = data.event;
      final Session? session = data.session;
      print("Auth Event: $event");
    });
  }
}
class RegisterControl {
  
  Future<void> createAccount(String email, String password) async {
    try {
      await supabase.auth.signUp(
        email: email,
        password: password,
      );
      print("تم إنشاء الحساب بنجاح");
    } catch (e) {
      print("حدث خطأ أثناء إنشاء الحساب: $e");
    }
  }
}