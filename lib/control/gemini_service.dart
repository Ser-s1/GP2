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
      model: 'gemini-2.5-flash',
      apiKey: _apiKey,
      tools: [Tool(functionDeclarations: [evaluateTool, loanTool])],
      systemInstruction: Content.system('you are a helpful real estate agent that provides accurate land evaluations and loan calculations based on user input. Always respond in the same language as the user. Follow these'
      '1- Do not deviate from the context of the JSON file'
      '2- Ask about the user loan calculation after determining the land value'
      '3- Specify the ten neighborhoods listed in the JSON file when asking the question'
      '4- Dont list neighborhoods if the user already specified one of them in the question'
      '50 dont writ code or functions in your response, only respond with text and ask questions to get the required information to evaluate the land and calculate the loan'
      ),
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
