// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_status_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AppStatusModel _$AppStatusModelFromJson(Map<String, dynamic> json) =>
    _AppStatusModel(
      createdBy: json['CreatedBy'] as String?,
      createdOn: json['CreatedOn'] == null
          ? null
          : DateTime.parse(json['CreatedOn'] as String),
      deviceId: json['DeviceId'] as String?,
      deviceName: json['DeviceName'] as String?,
      imei: json['IMEI'] as String?,
      manufacturer: json['Manufacturer'] as String?,
      status: json['Status'] as bool?,
      appPassword: json['app_password'] as String?,
      appStatus: json['app_status'] as String?,
      displayName: json['display_name'] as String?,
      fcmToken: json['fcm_token'] as String?,
      paymentDueDate: json['payment_due_date'] as String?,
      paymentDueAmount: json['payment_due_amount'] as String?,
      companyId: json['company_id'] as String?,
      branchId: json['branch_id'] as String?,
      companyName: json['company_name'] as String?,
      branchName: json['branch_name'] as String?,
    );

Map<String, dynamic> _$AppStatusModelToJson(_AppStatusModel instance) =>
    <String, dynamic>{
      'CreatedBy': instance.createdBy,
      'CreatedOn': instance.createdOn?.toIso8601String(),
      'DeviceId': instance.deviceId,
      'DeviceName': instance.deviceName,
      'IMEI': instance.imei,
      'Manufacturer': instance.manufacturer,
      'Status': instance.status,
      'app_password': instance.appPassword,
      'app_status': instance.appStatus,
      'display_name': instance.displayName,
      'fcm_token': instance.fcmToken,
      'payment_due_date': instance.paymentDueDate,
      'payment_due_amount': instance.paymentDueAmount,
      'company_id': instance.companyId,
      'branch_id': instance.branchId,
      'company_name': instance.companyName,
      'branch_name': instance.branchName,
    };
