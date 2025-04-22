// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_status_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AppStatusModel {
  @JsonKey(name: "CreatedBy")
  String? get createdBy;
  @JsonKey(name: "CreatedOn")
  DateTime? get createdOn;
  @JsonKey(name: "DeviceId")
  String? get deviceId;
  @JsonKey(name: "DeviceName")
  String? get deviceName;
  @JsonKey(name: "IMEI")
  String? get imei;
  @JsonKey(name: "Manufacturer")
  String? get manufacturer;
  @JsonKey(name: "Status")
  bool? get status;
  @JsonKey(name: "app_password")
  String? get appPassword;
  @JsonKey(name: "app_status")
  String? get appStatus;
  @JsonKey(name: "display_name")
  String? get displayName;
  @JsonKey(name: "fcm_token")
  String? get fcmToken;
  @JsonKey(name: "payment_due_date")
  String? get paymentDueDate;
  @JsonKey(name: "payment_due_amount")
  String? get paymentDueAmount;
  @JsonKey(name: "company_id")
  String? get companyId;
  @JsonKey(name: "branch_id")
  String? get branchId;
  @JsonKey(name: "company_name")
  String? get companyName;
  @JsonKey(name: "branch_name")
  String? get branchName;

  /// Create a copy of AppStatusModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $AppStatusModelCopyWith<AppStatusModel> get copyWith =>
      _$AppStatusModelCopyWithImpl<AppStatusModel>(
          this as AppStatusModel, _$identity);

  /// Serializes this AppStatusModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AppStatusModel &&
            (identical(other.createdBy, createdBy) ||
                other.createdBy == createdBy) &&
            (identical(other.createdOn, createdOn) ||
                other.createdOn == createdOn) &&
            (identical(other.deviceId, deviceId) ||
                other.deviceId == deviceId) &&
            (identical(other.deviceName, deviceName) ||
                other.deviceName == deviceName) &&
            (identical(other.imei, imei) || other.imei == imei) &&
            (identical(other.manufacturer, manufacturer) ||
                other.manufacturer == manufacturer) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.appPassword, appPassword) ||
                other.appPassword == appPassword) &&
            (identical(other.appStatus, appStatus) ||
                other.appStatus == appStatus) &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName) &&
            (identical(other.fcmToken, fcmToken) ||
                other.fcmToken == fcmToken) &&
            (identical(other.paymentDueDate, paymentDueDate) ||
                other.paymentDueDate == paymentDueDate) &&
            (identical(other.paymentDueAmount, paymentDueAmount) ||
                other.paymentDueAmount == paymentDueAmount) &&
            (identical(other.companyId, companyId) ||
                other.companyId == companyId) &&
            (identical(other.branchId, branchId) ||
                other.branchId == branchId) &&
            (identical(other.companyName, companyName) ||
                other.companyName == companyName) &&
            (identical(other.branchName, branchName) ||
                other.branchName == branchName));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      createdBy,
      createdOn,
      deviceId,
      deviceName,
      imei,
      manufacturer,
      status,
      appPassword,
      appStatus,
      displayName,
      fcmToken,
      paymentDueDate,
      paymentDueAmount,
      companyId,
      branchId,
      companyName,
      branchName);

  @override
  String toString() {
    return 'AppStatusModel(createdBy: $createdBy, createdOn: $createdOn, deviceId: $deviceId, deviceName: $deviceName, imei: $imei, manufacturer: $manufacturer, status: $status, appPassword: $appPassword, appStatus: $appStatus, displayName: $displayName, fcmToken: $fcmToken, paymentDueDate: $paymentDueDate, paymentDueAmount: $paymentDueAmount, companyId: $companyId, branchId: $branchId, companyName: $companyName, branchName: $branchName)';
  }
}

/// @nodoc
abstract mixin class $AppStatusModelCopyWith<$Res> {
  factory $AppStatusModelCopyWith(
          AppStatusModel value, $Res Function(AppStatusModel) _then) =
      _$AppStatusModelCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: "CreatedBy") String? createdBy,
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
      @JsonKey(name: "branch_name") String? branchName});
}

/// @nodoc
class _$AppStatusModelCopyWithImpl<$Res>
    implements $AppStatusModelCopyWith<$Res> {
  _$AppStatusModelCopyWithImpl(this._self, this._then);

  final AppStatusModel _self;
  final $Res Function(AppStatusModel) _then;

  /// Create a copy of AppStatusModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? createdBy = freezed,
    Object? createdOn = freezed,
    Object? deviceId = freezed,
    Object? deviceName = freezed,
    Object? imei = freezed,
    Object? manufacturer = freezed,
    Object? status = freezed,
    Object? appPassword = freezed,
    Object? appStatus = freezed,
    Object? displayName = freezed,
    Object? fcmToken = freezed,
    Object? paymentDueDate = freezed,
    Object? paymentDueAmount = freezed,
    Object? companyId = freezed,
    Object? branchId = freezed,
    Object? companyName = freezed,
    Object? branchName = freezed,
  }) {
    return _then(_self.copyWith(
      createdBy: freezed == createdBy
          ? _self.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
              as String?,
      createdOn: freezed == createdOn
          ? _self.createdOn
          : createdOn // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      deviceId: freezed == deviceId
          ? _self.deviceId
          : deviceId // ignore: cast_nullable_to_non_nullable
              as String?,
      deviceName: freezed == deviceName
          ? _self.deviceName
          : deviceName // ignore: cast_nullable_to_non_nullable
              as String?,
      imei: freezed == imei
          ? _self.imei
          : imei // ignore: cast_nullable_to_non_nullable
              as String?,
      manufacturer: freezed == manufacturer
          ? _self.manufacturer
          : manufacturer // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as bool?,
      appPassword: freezed == appPassword
          ? _self.appPassword
          : appPassword // ignore: cast_nullable_to_non_nullable
              as String?,
      appStatus: freezed == appStatus
          ? _self.appStatus
          : appStatus // ignore: cast_nullable_to_non_nullable
              as String?,
      displayName: freezed == displayName
          ? _self.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String?,
      fcmToken: freezed == fcmToken
          ? _self.fcmToken
          : fcmToken // ignore: cast_nullable_to_non_nullable
              as String?,
      paymentDueDate: freezed == paymentDueDate
          ? _self.paymentDueDate
          : paymentDueDate // ignore: cast_nullable_to_non_nullable
              as String?,
      paymentDueAmount: freezed == paymentDueAmount
          ? _self.paymentDueAmount
          : paymentDueAmount // ignore: cast_nullable_to_non_nullable
              as String?,
      companyId: freezed == companyId
          ? _self.companyId
          : companyId // ignore: cast_nullable_to_non_nullable
              as String?,
      branchId: freezed == branchId
          ? _self.branchId
          : branchId // ignore: cast_nullable_to_non_nullable
              as String?,
      companyName: freezed == companyName
          ? _self.companyName
          : companyName // ignore: cast_nullable_to_non_nullable
              as String?,
      branchName: freezed == branchName
          ? _self.branchName
          : branchName // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _AppStatusModel implements AppStatusModel {
  const _AppStatusModel(
      {@JsonKey(name: "CreatedBy") this.createdBy,
      @JsonKey(name: "CreatedOn") this.createdOn,
      @JsonKey(name: "DeviceId") this.deviceId,
      @JsonKey(name: "DeviceName") this.deviceName,
      @JsonKey(name: "IMEI") this.imei,
      @JsonKey(name: "Manufacturer") this.manufacturer,
      @JsonKey(name: "Status") this.status,
      @JsonKey(name: "app_password") this.appPassword,
      @JsonKey(name: "app_status") this.appStatus,
      @JsonKey(name: "display_name") this.displayName,
      @JsonKey(name: "fcm_token") this.fcmToken,
      @JsonKey(name: "payment_due_date") this.paymentDueDate,
      @JsonKey(name: "payment_due_amount") this.paymentDueAmount,
      @JsonKey(name: "company_id") this.companyId,
      @JsonKey(name: "branch_id") this.branchId,
      @JsonKey(name: "company_name") this.companyName,
      @JsonKey(name: "branch_name") this.branchName});
  factory _AppStatusModel.fromJson(Map<String, dynamic> json) =>
      _$AppStatusModelFromJson(json);

  @override
  @JsonKey(name: "CreatedBy")
  final String? createdBy;
  @override
  @JsonKey(name: "CreatedOn")
  final DateTime? createdOn;
  @override
  @JsonKey(name: "DeviceId")
  final String? deviceId;
  @override
  @JsonKey(name: "DeviceName")
  final String? deviceName;
  @override
  @JsonKey(name: "IMEI")
  final String? imei;
  @override
  @JsonKey(name: "Manufacturer")
  final String? manufacturer;
  @override
  @JsonKey(name: "Status")
  final bool? status;
  @override
  @JsonKey(name: "app_password")
  final String? appPassword;
  @override
  @JsonKey(name: "app_status")
  final String? appStatus;
  @override
  @JsonKey(name: "display_name")
  final String? displayName;
  @override
  @JsonKey(name: "fcm_token")
  final String? fcmToken;
  @override
  @JsonKey(name: "payment_due_date")
  final String? paymentDueDate;
  @override
  @JsonKey(name: "payment_due_amount")
  final String? paymentDueAmount;
  @override
  @JsonKey(name: "company_id")
  final String? companyId;
  @override
  @JsonKey(name: "branch_id")
  final String? branchId;
  @override
  @JsonKey(name: "company_name")
  final String? companyName;
  @override
  @JsonKey(name: "branch_name")
  final String? branchName;

  /// Create a copy of AppStatusModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$AppStatusModelCopyWith<_AppStatusModel> get copyWith =>
      __$AppStatusModelCopyWithImpl<_AppStatusModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$AppStatusModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _AppStatusModel &&
            (identical(other.createdBy, createdBy) ||
                other.createdBy == createdBy) &&
            (identical(other.createdOn, createdOn) ||
                other.createdOn == createdOn) &&
            (identical(other.deviceId, deviceId) ||
                other.deviceId == deviceId) &&
            (identical(other.deviceName, deviceName) ||
                other.deviceName == deviceName) &&
            (identical(other.imei, imei) || other.imei == imei) &&
            (identical(other.manufacturer, manufacturer) ||
                other.manufacturer == manufacturer) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.appPassword, appPassword) ||
                other.appPassword == appPassword) &&
            (identical(other.appStatus, appStatus) ||
                other.appStatus == appStatus) &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName) &&
            (identical(other.fcmToken, fcmToken) ||
                other.fcmToken == fcmToken) &&
            (identical(other.paymentDueDate, paymentDueDate) ||
                other.paymentDueDate == paymentDueDate) &&
            (identical(other.paymentDueAmount, paymentDueAmount) ||
                other.paymentDueAmount == paymentDueAmount) &&
            (identical(other.companyId, companyId) ||
                other.companyId == companyId) &&
            (identical(other.branchId, branchId) ||
                other.branchId == branchId) &&
            (identical(other.companyName, companyName) ||
                other.companyName == companyName) &&
            (identical(other.branchName, branchName) ||
                other.branchName == branchName));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      createdBy,
      createdOn,
      deviceId,
      deviceName,
      imei,
      manufacturer,
      status,
      appPassword,
      appStatus,
      displayName,
      fcmToken,
      paymentDueDate,
      paymentDueAmount,
      companyId,
      branchId,
      companyName,
      branchName);

  @override
  String toString() {
    return 'AppStatusModel(createdBy: $createdBy, createdOn: $createdOn, deviceId: $deviceId, deviceName: $deviceName, imei: $imei, manufacturer: $manufacturer, status: $status, appPassword: $appPassword, appStatus: $appStatus, displayName: $displayName, fcmToken: $fcmToken, paymentDueDate: $paymentDueDate, paymentDueAmount: $paymentDueAmount, companyId: $companyId, branchId: $branchId, companyName: $companyName, branchName: $branchName)';
  }
}

/// @nodoc
abstract mixin class _$AppStatusModelCopyWith<$Res>
    implements $AppStatusModelCopyWith<$Res> {
  factory _$AppStatusModelCopyWith(
          _AppStatusModel value, $Res Function(_AppStatusModel) _then) =
      __$AppStatusModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "CreatedBy") String? createdBy,
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
      @JsonKey(name: "branch_name") String? branchName});
}

/// @nodoc
class __$AppStatusModelCopyWithImpl<$Res>
    implements _$AppStatusModelCopyWith<$Res> {
  __$AppStatusModelCopyWithImpl(this._self, this._then);

  final _AppStatusModel _self;
  final $Res Function(_AppStatusModel) _then;

  /// Create a copy of AppStatusModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? createdBy = freezed,
    Object? createdOn = freezed,
    Object? deviceId = freezed,
    Object? deviceName = freezed,
    Object? imei = freezed,
    Object? manufacturer = freezed,
    Object? status = freezed,
    Object? appPassword = freezed,
    Object? appStatus = freezed,
    Object? displayName = freezed,
    Object? fcmToken = freezed,
    Object? paymentDueDate = freezed,
    Object? paymentDueAmount = freezed,
    Object? companyId = freezed,
    Object? branchId = freezed,
    Object? companyName = freezed,
    Object? branchName = freezed,
  }) {
    return _then(_AppStatusModel(
      createdBy: freezed == createdBy
          ? _self.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
              as String?,
      createdOn: freezed == createdOn
          ? _self.createdOn
          : createdOn // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      deviceId: freezed == deviceId
          ? _self.deviceId
          : deviceId // ignore: cast_nullable_to_non_nullable
              as String?,
      deviceName: freezed == deviceName
          ? _self.deviceName
          : deviceName // ignore: cast_nullable_to_non_nullable
              as String?,
      imei: freezed == imei
          ? _self.imei
          : imei // ignore: cast_nullable_to_non_nullable
              as String?,
      manufacturer: freezed == manufacturer
          ? _self.manufacturer
          : manufacturer // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as bool?,
      appPassword: freezed == appPassword
          ? _self.appPassword
          : appPassword // ignore: cast_nullable_to_non_nullable
              as String?,
      appStatus: freezed == appStatus
          ? _self.appStatus
          : appStatus // ignore: cast_nullable_to_non_nullable
              as String?,
      displayName: freezed == displayName
          ? _self.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String?,
      fcmToken: freezed == fcmToken
          ? _self.fcmToken
          : fcmToken // ignore: cast_nullable_to_non_nullable
              as String?,
      paymentDueDate: freezed == paymentDueDate
          ? _self.paymentDueDate
          : paymentDueDate // ignore: cast_nullable_to_non_nullable
              as String?,
      paymentDueAmount: freezed == paymentDueAmount
          ? _self.paymentDueAmount
          : paymentDueAmount // ignore: cast_nullable_to_non_nullable
              as String?,
      companyId: freezed == companyId
          ? _self.companyId
          : companyId // ignore: cast_nullable_to_non_nullable
              as String?,
      branchId: freezed == branchId
          ? _self.branchId
          : branchId // ignore: cast_nullable_to_non_nullable
              as String?,
      companyName: freezed == companyName
          ? _self.companyName
          : companyName // ignore: cast_nullable_to_non_nullable
              as String?,
      branchName: freezed == branchName
          ? _self.branchName
          : branchName // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

// dart format on
