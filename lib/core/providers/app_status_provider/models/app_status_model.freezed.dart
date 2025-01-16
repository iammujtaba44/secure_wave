// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_status_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AppStatusModel _$AppStatusModelFromJson(Map<String, dynamic> json) {
  return _AppStatusModel.fromJson(json);
}

/// @nodoc
mixin _$AppStatusModel {
  @JsonKey(name: "CreatedBy")
  String? get createdBy => throw _privateConstructorUsedError;
  @JsonKey(name: "CreatedOn")
  DateTime? get createdOn => throw _privateConstructorUsedError;
  @JsonKey(name: "DeviceId")
  String? get deviceId => throw _privateConstructorUsedError;
  @JsonKey(name: "DeviceName")
  String? get deviceName => throw _privateConstructorUsedError;
  @JsonKey(name: "IMEI")
  String? get imei => throw _privateConstructorUsedError;
  @JsonKey(name: "Manufacturer")
  String? get manufacturer => throw _privateConstructorUsedError;
  @JsonKey(name: "Status")
  bool? get status => throw _privateConstructorUsedError;
  @JsonKey(name: "app_password")
  String? get appPassword => throw _privateConstructorUsedError;
  @JsonKey(name: "app_status")
  String? get appStatus => throw _privateConstructorUsedError;
  @JsonKey(name: "display_name")
  String? get displayName => throw _privateConstructorUsedError;
  @JsonKey(name: "fcm_token")
  String? get fcmToken => throw _privateConstructorUsedError;
  @JsonKey(name: "payment_due_date")
  String? get paymentDueDate => throw _privateConstructorUsedError;
  @JsonKey(name: "payment_due_amount")
  String? get paymentDueAmount => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AppStatusModelCopyWith<AppStatusModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppStatusModelCopyWith<$Res> {
  factory $AppStatusModelCopyWith(
          AppStatusModel value, $Res Function(AppStatusModel) then) =
      _$AppStatusModelCopyWithImpl<$Res, AppStatusModel>;
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
      @JsonKey(name: "payment_due_amount") String? paymentDueAmount});
}

/// @nodoc
class _$AppStatusModelCopyWithImpl<$Res, $Val extends AppStatusModel>
    implements $AppStatusModelCopyWith<$Res> {
  _$AppStatusModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

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
  }) {
    return _then(_value.copyWith(
      createdBy: freezed == createdBy
          ? _value.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
              as String?,
      createdOn: freezed == createdOn
          ? _value.createdOn
          : createdOn // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      deviceId: freezed == deviceId
          ? _value.deviceId
          : deviceId // ignore: cast_nullable_to_non_nullable
              as String?,
      deviceName: freezed == deviceName
          ? _value.deviceName
          : deviceName // ignore: cast_nullable_to_non_nullable
              as String?,
      imei: freezed == imei
          ? _value.imei
          : imei // ignore: cast_nullable_to_non_nullable
              as String?,
      manufacturer: freezed == manufacturer
          ? _value.manufacturer
          : manufacturer // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as bool?,
      appPassword: freezed == appPassword
          ? _value.appPassword
          : appPassword // ignore: cast_nullable_to_non_nullable
              as String?,
      appStatus: freezed == appStatus
          ? _value.appStatus
          : appStatus // ignore: cast_nullable_to_non_nullable
              as String?,
      displayName: freezed == displayName
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String?,
      fcmToken: freezed == fcmToken
          ? _value.fcmToken
          : fcmToken // ignore: cast_nullable_to_non_nullable
              as String?,
      paymentDueDate: freezed == paymentDueDate
          ? _value.paymentDueDate
          : paymentDueDate // ignore: cast_nullable_to_non_nullable
              as String?,
      paymentDueAmount: freezed == paymentDueAmount
          ? _value.paymentDueAmount
          : paymentDueAmount // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AppStatusModelImplCopyWith<$Res>
    implements $AppStatusModelCopyWith<$Res> {
  factory _$$AppStatusModelImplCopyWith(_$AppStatusModelImpl value,
          $Res Function(_$AppStatusModelImpl) then) =
      __$$AppStatusModelImplCopyWithImpl<$Res>;
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
      @JsonKey(name: "payment_due_amount") String? paymentDueAmount});
}

/// @nodoc
class __$$AppStatusModelImplCopyWithImpl<$Res>
    extends _$AppStatusModelCopyWithImpl<$Res, _$AppStatusModelImpl>
    implements _$$AppStatusModelImplCopyWith<$Res> {
  __$$AppStatusModelImplCopyWithImpl(
      _$AppStatusModelImpl _value, $Res Function(_$AppStatusModelImpl) _then)
      : super(_value, _then);

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
  }) {
    return _then(_$AppStatusModelImpl(
      createdBy: freezed == createdBy
          ? _value.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
              as String?,
      createdOn: freezed == createdOn
          ? _value.createdOn
          : createdOn // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      deviceId: freezed == deviceId
          ? _value.deviceId
          : deviceId // ignore: cast_nullable_to_non_nullable
              as String?,
      deviceName: freezed == deviceName
          ? _value.deviceName
          : deviceName // ignore: cast_nullable_to_non_nullable
              as String?,
      imei: freezed == imei
          ? _value.imei
          : imei // ignore: cast_nullable_to_non_nullable
              as String?,
      manufacturer: freezed == manufacturer
          ? _value.manufacturer
          : manufacturer // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as bool?,
      appPassword: freezed == appPassword
          ? _value.appPassword
          : appPassword // ignore: cast_nullable_to_non_nullable
              as String?,
      appStatus: freezed == appStatus
          ? _value.appStatus
          : appStatus // ignore: cast_nullable_to_non_nullable
              as String?,
      displayName: freezed == displayName
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String?,
      fcmToken: freezed == fcmToken
          ? _value.fcmToken
          : fcmToken // ignore: cast_nullable_to_non_nullable
              as String?,
      paymentDueDate: freezed == paymentDueDate
          ? _value.paymentDueDate
          : paymentDueDate // ignore: cast_nullable_to_non_nullable
              as String?,
      paymentDueAmount: freezed == paymentDueAmount
          ? _value.paymentDueAmount
          : paymentDueAmount // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AppStatusModelImpl implements _AppStatusModel {
  const _$AppStatusModelImpl(
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
      @JsonKey(name: "payment_due_amount") this.paymentDueAmount});

  factory _$AppStatusModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$AppStatusModelImplFromJson(json);

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
  String toString() {
    return 'AppStatusModel(createdBy: $createdBy, createdOn: $createdOn, deviceId: $deviceId, deviceName: $deviceName, imei: $imei, manufacturer: $manufacturer, status: $status, appPassword: $appPassword, appStatus: $appStatus, displayName: $displayName, fcmToken: $fcmToken, paymentDueDate: $paymentDueDate, paymentDueAmount: $paymentDueAmount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppStatusModelImpl &&
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
                other.paymentDueAmount == paymentDueAmount));
  }

  @JsonKey(ignore: true)
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
      paymentDueAmount);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AppStatusModelImplCopyWith<_$AppStatusModelImpl> get copyWith =>
      __$$AppStatusModelImplCopyWithImpl<_$AppStatusModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AppStatusModelImplToJson(
      this,
    );
  }
}

abstract class _AppStatusModel implements AppStatusModel {
  const factory _AppStatusModel(
      {@JsonKey(name: "CreatedBy") final String? createdBy,
      @JsonKey(name: "CreatedOn") final DateTime? createdOn,
      @JsonKey(name: "DeviceId") final String? deviceId,
      @JsonKey(name: "DeviceName") final String? deviceName,
      @JsonKey(name: "IMEI") final String? imei,
      @JsonKey(name: "Manufacturer") final String? manufacturer,
      @JsonKey(name: "Status") final bool? status,
      @JsonKey(name: "app_password") final String? appPassword,
      @JsonKey(name: "app_status") final String? appStatus,
      @JsonKey(name: "display_name") final String? displayName,
      @JsonKey(name: "fcm_token") final String? fcmToken,
      @JsonKey(name: "payment_due_date") final String? paymentDueDate,
      @JsonKey(name: "payment_due_amount")
      final String? paymentDueAmount}) = _$AppStatusModelImpl;

  factory _AppStatusModel.fromJson(Map<String, dynamic> json) =
      _$AppStatusModelImpl.fromJson;

  @override
  @JsonKey(name: "CreatedBy")
  String? get createdBy;
  @override
  @JsonKey(name: "CreatedOn")
  DateTime? get createdOn;
  @override
  @JsonKey(name: "DeviceId")
  String? get deviceId;
  @override
  @JsonKey(name: "DeviceName")
  String? get deviceName;
  @override
  @JsonKey(name: "IMEI")
  String? get imei;
  @override
  @JsonKey(name: "Manufacturer")
  String? get manufacturer;
  @override
  @JsonKey(name: "Status")
  bool? get status;
  @override
  @JsonKey(name: "app_password")
  String? get appPassword;
  @override
  @JsonKey(name: "app_status")
  String? get appStatus;
  @override
  @JsonKey(name: "display_name")
  String? get displayName;
  @override
  @JsonKey(name: "fcm_token")
  String? get fcmToken;
  @override
  @JsonKey(name: "payment_due_date")
  String? get paymentDueDate;
  @override
  @JsonKey(name: "payment_due_amount")
  String? get paymentDueAmount;
  @override
  @JsonKey(ignore: true)
  _$$AppStatusModelImplCopyWith<_$AppStatusModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
