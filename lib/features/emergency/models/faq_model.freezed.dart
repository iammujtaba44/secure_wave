// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'faq_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$FAQModel {
  String? get description;
  String? get title;

  /// Create a copy of FAQModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $FAQModelCopyWith<FAQModel> get copyWith =>
      _$FAQModelCopyWithImpl<FAQModel>(this as FAQModel, _$identity);

  /// Serializes this FAQModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is FAQModel &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.title, title) || other.title == title));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, description, title);

  @override
  String toString() {
    return 'FAQModel(description: $description, title: $title)';
  }
}

/// @nodoc
abstract mixin class $FAQModelCopyWith<$Res> {
  factory $FAQModelCopyWith(FAQModel value, $Res Function(FAQModel) _then) =
      _$FAQModelCopyWithImpl;
  @useResult
  $Res call({String? description, String? title});
}

/// @nodoc
class _$FAQModelCopyWithImpl<$Res> implements $FAQModelCopyWith<$Res> {
  _$FAQModelCopyWithImpl(this._self, this._then);

  final FAQModel _self;
  final $Res Function(FAQModel) _then;

  /// Create a copy of FAQModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? description = freezed,
    Object? title = freezed,
  }) {
    return _then(_self.copyWith(
      description: freezed == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      title: freezed == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _FAQModel implements FAQModel {
  const _FAQModel({this.description, this.title});
  factory _FAQModel.fromJson(Map<String, dynamic> json) =>
      _$FAQModelFromJson(json);

  @override
  final String? description;
  @override
  final String? title;

  /// Create a copy of FAQModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$FAQModelCopyWith<_FAQModel> get copyWith =>
      __$FAQModelCopyWithImpl<_FAQModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$FAQModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _FAQModel &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.title, title) || other.title == title));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, description, title);

  @override
  String toString() {
    return 'FAQModel(description: $description, title: $title)';
  }
}

/// @nodoc
abstract mixin class _$FAQModelCopyWith<$Res>
    implements $FAQModelCopyWith<$Res> {
  factory _$FAQModelCopyWith(_FAQModel value, $Res Function(_FAQModel) _then) =
      __$FAQModelCopyWithImpl;
  @override
  @useResult
  $Res call({String? description, String? title});
}

/// @nodoc
class __$FAQModelCopyWithImpl<$Res> implements _$FAQModelCopyWith<$Res> {
  __$FAQModelCopyWithImpl(this._self, this._then);

  final _FAQModel _self;
  final $Res Function(_FAQModel) _then;

  /// Create a copy of FAQModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? description = freezed,
    Object? title = freezed,
  }) {
    return _then(_FAQModel(
      description: freezed == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      title: freezed == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

// dart format on
