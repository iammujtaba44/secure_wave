// To parse this JSON data, do
//
//     final appStatusModel = appStatusModelFromJson(jsonString);

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
  }) = _AppStatusModel;

  factory AppStatusModel.fromJson(Map<String, dynamic> json) => _$AppStatusModelFromJson(json);
}
