// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'slider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

SliderModel _$SliderModelFromJson(Map<String, dynamic> json) {
  return _SliderModel.fromJson(json);
}

/// @nodoc
mixin _$SliderModel {
  String get sliderName => throw _privateConstructorUsedError;
  String get sliderImage => throw _privateConstructorUsedError;
  String get sliderId => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SliderModelCopyWith<SliderModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SliderModelCopyWith<$Res> {
  factory $SliderModelCopyWith(
          SliderModel value, $Res Function(SliderModel) then) =
      _$SliderModelCopyWithImpl<$Res, SliderModel>;
  @useResult
  $Res call({String sliderName, String sliderImage, String sliderId});
}

/// @nodoc
class _$SliderModelCopyWithImpl<$Res, $Val extends SliderModel>
    implements $SliderModelCopyWith<$Res> {
  _$SliderModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sliderName = null,
    Object? sliderImage = null,
    Object? sliderId = null,
  }) {
    return _then(_value.copyWith(
      sliderName: null == sliderName
          ? _value.sliderName
          : sliderName // ignore: cast_nullable_to_non_nullable
              as String,
      sliderImage: null == sliderImage
          ? _value.sliderImage
          : sliderImage // ignore: cast_nullable_to_non_nullable
              as String,
      sliderId: null == sliderId
          ? _value.sliderId
          : sliderId // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_SliderModelCopyWith<$Res>
    implements $SliderModelCopyWith<$Res> {
  factory _$$_SliderModelCopyWith(
          _$_SliderModel value, $Res Function(_$_SliderModel) then) =
      __$$_SliderModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String sliderName, String sliderImage, String sliderId});
}

/// @nodoc
class __$$_SliderModelCopyWithImpl<$Res>
    extends _$SliderModelCopyWithImpl<$Res, _$_SliderModel>
    implements _$$_SliderModelCopyWith<$Res> {
  __$$_SliderModelCopyWithImpl(
      _$_SliderModel _value, $Res Function(_$_SliderModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sliderName = null,
    Object? sliderImage = null,
    Object? sliderId = null,
  }) {
    return _then(_$_SliderModel(
      sliderName: null == sliderName
          ? _value.sliderName
          : sliderName // ignore: cast_nullable_to_non_nullable
              as String,
      sliderImage: null == sliderImage
          ? _value.sliderImage
          : sliderImage // ignore: cast_nullable_to_non_nullable
              as String,
      sliderId: null == sliderId
          ? _value.sliderId
          : sliderId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_SliderModel implements _SliderModel {
  _$_SliderModel(
      {required this.sliderName,
      required this.sliderImage,
      required this.sliderId});

  factory _$_SliderModel.fromJson(Map<String, dynamic> json) =>
      _$$_SliderModelFromJson(json);

  @override
  final String sliderName;
  @override
  final String sliderImage;
  @override
  final String sliderId;

  @override
  String toString() {
    return 'SliderModel(sliderName: $sliderName, sliderImage: $sliderImage, sliderId: $sliderId)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SliderModel &&
            (identical(other.sliderName, sliderName) ||
                other.sliderName == sliderName) &&
            (identical(other.sliderImage, sliderImage) ||
                other.sliderImage == sliderImage) &&
            (identical(other.sliderId, sliderId) ||
                other.sliderId == sliderId));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, sliderName, sliderImage, sliderId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SliderModelCopyWith<_$_SliderModel> get copyWith =>
      __$$_SliderModelCopyWithImpl<_$_SliderModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_SliderModelToJson(
      this,
    );
  }
}

abstract class _SliderModel implements SliderModel {
  factory _SliderModel(
      {required final String sliderName,
      required final String sliderImage,
      required final String sliderId}) = _$_SliderModel;

  factory _SliderModel.fromJson(Map<String, dynamic> json) =
      _$_SliderModel.fromJson;

  @override
  String get sliderName;
  @override
  String get sliderImage;
  @override
  String get sliderId;
  @override
  @JsonKey(ignore: true)
  _$$_SliderModelCopyWith<_$_SliderModel> get copyWith =>
      throw _privateConstructorUsedError;
}
