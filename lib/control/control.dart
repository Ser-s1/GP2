import 'package:supabase_flutter/supabase_flutter.dart';



final supabase = Supabase.instance.client;

class AuthControl {
  
  Future<bool> signUp(String email, String password) async {
    try {
      await supabase.auth.signUp(
        email: email,
        password: password,
      );
      return true; 
    } catch (e) {
      print("Sign up error: $e");
      return false;
    }
  }

  Future<bool> signIn(String email, String password) async {
    try {
      await supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );
      return true; 
    } catch (e) {
      print("Login error: $e");
      return false; 
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