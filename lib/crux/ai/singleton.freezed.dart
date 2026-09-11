// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'singleton.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AiHistory {

 String get field0;
/// Create a copy of AiHistory
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AiHistoryCopyWith<AiHistory> get copyWith => _$AiHistoryCopyWithImpl<AiHistory>(this as AiHistory, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AiHistory&&(identical(other.field0, field0) || other.field0 == field0));
}


@override
int get hashCode => Object.hash(runtimeType,field0);

@override
String toString() {
  return 'AiHistory(field0: $field0)';
}


}

/// @nodoc
abstract mixin class $AiHistoryCopyWith<$Res>  {
  factory $AiHistoryCopyWith(AiHistory value, $Res Function(AiHistory) _then) = _$AiHistoryCopyWithImpl;
@useResult
$Res call({
 String field0
});




}
/// @nodoc
class _$AiHistoryCopyWithImpl<$Res>
    implements $AiHistoryCopyWith<$Res> {
  _$AiHistoryCopyWithImpl(this._self, this._then);

  final AiHistory _self;
  final $Res Function(AiHistory) _then;

/// Create a copy of AiHistory
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? field0 = null,}) {
  return _then(_self.copyWith(
field0: null == field0 ? _self.field0 : field0 // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [AiHistory].
extension AiHistoryPatterns on AiHistory {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( AiHistory_Assistant value)?  assistant,TResult Function( AiHistory_User value)?  user,required TResult orElse(),}){
final _that = this;
switch (_that) {
case AiHistory_Assistant() when assistant != null:
return assistant(_that);case AiHistory_User() when user != null:
return user(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( AiHistory_Assistant value)  assistant,required TResult Function( AiHistory_User value)  user,}){
final _that = this;
switch (_that) {
case AiHistory_Assistant():
return assistant(_that);case AiHistory_User():
return user(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( AiHistory_Assistant value)?  assistant,TResult? Function( AiHistory_User value)?  user,}){
final _that = this;
switch (_that) {
case AiHistory_Assistant() when assistant != null:
return assistant(_that);case AiHistory_User() when user != null:
return user(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String field0)?  assistant,TResult Function( String field0)?  user,required TResult orElse(),}) {final _that = this;
switch (_that) {
case AiHistory_Assistant() when assistant != null:
return assistant(_that.field0);case AiHistory_User() when user != null:
return user(_that.field0);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String field0)  assistant,required TResult Function( String field0)  user,}) {final _that = this;
switch (_that) {
case AiHistory_Assistant():
return assistant(_that.field0);case AiHistory_User():
return user(_that.field0);}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String field0)?  assistant,TResult? Function( String field0)?  user,}) {final _that = this;
switch (_that) {
case AiHistory_Assistant() when assistant != null:
return assistant(_that.field0);case AiHistory_User() when user != null:
return user(_that.field0);case _:
  return null;

}
}

}

/// @nodoc


class AiHistory_Assistant extends AiHistory {
  const AiHistory_Assistant(this.field0): super._();
  

@override final  String field0;

/// Create a copy of AiHistory
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AiHistory_AssistantCopyWith<AiHistory_Assistant> get copyWith => _$AiHistory_AssistantCopyWithImpl<AiHistory_Assistant>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AiHistory_Assistant&&(identical(other.field0, field0) || other.field0 == field0));
}


@override
int get hashCode => Object.hash(runtimeType,field0);

@override
String toString() {
  return 'AiHistory.assistant(field0: $field0)';
}


}

/// @nodoc
abstract mixin class $AiHistory_AssistantCopyWith<$Res> implements $AiHistoryCopyWith<$Res> {
  factory $AiHistory_AssistantCopyWith(AiHistory_Assistant value, $Res Function(AiHistory_Assistant) _then) = _$AiHistory_AssistantCopyWithImpl;
@override @useResult
$Res call({
 String field0
});




}
/// @nodoc
class _$AiHistory_AssistantCopyWithImpl<$Res>
    implements $AiHistory_AssistantCopyWith<$Res> {
  _$AiHistory_AssistantCopyWithImpl(this._self, this._then);

  final AiHistory_Assistant _self;
  final $Res Function(AiHistory_Assistant) _then;

/// Create a copy of AiHistory
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? field0 = null,}) {
  return _then(AiHistory_Assistant(
null == field0 ? _self.field0 : field0 // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class AiHistory_User extends AiHistory {
  const AiHistory_User(this.field0): super._();
  

@override final  String field0;

/// Create a copy of AiHistory
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AiHistory_UserCopyWith<AiHistory_User> get copyWith => _$AiHistory_UserCopyWithImpl<AiHistory_User>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AiHistory_User&&(identical(other.field0, field0) || other.field0 == field0));
}


@override
int get hashCode => Object.hash(runtimeType,field0);

@override
String toString() {
  return 'AiHistory.user(field0: $field0)';
}


}

/// @nodoc
abstract mixin class $AiHistory_UserCopyWith<$Res> implements $AiHistoryCopyWith<$Res> {
  factory $AiHistory_UserCopyWith(AiHistory_User value, $Res Function(AiHistory_User) _then) = _$AiHistory_UserCopyWithImpl;
@override @useResult
$Res call({
 String field0
});




}
/// @nodoc
class _$AiHistory_UserCopyWithImpl<$Res>
    implements $AiHistory_UserCopyWith<$Res> {
  _$AiHistory_UserCopyWithImpl(this._self, this._then);

  final AiHistory_User _self;
  final $Res Function(AiHistory_User) _then;

/// Create a copy of AiHistory
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? field0 = null,}) {
  return _then(AiHistory_User(
null == field0 ? _self.field0 : field0 // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$AiResponse {

 String get field0;
/// Create a copy of AiResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AiResponseCopyWith<AiResponse> get copyWith => _$AiResponseCopyWithImpl<AiResponse>(this as AiResponse, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AiResponse&&(identical(other.field0, field0) || other.field0 == field0));
}


@override
int get hashCode => Object.hash(runtimeType,field0);

@override
String toString() {
  return 'AiResponse(field0: $field0)';
}


}

/// @nodoc
abstract mixin class $AiResponseCopyWith<$Res>  {
  factory $AiResponseCopyWith(AiResponse value, $Res Function(AiResponse) _then) = _$AiResponseCopyWithImpl;
@useResult
$Res call({
 String field0
});




}
/// @nodoc
class _$AiResponseCopyWithImpl<$Res>
    implements $AiResponseCopyWith<$Res> {
  _$AiResponseCopyWithImpl(this._self, this._then);

  final AiResponse _self;
  final $Res Function(AiResponse) _then;

/// Create a copy of AiResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? field0 = null,}) {
  return _then(_self.copyWith(
field0: null == field0 ? _self.field0 : field0 // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [AiResponse].
extension AiResponsePatterns on AiResponse {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( AiResponse_Tool value)?  tool,TResult Function( AiResponse_Response value)?  response,required TResult orElse(),}){
final _that = this;
switch (_that) {
case AiResponse_Tool() when tool != null:
return tool(_that);case AiResponse_Response() when response != null:
return response(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( AiResponse_Tool value)  tool,required TResult Function( AiResponse_Response value)  response,}){
final _that = this;
switch (_that) {
case AiResponse_Tool():
return tool(_that);case AiResponse_Response():
return response(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( AiResponse_Tool value)?  tool,TResult? Function( AiResponse_Response value)?  response,}){
final _that = this;
switch (_that) {
case AiResponse_Tool() when tool != null:
return tool(_that);case AiResponse_Response() when response != null:
return response(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String field0)?  tool,TResult Function( String field0)?  response,required TResult orElse(),}) {final _that = this;
switch (_that) {
case AiResponse_Tool() when tool != null:
return tool(_that.field0);case AiResponse_Response() when response != null:
return response(_that.field0);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String field0)  tool,required TResult Function( String field0)  response,}) {final _that = this;
switch (_that) {
case AiResponse_Tool():
return tool(_that.field0);case AiResponse_Response():
return response(_that.field0);}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String field0)?  tool,TResult? Function( String field0)?  response,}) {final _that = this;
switch (_that) {
case AiResponse_Tool() when tool != null:
return tool(_that.field0);case AiResponse_Response() when response != null:
return response(_that.field0);case _:
  return null;

}
}

}

/// @nodoc


class AiResponse_Tool extends AiResponse {
  const AiResponse_Tool(this.field0): super._();
  

@override final  String field0;

/// Create a copy of AiResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AiResponse_ToolCopyWith<AiResponse_Tool> get copyWith => _$AiResponse_ToolCopyWithImpl<AiResponse_Tool>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AiResponse_Tool&&(identical(other.field0, field0) || other.field0 == field0));
}


@override
int get hashCode => Object.hash(runtimeType,field0);

@override
String toString() {
  return 'AiResponse.tool(field0: $field0)';
}


}

/// @nodoc
abstract mixin class $AiResponse_ToolCopyWith<$Res> implements $AiResponseCopyWith<$Res> {
  factory $AiResponse_ToolCopyWith(AiResponse_Tool value, $Res Function(AiResponse_Tool) _then) = _$AiResponse_ToolCopyWithImpl;
@override @useResult
$Res call({
 String field0
});




}
/// @nodoc
class _$AiResponse_ToolCopyWithImpl<$Res>
    implements $AiResponse_ToolCopyWith<$Res> {
  _$AiResponse_ToolCopyWithImpl(this._self, this._then);

  final AiResponse_Tool _self;
  final $Res Function(AiResponse_Tool) _then;

/// Create a copy of AiResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? field0 = null,}) {
  return _then(AiResponse_Tool(
null == field0 ? _self.field0 : field0 // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class AiResponse_Response extends AiResponse {
  const AiResponse_Response(this.field0): super._();
  

@override final  String field0;

/// Create a copy of AiResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AiResponse_ResponseCopyWith<AiResponse_Response> get copyWith => _$AiResponse_ResponseCopyWithImpl<AiResponse_Response>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AiResponse_Response&&(identical(other.field0, field0) || other.field0 == field0));
}


@override
int get hashCode => Object.hash(runtimeType,field0);

@override
String toString() {
  return 'AiResponse.response(field0: $field0)';
}


}

/// @nodoc
abstract mixin class $AiResponse_ResponseCopyWith<$Res> implements $AiResponseCopyWith<$Res> {
  factory $AiResponse_ResponseCopyWith(AiResponse_Response value, $Res Function(AiResponse_Response) _then) = _$AiResponse_ResponseCopyWithImpl;
@override @useResult
$Res call({
 String field0
});




}
/// @nodoc
class _$AiResponse_ResponseCopyWithImpl<$Res>
    implements $AiResponse_ResponseCopyWith<$Res> {
  _$AiResponse_ResponseCopyWithImpl(this._self, this._then);

  final AiResponse_Response _self;
  final $Res Function(AiResponse_Response) _then;

/// Create a copy of AiResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? field0 = null,}) {
  return _then(AiResponse_Response(
null == field0 ? _self.field0 : field0 // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
