import 'package:freezed_annotation/freezed_annotation.dart';

part 'support_model.freezed.dart';
part 'support_model.g.dart';

@freezed
class SupportModel with _$SupportModel {
  const factory SupportModel({
    String? contact,
    String? title,
    String? description,
  }) = _SupportModel;

  factory SupportModel.fromJson(Map<String, dynamic> json) => _$SupportModelFromJson(json);

  @override
  // TODO: implement contact
  String? get contact => throw UnimplementedError();

  @override
  // TODO: implement description
  String? get description => throw UnimplementedError();

  @override
  // TODO: implement title
  String? get title => throw UnimplementedError();

  @override
  Map<String, dynamic> toJson() {
    // TODO: implement toJson
    throw UnimplementedError();
  }
}
