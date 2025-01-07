import 'package:secure_wave/features/emergency/models/faq_model.dart';

abstract class FaqMapper {
  static List<FAQModel> mapQuestions(Map<String, dynamic> faq) {
    final questions = List.from(faq['questions']);
    return questions.map((q) {
      return FAQModel.fromJson(Map<String, dynamic>.from(q as Map));
    }).toList();
  }
}
