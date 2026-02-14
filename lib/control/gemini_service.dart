import 'package:google_generative_ai/google_generative_ai.dart';
import 'logic.dart';

class RealEstateAgent {
  late final GenerativeModel _model;
  late ChatSession _chat;
  final String _apiKey = ''; 

  RealEstateAgent() {
    _initialize();
  }

  void _initialize() async {
    
    await loadPropertyData();

    final evaluateTool = FunctionDeclaration(
      'evaluate_land',
      'حساب وتقييم سعر قطعة أرض بناءً على الحي والمساحة والمواصفات.',
      Schema(SchemaType.object, properties: {
        'district': Schema(SchemaType.string, description: 'اسم الحي'),
        'area': Schema(SchemaType.number, description: 'المساحة بالمتر المربع'),
        'type': Schema(SchemaType.string, description: 'نوع الأرض: سكنية أو تجارية', nullable: true),
        'street_count': Schema(SchemaType.number, description: 'عدد الشوارع المحيطة', nullable: true),
        'soil_type': Schema(SchemaType.string, description: 'نوع التربة: خرسانية أو رملية', nullable: true),
        'services_available': Schema(SchemaType.boolean, description: 'هل الخدمات متوفرة؟', nullable: true),
      }, requiredProperties: ['district', 'area']),
    );

    final loanTool = FunctionDeclaration(
      'calculate_loan',
      'حساب القرض العقاري بناءً على قيمة الأرض وراتب المستخدم.',
      Schema(SchemaType.object, properties: {
        'property_value': Schema(SchemaType.number, description: 'القيمة التقديرية للأرض'),
        'salary': Schema(SchemaType.number, description: 'الراتب الشهري للمستخدم', nullable: true),
        'liabilities': Schema(SchemaType.number, description: 'الالتزامات الشهرية', nullable: true),
      }, requiredProperties: ['property_value']),
    );

    _model = GenerativeModel(
      model: 'gemini-3-flash-preview',
      apiKey: _apiKey,
      tools: [Tool(functionDeclarations: [evaluateTool, loanTool])],
      systemInstruction: Content.system('يا حمار لا تجلطني انت مقاول على الاراضي اللي معطيك اياها في ملف الجيسون اي احد يسألك تسعر له بستخدام التطبيق يا تنح '
  'ممنوع المقدمات. مثال: "الحي: الملقا | السعر: 4.5 مليون | سعر المتر: 11,250".'),
    );

    _chat = _model.startChat();
  }

  Future<String> sendMessage(String userMessage) async {
    try {
      var response = await _chat.sendMessage(Content.text(userMessage));

      while (response.functionCalls.isNotEmpty) {
        final functionCall = response.functionCalls.first;
        final args = functionCall.args;
        Map<String, dynamic> result;

        if (functionCall.name == 'evaluate_land') {
          result = await evaluateLand(
            district: args['district'] as String,
            area: (args['area'] as num).toDouble(),
            type: args['type'] as String?,
            streetCount: (args['street_count'] as num?)?.toInt(),
            soilType: args['soil_type'] as String?,
            servicesAvailable: args['services_available'] as bool?,
          );
        } else if (functionCall.name == 'calculate_loan') {
          result = await calculateLoan(
            propertyValue: (args['property_value'] as num).toDouble(),
            salary: (args['salary'] as num?)?.toDouble(),
            liabilities: (args['liabilities'] as num?)?.toDouble(),
          );
        } else {
          result = {'error': 'Function not found'};
        }

        response = await _chat.sendMessage(
          Content.functionResponse(functionCall.name, result),
        );
      }

      return response.text ?? "لم يتم استلام رد.";
    } catch (e) {
      return "خطأ: $e";
    }
  }
}