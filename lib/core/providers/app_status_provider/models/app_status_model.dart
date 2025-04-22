import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'app_status_model.freezed.dart';
part 'app_status_model.g.dart';

@Freezed(copyWith: true)
class AppStatusModel with _$AppStatusModel {
  const factory AppStatusModel({
    @JsonKey(name: "CreatedBy") String? createdBy,
    @JsonKey(name: "CreatedOn") DateTime? createdOn,
    @JsonKey(name: "DeviceId") String? deviceId,
    @JsonKey(name: "DeviceName") String? deviceName,
    @JsonKey(name: "IMEI") String? imei,
    @JsonKey(name: "Manufacturer") String? manufacturer,
    @JsonKey(name: "Status") bool? status,
    @JsonKey(name: "app_password") String? appPassword,
    @JsonKey(name: "app_status") String? appStatus,
    @JsonKey(name: "display_name") String? displayName,
    @JsonKey(name: "fcm_token") String? fcmToken,
    @JsonKey(name: "payment_due_date") String? paymentDueDate,
    @JsonKey(name: "payment_due_amount") String? paymentDueAmount,
    @JsonKey(name: "company_id") String? companyId,
    @JsonKey(name: "branch_id") String? branchId,
    @JsonKey(name: "company_name") String? companyName,
    @JsonKey(name: "branch_name") String? branchName,
  }) = _AppStatusModel;

  factory AppStatusModel.fromJson(Map<String, dynamic> json) => _$AppStatusModelFromJson(json);

  @override
  // TODO: implement appPassword
  String? get appPassword => throw UnimplementedError();

  @override
  // TODO: implement appStatus
  String? get appStatus => throw UnimplementedError();

  @override
  // TODO: implement branchId
  String? get branchId => throw UnimplementedError();

  @override
  // TODO: implement branchName
  String? get branchName => throw UnimplementedError();

  @override
  // TODO: implement companyId
  String? get companyId => throw UnimplementedError();

  @override
  // TODO: implement companyName
  String? get companyName => throw UnimplementedError();

  @override
  // TODO: implement createdBy
  String? get createdBy => throw UnimplementedError();

  @override
  // TODO: implement createdOn
  DateTime? get createdOn => throw UnimplementedError();

  @override
  // TODO: implement deviceId
  String? get deviceId => throw UnimplementedError();

  @override
  // TODO: implement deviceName
  String? get deviceName => throw UnimplementedError();

  @override
  // TODO: implement displayName
  String? get displayName => throw UnimplementedError();

  @override
  // TODO: implement fcmToken
  String? get fcmToken => throw UnimplementedError();

  @override
  // TODO: implement imei
  String? get imei => throw UnimplementedError();

  @override
  // TODO: implement manufacturer
  String? get manufacturer => throw UnimplementedError();

  @override
  // TODO: implement paymentDueAmount
  String? get paymentDueAmount => throw UnimplementedError();

  @override
  // TODO: implement paymentDueDate
  String? get paymentDueDate => throw UnimplementedError();

  @override
  // TODO: implement status
  bool? get status => throw UnimplementedError();

  @override
  Map<String, dynamic> toJson() {
    // TODO: implement toJson
    throw UnimplementedError();
  }
}
