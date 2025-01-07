// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'faq_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

FAQModel _$FAQModelFromJson(Map<String, dynamic> json) {
  return _FAQModel.fromJson(json);
}

/// @nodoc
mixin _$FAQModel {
  String? get description => throw _privateConstructorUsedError;
  String? get title => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FAQModelCopyWith<FAQModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FAQModelCopyWith<$Res> {
  factory $FAQModelCopyWith(FAQModel value, $Res Function(FAQModel) then) =
      _$FAQModelCopyWithImpl<$Res, FAQModel>;
  @useResult
  $Res call({String? description, String? title});
}

/// @nodoc
class _$FAQModelCopyWithImpl<$Res, $Val extends FAQModel>
    implements $FAQModelCopyWith<$Res> {
  _$FAQModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? description = freezed,
    Object? title = freezed,
  }) {
    return _then(_value.copyWith(
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FAQModelImplCopyWith<$Res>
    implements $FAQModelCopyWith<$Res> {
  factory _$$FAQModelImplCopyWith(
          _$FAQModelImpl value, $Res Function(_$FAQModelImpl) then) =
      __$$FAQModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? description, String? title});
}

/// @nodoc
class __$$FAQModelImplCopyWithImpl<$Res>
    extends _$FAQModelCopyWithImpl<$Res, _$FAQModelImpl>
    implements _$$FAQModelImplCopyWith<$Res> {
  __$$FAQModelImplCopyWithImpl(
      _$FAQModelImpl _value, $Res Function(_$FAQModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? description = freezed,
    Object? title = freezed,
  }) {
    return _then(_$FAQModelImpl(
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FAQModelImpl implements _FAQModel {
  const _$FAQModelImpl({this.description, this.title});

  factory _$FAQModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$FAQModelImplFromJson(json);

  @override
  final String? description;
  @override
  final String? title;

  @override
  String toString() {
    return 'FAQModel(description: $description, title: $title)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FAQModelImpl &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.title, title) || other.title == title));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, description, title);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FAQModelImplCopyWith<_$FAQModelImpl> get copyWith =>
      __$$FAQModelImplCopyWithImpl<_$FAQModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FAQModelImplToJson(
      this,
    );
  }
}

abstract class _FAQModel implements FAQModel {
  const factory _FAQModel({final String? description, final String? title}) =
      _$FAQModelImpl;

  factory _FAQModel.fromJson(Map<String, dynamic> json) =
      _$FAQModelImpl.fromJson;

  @override
  String? get description;
  @override
  String? get title;
  @override
  @JsonKey(ignore: true)
  _$$FAQModelImplCopyWith<_$FAQModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
