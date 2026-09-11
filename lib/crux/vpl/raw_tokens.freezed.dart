// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'raw_tokens.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$RawStatement {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RawStatement);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'RawStatement()';
}


}

/// @nodoc
class $RawStatementCopyWith<$Res>  {
$RawStatementCopyWith(RawStatement _, $Res Function(RawStatement) __);
}


/// Adds pattern-matching-related methods to [RawStatement].
extension RawStatementPatterns on RawStatement {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( RawStatement_End value)?  end,TResult Function( RawStatement_If value)?  if_,TResult Function( RawStatement_For value)?  for_,TResult Function( RawStatement_Call value)?  call,TResult Function( RawStatement_Variable value)?  variable,required TResult orElse(),}){
final _that = this;
switch (_that) {
case RawStatement_End() when end != null:
return end(_that);case RawStatement_If() when if_ != null:
return if_(_that);case RawStatement_For() when for_ != null:
return for_(_that);case RawStatement_Call() when call != null:
return call(_that);case RawStatement_Variable() when variable != null:
return variable(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( RawStatement_End value)  end,required TResult Function( RawStatement_If value)  if_,required TResult Function( RawStatement_For value)  for_,required TResult Function( RawStatement_Call value)  call,required TResult Function( RawStatement_Variable value)  variable,}){
final _that = this;
switch (_that) {
case RawStatement_End():
return end(_that);case RawStatement_If():
return if_(_that);case RawStatement_For():
return for_(_that);case RawStatement_Call():
return call(_that);case RawStatement_Variable():
return variable(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( RawStatement_End value)?  end,TResult? Function( RawStatement_If value)?  if_,TResult? Function( RawStatement_For value)?  for_,TResult? Function( RawStatement_Call value)?  call,TResult? Function( RawStatement_Variable value)?  variable,}){
final _that = this;
switch (_that) {
case RawStatement_End() when end != null:
return end(_that);case RawStatement_If() when if_ != null:
return if_(_that);case RawStatement_For() when for_ != null:
return for_(_that);case RawStatement_Call() when call != null:
return call(_that);case RawStatement_Variable() when variable != null:
return variable(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  end,TResult Function( RawIf field0)?  if_,TResult Function( RawFor field0)?  for_,TResult Function( StatementCall field0)?  call,TResult Function( StatementVariable field0)?  variable,required TResult orElse(),}) {final _that = this;
switch (_that) {
case RawStatement_End() when end != null:
return end();case RawStatement_If() when if_ != null:
return if_(_that.field0);case RawStatement_For() when for_ != null:
return for_(_that.field0);case RawStatement_Call() when call != null:
return call(_that.field0);case RawStatement_Variable() when variable != null:
return variable(_that.field0);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  end,required TResult Function( RawIf field0)  if_,required TResult Function( RawFor field0)  for_,required TResult Function( StatementCall field0)  call,required TResult Function( StatementVariable field0)  variable,}) {final _that = this;
switch (_that) {
case RawStatement_End():
return end();case RawStatement_If():
return if_(_that.field0);case RawStatement_For():
return for_(_that.field0);case RawStatement_Call():
return call(_that.field0);case RawStatement_Variable():
return variable(_that.field0);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  end,TResult? Function( RawIf field0)?  if_,TResult? Function( RawFor field0)?  for_,TResult? Function( StatementCall field0)?  call,TResult? Function( StatementVariable field0)?  variable,}) {final _that = this;
switch (_that) {
case RawStatement_End() when end != null:
return end();case RawStatement_If() when if_ != null:
return if_(_that.field0);case RawStatement_For() when for_ != null:
return for_(_that.field0);case RawStatement_Call() when call != null:
return call(_that.field0);case RawStatement_Variable() when variable != null:
return variable(_that.field0);case _:
  return null;

}
}

}

/// @nodoc


class RawStatement_End extends RawStatement {
  const RawStatement_End(): super._();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RawStatement_End);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'RawStatement.end()';
}


}




/// @nodoc


class RawStatement_If extends RawStatement {
  const RawStatement_If(this.field0): super._();
  

 final  RawIf field0;

/// Create a copy of RawStatement
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RawStatement_IfCopyWith<RawStatement_If> get copyWith => _$RawStatement_IfCopyWithImpl<RawStatement_If>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RawStatement_If&&(identical(other.field0, field0) || other.field0 == field0));
}


@override
int get hashCode => Object.hash(runtimeType,field0);

@override
String toString() {
  return 'RawStatement.if_(field0: $field0)';
}


}

/// @nodoc
abstract mixin class $RawStatement_IfCopyWith<$Res> implements $RawStatementCopyWith<$Res> {
  factory $RawStatement_IfCopyWith(RawStatement_If value, $Res Function(RawStatement_If) _then) = _$RawStatement_IfCopyWithImpl;
@useResult
$Res call({
 RawIf field0
});




}
/// @nodoc
class _$RawStatement_IfCopyWithImpl<$Res>
    implements $RawStatement_IfCopyWith<$Res> {
  _$RawStatement_IfCopyWithImpl(this._self, this._then);

  final RawStatement_If _self;
  final $Res Function(RawStatement_If) _then;

/// Create a copy of RawStatement
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? field0 = null,}) {
  return _then(RawStatement_If(
null == field0 ? _self.field0 : field0 // ignore: cast_nullable_to_non_nullable
as RawIf,
  ));
}


}

/// @nodoc


class RawStatement_For extends RawStatement {
  const RawStatement_For(this.field0): super._();
  

 final  RawFor field0;

/// Create a copy of RawStatement
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RawStatement_ForCopyWith<RawStatement_For> get copyWith => _$RawStatement_ForCopyWithImpl<RawStatement_For>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RawStatement_For&&(identical(other.field0, field0) || other.field0 == field0));
}


@override
int get hashCode => Object.hash(runtimeType,field0);

@override
String toString() {
  return 'RawStatement.for_(field0: $field0)';
}


}

/// @nodoc
abstract mixin class $RawStatement_ForCopyWith<$Res> implements $RawStatementCopyWith<$Res> {
  factory $RawStatement_ForCopyWith(RawStatement_For value, $Res Function(RawStatement_For) _then) = _$RawStatement_ForCopyWithImpl;
@useResult
$Res call({
 RawFor field0
});




}
/// @nodoc
class _$RawStatement_ForCopyWithImpl<$Res>
    implements $RawStatement_ForCopyWith<$Res> {
  _$RawStatement_ForCopyWithImpl(this._self, this._then);

  final RawStatement_For _self;
  final $Res Function(RawStatement_For) _then;

/// Create a copy of RawStatement
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? field0 = null,}) {
  return _then(RawStatement_For(
null == field0 ? _self.field0 : field0 // ignore: cast_nullable_to_non_nullable
as RawFor,
  ));
}


}

/// @nodoc


class RawStatement_Call extends RawStatement {
  const RawStatement_Call(this.field0): super._();
  

 final  StatementCall field0;

/// Create a copy of RawStatement
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RawStatement_CallCopyWith<RawStatement_Call> get copyWith => _$RawStatement_CallCopyWithImpl<RawStatement_Call>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RawStatement_Call&&(identical(other.field0, field0) || other.field0 == field0));
}


@override
int get hashCode => Object.hash(runtimeType,field0);

@override
String toString() {
  return 'RawStatement.call(field0: $field0)';
}


}

/// @nodoc
abstract mixin class $RawStatement_CallCopyWith<$Res> implements $RawStatementCopyWith<$Res> {
  factory $RawStatement_CallCopyWith(RawStatement_Call value, $Res Function(RawStatement_Call) _then) = _$RawStatement_CallCopyWithImpl;
@useResult
$Res call({
 StatementCall field0
});




}
/// @nodoc
class _$RawStatement_CallCopyWithImpl<$Res>
    implements $RawStatement_CallCopyWith<$Res> {
  _$RawStatement_CallCopyWithImpl(this._self, this._then);

  final RawStatement_Call _self;
  final $Res Function(RawStatement_Call) _then;

/// Create a copy of RawStatement
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? field0 = null,}) {
  return _then(RawStatement_Call(
null == field0 ? _self.field0 : field0 // ignore: cast_nullable_to_non_nullable
as StatementCall,
  ));
}


}

/// @nodoc


class RawStatement_Variable extends RawStatement {
  const RawStatement_Variable(this.field0): super._();
  

 final  StatementVariable field0;

/// Create a copy of RawStatement
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RawStatement_VariableCopyWith<RawStatement_Variable> get copyWith => _$RawStatement_VariableCopyWithImpl<RawStatement_Variable>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RawStatement_Variable&&(identical(other.field0, field0) || other.field0 == field0));
}


@override
int get hashCode => Object.hash(runtimeType,field0);

@override
String toString() {
  return 'RawStatement.variable(field0: $field0)';
}


}

/// @nodoc
abstract mixin class $RawStatement_VariableCopyWith<$Res> implements $RawStatementCopyWith<$Res> {
  factory $RawStatement_VariableCopyWith(RawStatement_Variable value, $Res Function(RawStatement_Variable) _then) = _$RawStatement_VariableCopyWithImpl;
@useResult
$Res call({
 StatementVariable field0
});




}
/// @nodoc
class _$RawStatement_VariableCopyWithImpl<$Res>
    implements $RawStatement_VariableCopyWith<$Res> {
  _$RawStatement_VariableCopyWithImpl(this._self, this._then);

  final RawStatement_Variable _self;
  final $Res Function(RawStatement_Variable) _then;

/// Create a copy of RawStatement
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? field0 = null,}) {
  return _then(RawStatement_Variable(
null == field0 ? _self.field0 : field0 // ignore: cast_nullable_to_non_nullable
as StatementVariable,
  ));
}


}

/// @nodoc
mixin _$RawStatementVariant {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RawStatementVariant);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'RawStatementVariant()';
}


}

/// @nodoc
class $RawStatementVariantCopyWith<$Res>  {
$RawStatementVariantCopyWith(RawStatementVariant _, $Res Function(RawStatementVariant) __);
}


/// Adds pattern-matching-related methods to [RawStatementVariant].
extension RawStatementVariantPatterns on RawStatementVariant {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( RawStatementVariant_End value)?  end,TResult Function( RawStatementVariant_If value)?  if_,TResult Function( RawStatementVariant_For value)?  for_,TResult Function( RawStatementVariant_Variable value)?  variable,TResult Function( RawStatementVariant_Call value)?  call,required TResult orElse(),}){
final _that = this;
switch (_that) {
case RawStatementVariant_End() when end != null:
return end(_that);case RawStatementVariant_If() when if_ != null:
return if_(_that);case RawStatementVariant_For() when for_ != null:
return for_(_that);case RawStatementVariant_Variable() when variable != null:
return variable(_that);case RawStatementVariant_Call() when call != null:
return call(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( RawStatementVariant_End value)  end,required TResult Function( RawStatementVariant_If value)  if_,required TResult Function( RawStatementVariant_For value)  for_,required TResult Function( RawStatementVariant_Variable value)  variable,required TResult Function( RawStatementVariant_Call value)  call,}){
final _that = this;
switch (_that) {
case RawStatementVariant_End():
return end(_that);case RawStatementVariant_If():
return if_(_that);case RawStatementVariant_For():
return for_(_that);case RawStatementVariant_Variable():
return variable(_that);case RawStatementVariant_Call():
return call(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( RawStatementVariant_End value)?  end,TResult? Function( RawStatementVariant_If value)?  if_,TResult? Function( RawStatementVariant_For value)?  for_,TResult? Function( RawStatementVariant_Variable value)?  variable,TResult? Function( RawStatementVariant_Call value)?  call,}){
final _that = this;
switch (_that) {
case RawStatementVariant_End() when end != null:
return end(_that);case RawStatementVariant_If() when if_ != null:
return if_(_that);case RawStatementVariant_For() when for_ != null:
return for_(_that);case RawStatementVariant_Variable() when variable != null:
return variable(_that);case RawStatementVariant_Call() when call != null:
return call(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  end,TResult Function()?  if_,TResult Function()?  for_,TResult Function()?  variable,TResult Function( FnName field0)?  call,required TResult orElse(),}) {final _that = this;
switch (_that) {
case RawStatementVariant_End() when end != null:
return end();case RawStatementVariant_If() when if_ != null:
return if_();case RawStatementVariant_For() when for_ != null:
return for_();case RawStatementVariant_Variable() when variable != null:
return variable();case RawStatementVariant_Call() when call != null:
return call(_that.field0);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  end,required TResult Function()  if_,required TResult Function()  for_,required TResult Function()  variable,required TResult Function( FnName field0)  call,}) {final _that = this;
switch (_that) {
case RawStatementVariant_End():
return end();case RawStatementVariant_If():
return if_();case RawStatementVariant_For():
return for_();case RawStatementVariant_Variable():
return variable();case RawStatementVariant_Call():
return call(_that.field0);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  end,TResult? Function()?  if_,TResult? Function()?  for_,TResult? Function()?  variable,TResult? Function( FnName field0)?  call,}) {final _that = this;
switch (_that) {
case RawStatementVariant_End() when end != null:
return end();case RawStatementVariant_If() when if_ != null:
return if_();case RawStatementVariant_For() when for_ != null:
return for_();case RawStatementVariant_Variable() when variable != null:
return variable();case RawStatementVariant_Call() when call != null:
return call(_that.field0);case _:
  return null;

}
}

}

/// @nodoc


class RawStatementVariant_End extends RawStatementVariant {
  const RawStatementVariant_End(): super._();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RawStatementVariant_End);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'RawStatementVariant.end()';
}


}




/// @nodoc


class RawStatementVariant_If extends RawStatementVariant {
  const RawStatementVariant_If(): super._();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RawStatementVariant_If);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'RawStatementVariant.if_()';
}


}




/// @nodoc


class RawStatementVariant_For extends RawStatementVariant {
  const RawStatementVariant_For(): super._();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RawStatementVariant_For);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'RawStatementVariant.for_()';
}


}




/// @nodoc


class RawStatementVariant_Variable extends RawStatementVariant {
  const RawStatementVariant_Variable(): super._();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RawStatementVariant_Variable);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'RawStatementVariant.variable()';
}


}




/// @nodoc


class RawStatementVariant_Call extends RawStatementVariant {
  const RawStatementVariant_Call(this.field0): super._();
  

 final  FnName field0;

/// Create a copy of RawStatementVariant
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RawStatementVariant_CallCopyWith<RawStatementVariant_Call> get copyWith => _$RawStatementVariant_CallCopyWithImpl<RawStatementVariant_Call>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RawStatementVariant_Call&&(identical(other.field0, field0) || other.field0 == field0));
}


@override
int get hashCode => Object.hash(runtimeType,field0);

@override
String toString() {
  return 'RawStatementVariant.call(field0: $field0)';
}


}

/// @nodoc
abstract mixin class $RawStatementVariant_CallCopyWith<$Res> implements $RawStatementVariantCopyWith<$Res> {
  factory $RawStatementVariant_CallCopyWith(RawStatementVariant_Call value, $Res Function(RawStatementVariant_Call) _then) = _$RawStatementVariant_CallCopyWithImpl;
@useResult
$Res call({
 FnName field0
});




}
/// @nodoc
class _$RawStatementVariant_CallCopyWithImpl<$Res>
    implements $RawStatementVariant_CallCopyWith<$Res> {
  _$RawStatementVariant_CallCopyWithImpl(this._self, this._then);

  final RawStatementVariant_Call _self;
  final $Res Function(RawStatementVariant_Call) _then;

/// Create a copy of RawStatementVariant
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? field0 = null,}) {
  return _then(RawStatementVariant_Call(
null == field0 ? _self.field0 : field0 // ignore: cast_nullable_to_non_nullable
as FnName,
  ));
}


}

// dart format on
