import 'dart:convert';
import 'package:flutter/services.dart';

List<dynamic> propertyDatabase = [];

/// دالة تحميل البيانات من ملف JSON
Future<void> loadPropertyData() async {
  try {
    final String response = await rootBundle.loadString('lib/assets/properties_data.json');
    propertyDatabase = json.decode(response);
    print(" تحملت ${propertyDatabase.length} سجل.");
  } catch (e) {
    print("ما تحملت: $e");
  }
}

/// الدالة الأولى: تقييم الأرض
Future<Map<String, dynamic>> evaluateLand({
  required String district,
  required double area,
  String? type,
  int? streetCount,
  String? soilType,
  bool? servicesAvailable,
}) async {
  if (propertyDatabase.isEmpty) {
    await loadPropertyData();
  }

final districtData = propertyDatabase.firstWhere(
  (element) {
    String searchKey = district.replaceAll('حي', '').trim();
    return element['district'].toString().contains(searchKey);
  },
  orElse: () => null,

  );

  if (districtData == null) {
    return {
      'status': 'error',
      'message': 'عذراً، لا تتوفر لدينا بيانات تقييم لحي "$district" حالياً.'
    };
  }

  double basePricePerMeter = districtData['base_price_per_meter'].toDouble();
  Map<String, dynamic> defaults = districtData['default_specs'];

  double multiplier = 1.0;

  String reqType = type ?? defaults['type'];
  String defaultType = defaults['type'];
  
  if (reqType == 'تجارية' && defaultType == 'سكنية') {
    multiplier += 0.10; 
  } else if (reqType == 'سكنية' && defaultType == 'تجارية') {
    multiplier -= 0.05; 
  }

  int reqStreets = streetCount ?? defaults['street_count'];
  if (reqStreets == 2) multiplier += 0.05;
  if (reqStreets == 3) multiplier += 0.10;
  if (reqStreets == 4) multiplier += 0.15;

  bool reqServices = servicesAvailable ?? defaults['services_available'];
  if (!reqServices) multiplier -= 0.15;

  
  String reqSoil = soilType ?? defaults['soil_type'];
  if (reqSoil == 'رملية') multiplier -= 0.05;

  
  double finalPricePerMeter = basePricePerMeter * multiplier;
  double totalEstimatedValue = area * finalPricePerMeter;

  return {
    'status': 'success',
    'district': district,
    'area': area,
    'base_price_meter': basePricePerMeter,
    'adjusted_price_meter': finalPricePerMeter,
    'total_value': totalEstimatedValue,
    'details': {
      'type': reqType,
      'streets': reqStreets,
      'services': reqServices ? 'متوفرة' : 'غير متوفرة',
      'soil': reqSoil,
      'multiplier_used': multiplier.toStringAsFixed(2)
    }
  };
}

/// الدالة الثانية: حساب القرض
Future<Map<String, dynamic>> calculateLoan({
  required double propertyValue,
  double? salary,
  double? liabilities,
}) async {
  double userSalary = salary ?? 12000.0;
  double userLiabilities = liabilities ?? 0.0;

  double monthlyLimit = (userSalary - userLiabilities) * 0.65;
  
  int years = 20;
  double maxLoanAmount = monthlyLimit * 12 * years;

  double deficit = propertyValue - maxLoanAmount;
  bool isEligible = maxLoanAmount >= propertyValue;

  return {
    'property_value': propertyValue,
    'user_salary': userSalary,
    'max_loan': maxLoanAmount,
    'is_eligible': isEligible,
    'monthly_installment': monthlyLimit,
    'advice': isEligible 
        ? "ممتاز! راتبك يغطي شراء الأرض بالكامل."
        : "التمويل المتاح (${maxLoanAmount.toStringAsFixed(0)}) أقل من قيمة الأرض. تحتاج لدفعة أولى: ${deficit.toStringAsFixed(0)} ريال."
  };
}