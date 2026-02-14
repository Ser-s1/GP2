import 'package:flutter/material.dart';
import 'package:final_projict/screens/home.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: "https://eeidfphnmkwywsxsfglf.supabase.co",
    anonKey: "sb_publishable_Gh-PxQCiiiivD_Fau0KeKw_fFW4ZhBz",
  );

  runApp(const MainApp());
}

final supabase = Supabase.instance.client;

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Home(),
      debugShowCheckedModeBanner: false,
    locale: Locale('ar', 'SA'),
    );
  }
}
