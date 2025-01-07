// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'support_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SupportModel _$SupportModelFromJson(Map<String, dynamic> json) {
  return _SupportModel.fromJson(json);
}

/// @nodoc
mixin _$SupportModel {
  String? get contact => throw _privateConstructorUsedError;
  String? get title => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SupportModelCopyWith<SupportModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SupportModelCopyWith<$Res> {
  factory $SupportModelCopyWith(
          SupportModel value, $Res Function(SupportModel) then) =
      _$SupportModelCopyWithImpl<$Res, SupportModel>;
  @useResult
  $Res call({String? contact, String? title, String? description});
}

/// @nodoc
class _$SupportModelCopyWithImpl<$Res, $Val extends SupportModel>
    implements $SupportModelCopyWith<$Res> {
  _$SupportModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? contact = freezed,
    Object? title = freezed,
    Object? description = freezed,
  }) {
    return _then(_value.copyWith(
      contact: freezed == contact
          ? _value.contact
          : contact // ignore: cast_nullable_to_non_nullable
              as String?,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SupportModelImplCopyWith<$Res>
    implements $SupportModelCopyWith<$Res> {
  factory _$$SupportModelImplCopyWith(
          _$SupportModelImpl value, $Res Function(_$SupportModelImpl) then) =
      __$$SupportModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? contact, String? title, String? description});
}

/// @nodoc
class __$$SupportModelImplCopyWithImpl<$Res>
    extends _$SupportModelCopyWithImpl<$Res, _$SupportModelImpl>
    implements _$$SupportModelImplCopyWith<$Res> {
  __$$SupportModelImplCopyWithImpl(
      _$SupportModelImpl _value, $Res Function(_$SupportModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? contact = freezed,
    Object? title = freezed,
    Object? description = freezed,
  }) {
    return _then(_$SupportModelImpl(
      contact: freezed == contact
          ? _value.contact
          : contact // ignore: cast_nullable_to_non_nullable
              as String?,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SupportModelImpl implements _SupportModel {
  const _$SupportModelImpl({this.contact, this.title, this.description});

  factory _$SupportModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$SupportModelImplFromJson(json);

  @override
  final String? contact;
  @override
  final String? title;
  @override
  final String? description;

  @override
  String toString() {
    return 'SupportModel(contact: $contact, title: $title, description: $description)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SupportModelImpl &&
            (identical(other.contact, contact) || other.contact == contact) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, contact, title, description);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SupportModelImplCopyWith<_$SupportModelImpl> get copyWith =>
      __$$SupportModelImplCopyWithImpl<_$SupportModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SupportModelImplToJson(
      this,
    );
  }
}

abstract class _SupportModel implements SupportModel {
  const factory _SupportModel(
      {final String? contact,
      final String? title,
      final String? description}) = _$SupportModelImpl;

  factory _SupportModel.fromJson(Map<String, dynamic> json) =
      _$SupportModelImpl.fromJson;

  @override
  String? get contact;
  @override
  String? get title;
  @override
  String? get description;
  @override
  @JsonKey(ignore: true)
  _$$SupportModelImplCopyWith<_$SupportModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
