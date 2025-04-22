// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'support_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SupportModel {
  String? get contact;
  String? get title;
  String? get description;

  /// Create a copy of SupportModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SupportModelCopyWith<SupportModel> get copyWith =>
      _$SupportModelCopyWithImpl<SupportModel>(
          this as SupportModel, _$identity);

  /// Serializes this SupportModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SupportModel &&
            (identical(other.contact, contact) || other.contact == contact) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, contact, title, description);

  @override
  String toString() {
    return 'SupportModel(contact: $contact, title: $title, description: $description)';
  }
}

/// @nodoc
abstract mixin class $SupportModelCopyWith<$Res> {
  factory $SupportModelCopyWith(
          SupportModel value, $Res Function(SupportModel) _then) =
      _$SupportModelCopyWithImpl;
  @useResult
  $Res call({String? contact, String? title, String? description});
}

/// @nodoc
class _$SupportModelCopyWithImpl<$Res> implements $SupportModelCopyWith<$Res> {
  _$SupportModelCopyWithImpl(this._self, this._then);

  final SupportModel _self;
  final $Res Function(SupportModel) _then;

  /// Create a copy of SupportModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? contact = freezed,
    Object? title = freezed,
    Object? description = freezed,
  }) {
    return _then(_self.copyWith(
      contact: freezed == contact
          ? _self.contact
          : contact // ignore: cast_nullable_to_non_nullable
              as String?,
      title: freezed == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _SupportModel implements SupportModel {
  const _SupportModel({this.contact, this.title, this.description});
  factory _SupportModel.fromJson(Map<String, dynamic> json) =>
      _$SupportModelFromJson(json);

  @override
  final String? contact;
  @override
  final String? title;
  @override
  final String? description;

  /// Create a copy of SupportModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SupportModelCopyWith<_SupportModel> get copyWith =>
      __$SupportModelCopyWithImpl<_SupportModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$SupportModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SupportModel &&
            (identical(other.contact, contact) || other.contact == contact) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, contact, title, description);

  @override
  String toString() {
    return 'SupportModel(contact: $contact, title: $title, description: $description)';
  }
}

/// @nodoc
abstract mixin class _$SupportModelCopyWith<$Res>
    implements $SupportModelCopyWith<$Res> {
  factory _$SupportModelCopyWith(
          _SupportModel value, $Res Function(_SupportModel) _then) =
      __$SupportModelCopyWithImpl;
  @override
  @useResult
  $Res call({String? contact, String? title, String? description});
}

/// @nodoc
class __$SupportModelCopyWithImpl<$Res>
    implements _$SupportModelCopyWith<$Res> {
  __$SupportModelCopyWithImpl(this._self, this._then);

  final _SupportModel _self;
  final $Res Function(_SupportModel) _then;

  /// Create a copy of SupportModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? contact = freezed,
    Object? title = freezed,
    Object? description = freezed,
  }) {
    return _then(_SupportModel(
      contact: freezed == contact
          ? _self.contact
          : contact // ignore: cast_nullable_to_non_nullable
              as String?,
      title: freezed == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

// dart format on
