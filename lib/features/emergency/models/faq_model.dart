import 'package:freezed_annotation/freezed_annotation.dart';

part 'faq_model.freezed.dart';
part 'faq_model.g.dart';

@freezed
class FAQModel with _$FAQModel {
  const factory FAQModel({
    String? description,
    String? title,
  }) = _FAQModel;

  factory FAQModel.fromJson(Map<String, dynamic> json) => _$FAQModelFromJson(json);
}
