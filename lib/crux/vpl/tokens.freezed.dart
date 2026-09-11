// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tokens.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Statement {

 Object get field0;



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Statement&&const DeepCollectionEquality().equals(other.field0, field0));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(field0));

@override
String toString() {
  return 'Statement(field0: $field0)';
}


}

/// @nodoc
class $StatementCopyWith<$Res>  {
$StatementCopyWith(Statement _, $Res Function(Statement) __);
}


/// Adds pattern-matching-related methods to [Statement].
extension StatementPatterns on Statement {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( Statement_If value)?  if_,TResult Function( Statement_For value)?  for_,TResult Function( Statement_Call value)?  call,TResult Function( Statement_Variable value)?  variable,required TResult orElse(),}){
final _that = this;
switch (_that) {
case Statement_If() when if_ != null:
return if_(_that);case Statement_For() when for_ != null:
return for_(_that);case Statement_Call() when call != null:
return call(_that);case Statement_Variable() when variable != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( Statement_If value)  if_,required TResult Function( Statement_For value)  for_,required TResult Function( Statement_Call value)  call,required TResult Function( Statement_Variable value)  variable,}){
final _that = this;
switch (_that) {
case Statement_If():
return if_(_that);case Statement_For():
return for_(_that);case Statement_Call():
return call(_that);case Statement_Variable():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( Statement_If value)?  if_,TResult? Function( Statement_For value)?  for_,TResult? Function( Statement_Call value)?  call,TResult? Function( Statement_Variable value)?  variable,}){
final _that = this;
switch (_that) {
case Statement_If() when if_ != null:
return if_(_that);case Statement_For() when for_ != null:
return for_(_that);case Statement_Call() when call != null:
return call(_that);case Statement_Variable() when variable != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( StatementIf field0)?  if_,TResult Function( StatementFor field0)?  for_,TResult Function( StatementCall field0)?  call,TResult Function( StatementVariable field0)?  variable,required TResult orElse(),}) {final _that = this;
switch (_that) {
case Statement_If() when if_ != null:
return if_(_that.field0);case Statement_For() when for_ != null:
return for_(_that.field0);case Statement_Call() when call != null:
return call(_that.field0);case Statement_Variable() when variable != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( StatementIf field0)  if_,required TResult Function( StatementFor field0)  for_,required TResult Function( StatementCall field0)  call,required TResult Function( StatementVariable field0)  variable,}) {final _that = this;
switch (_that) {
case Statement_If():
return if_(_that.field0);case Statement_For():
return for_(_that.field0);case Statement_Call():
return call(_that.field0);case Statement_Variable():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( StatementIf field0)?  if_,TResult? Function( StatementFor field0)?  for_,TResult? Function( StatementCall field0)?  call,TResult? Function( StatementVariable field0)?  variable,}) {final _that = this;
switch (_that) {
case Statement_If() when if_ != null:
return if_(_that.field0);case Statement_For() when for_ != null:
return for_(_that.field0);case Statement_Call() when call != null:
return call(_that.field0);case Statement_Variable() when variable != null:
return variable(_that.field0);case _:
  return null;

}
}

}

/// @nodoc


class Statement_If extends Statement {
  const Statement_If(this.field0): super._();
  

@override final  StatementIf field0;

/// Create a copy of Statement
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$Statement_IfCopyWith<Statement_If> get copyWith => _$Statement_IfCopyWithImpl<Statement_If>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Statement_If&&(identical(other.field0, field0) || other.field0 == field0));
}


@override
int get hashCode => Object.hash(runtimeType,field0);

@override
String toString() {
  return 'Statement.if_(field0: $field0)';
}


}

/// @nodoc
abstract mixin class $Statement_IfCopyWith<$Res> implements $StatementCopyWith<$Res> {
  factory $Statement_IfCopyWith(Statement_If value, $Res Function(Statement_If) _then) = _$Statement_IfCopyWithImpl;
@useResult
$Res call({
 StatementIf field0
});




}
/// @nodoc
class _$Statement_IfCopyWithImpl<$Res>
    implements $Statement_IfCopyWith<$Res> {
  _$Statement_IfCopyWithImpl(this._self, this._then);

  final Statement_If _self;
  final $Res Function(Statement_If) _then;

/// Create a copy of Statement
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? field0 = null,}) {
  return _then(Statement_If(
null == field0 ? _self.field0 : field0 // ignore: cast_nullable_to_non_nullable
as StatementIf,
  ));
}


}

/// @nodoc


class Statement_For extends Statement {
  const Statement_For(this.field0): super._();
  

@override final  StatementFor field0;

/// Create a copy of Statement
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$Statement_ForCopyWith<Statement_For> get copyWith => _$Statement_ForCopyWithImpl<Statement_For>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Statement_For&&(identical(other.field0, field0) || other.field0 == field0));
}


@override
int get hashCode => Object.hash(runtimeType,field0);

@override
String toString() {
  return 'Statement.for_(field0: $field0)';
}


}

/// @nodoc
abstract mixin class $Statement_ForCopyWith<$Res> implements $StatementCopyWith<$Res> {
  factory $Statement_ForCopyWith(Statement_For value, $Res Function(Statement_For) _then) = _$Statement_ForCopyWithImpl;
@useResult
$Res call({
 StatementFor field0
});




}
/// @nodoc
class _$Statement_ForCopyWithImpl<$Res>
    implements $Statement_ForCopyWith<$Res> {
  _$Statement_ForCopyWithImpl(this._self, this._then);

  final Statement_For _self;
  final $Res Function(Statement_For) _then;

/// Create a copy of Statement
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? field0 = null,}) {
  return _then(Statement_For(
null == field0 ? _self.field0 : field0 // ignore: cast_nullable_to_non_nullable
as StatementFor,
  ));
}


}

/// @nodoc


class Statement_Call extends Statement {
  const Statement_Call(this.field0): super._();
  

@override final  StatementCall field0;

/// Create a copy of Statement
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$Statement_CallCopyWith<Statement_Call> get copyWith => _$Statement_CallCopyWithImpl<Statement_Call>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Statement_Call&&(identical(other.field0, field0) || other.field0 == field0));
}


@override
int get hashCode => Object.hash(runtimeType,field0);

@override
String toString() {
  return 'Statement.call(field0: $field0)';
}


}

/// @nodoc
abstract mixin class $Statement_CallCopyWith<$Res> implements $StatementCopyWith<$Res> {
  factory $Statement_CallCopyWith(Statement_Call value, $Res Function(Statement_Call) _then) = _$Statement_CallCopyWithImpl;
@useResult
$Res call({
 StatementCall field0
});




}
/// @nodoc
class _$Statement_CallCopyWithImpl<$Res>
    implements $Statement_CallCopyWith<$Res> {
  _$Statement_CallCopyWithImpl(this._self, this._then);

  final Statement_Call _self;
  final $Res Function(Statement_Call) _then;

/// Create a copy of Statement
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? field0 = null,}) {
  return _then(Statement_Call(
null == field0 ? _self.field0 : field0 // ignore: cast_nullable_to_non_nullable
as StatementCall,
  ));
}


}

/// @nodoc


class Statement_Variable extends Statement {
  const Statement_Variable(this.field0): super._();
  

@override final  StatementVariable field0;

/// Create a copy of Statement
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$Statement_VariableCopyWith<Statement_Variable> get copyWith => _$Statement_VariableCopyWithImpl<Statement_Variable>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Statement_Variable&&(identical(other.field0, field0) || other.field0 == field0));
}


@override
int get hashCode => Object.hash(runtimeType,field0);

@override
String toString() {
  return 'Statement.variable(field0: $field0)';
}


}

/// @nodoc
abstract mixin class $Statement_VariableCopyWith<$Res> implements $StatementCopyWith<$Res> {
  factory $Statement_VariableCopyWith(Statement_Variable value, $Res Function(Statement_Variable) _then) = _$Statement_VariableCopyWithImpl;
@useResult
$Res call({
 StatementVariable field0
});




}
/// @nodoc
class _$Statement_VariableCopyWithImpl<$Res>
    implements $Statement_VariableCopyWith<$Res> {
  _$Statement_VariableCopyWithImpl(this._self, this._then);

  final Statement_Variable _self;
  final $Res Function(Statement_Variable) _then;

/// Create a copy of Statement
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? field0 = null,}) {
  return _then(Statement_Variable(
null == field0 ? _self.field0 : field0 // ignore: cast_nullable_to_non_nullable
as StatementVariable,
  ));
}


}

/// @nodoc
mixin _$Val {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Val);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'Val()';
}


}

/// @nodoc
class $ValCopyWith<$Res>  {
$ValCopyWith(Val _, $Res Function(Val) __);
}


/// Adds pattern-matching-related methods to [Val].
extension ValPatterns on Val {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( Val_Null value)?  null_,TResult Function( Val_Identifier value)?  identifier,TResult Function( Val_String value)?  string,TResult Function( Val_Number value)?  number,TResult Function( Val_Boolean value)?  boolean,TResult Function( Val_Object value)?  object,TResult Function( Val_Computed value)?  computed,required TResult orElse(),}){
final _that = this;
switch (_that) {
case Val_Null() when null_ != null:
return null_(_that);case Val_Identifier() when identifier != null:
return identifier(_that);case Val_String() when string != null:
return string(_that);case Val_Number() when number != null:
return number(_that);case Val_Boolean() when boolean != null:
return boolean(_that);case Val_Object() when object != null:
return object(_that);case Val_Computed() when computed != null:
return computed(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( Val_Null value)  null_,required TResult Function( Val_Identifier value)  identifier,required TResult Function( Val_String value)  string,required TResult Function( Val_Number value)  number,required TResult Function( Val_Boolean value)  boolean,required TResult Function( Val_Object value)  object,required TResult Function( Val_Computed value)  computed,}){
final _that = this;
switch (_that) {
case Val_Null():
return null_(_that);case Val_Identifier():
return identifier(_that);case Val_String():
return string(_that);case Val_Number():
return number(_that);case Val_Boolean():
return boolean(_that);case Val_Object():
return object(_that);case Val_Computed():
return computed(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( Val_Null value)?  null_,TResult? Function( Val_Identifier value)?  identifier,TResult? Function( Val_String value)?  string,TResult? Function( Val_Number value)?  number,TResult? Function( Val_Boolean value)?  boolean,TResult? Function( Val_Object value)?  object,TResult? Function( Val_Computed value)?  computed,}){
final _that = this;
switch (_that) {
case Val_Null() when null_ != null:
return null_(_that);case Val_Identifier() when identifier != null:
return identifier(_that);case Val_String() when string != null:
return string(_that);case Val_Number() when number != null:
return number(_that);case Val_Boolean() when boolean != null:
return boolean(_that);case Val_Object() when object != null:
return object(_that);case Val_Computed() when computed != null:
return computed(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  null_,TResult Function( Identifier field0)?  identifier,TResult Function( ValueString field0)?  string,TResult Function( ValueNumber field0)?  number,TResult Function( ValueBoolean field0)?  boolean,TResult Function( ValueObject field0)?  object,TResult Function( ValueComputed field0)?  computed,required TResult orElse(),}) {final _that = this;
switch (_that) {
case Val_Null() when null_ != null:
return null_();case Val_Identifier() when identifier != null:
return identifier(_that.field0);case Val_String() when string != null:
return string(_that.field0);case Val_Number() when number != null:
return number(_that.field0);case Val_Boolean() when boolean != null:
return boolean(_that.field0);case Val_Object() when object != null:
return object(_that.field0);case Val_Computed() when computed != null:
return computed(_that.field0);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  null_,required TResult Function( Identifier field0)  identifier,required TResult Function( ValueString field0)  string,required TResult Function( ValueNumber field0)  number,required TResult Function( ValueBoolean field0)  boolean,required TResult Function( ValueObject field0)  object,required TResult Function( ValueComputed field0)  computed,}) {final _that = this;
switch (_that) {
case Val_Null():
return null_();case Val_Identifier():
return identifier(_that.field0);case Val_String():
return string(_that.field0);case Val_Number():
return number(_that.field0);case Val_Boolean():
return boolean(_that.field0);case Val_Object():
return object(_that.field0);case Val_Computed():
return computed(_that.field0);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  null_,TResult? Function( Identifier field0)?  identifier,TResult? Function( ValueString field0)?  string,TResult? Function( ValueNumber field0)?  number,TResult? Function( ValueBoolean field0)?  boolean,TResult? Function( ValueObject field0)?  object,TResult? Function( ValueComputed field0)?  computed,}) {final _that = this;
switch (_that) {
case Val_Null() when null_ != null:
return null_();case Val_Identifier() when identifier != null:
return identifier(_that.field0);case Val_String() when string != null:
return string(_that.field0);case Val_Number() when number != null:
return number(_that.field0);case Val_Boolean() when boolean != null:
return boolean(_that.field0);case Val_Object() when object != null:
return object(_that.field0);case Val_Computed() when computed != null:
return computed(_that.field0);case _:
  return null;

}
}

}

/// @nodoc


class Val_Null extends Val {
  const Val_Null(): super._();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Val_Null);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'Val.null_()';
}


}




/// @nodoc


class Val_Identifier extends Val {
  const Val_Identifier(this.field0): super._();
  

 final  Identifier field0;

/// Create a copy of Val
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$Val_IdentifierCopyWith<Val_Identifier> get copyWith => _$Val_IdentifierCopyWithImpl<Val_Identifier>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Val_Identifier&&(identical(other.field0, field0) || other.field0 == field0));
}


@override
int get hashCode => Object.hash(runtimeType,field0);

@override
String toString() {
  return 'Val.identifier(field0: $field0)';
}


}

/// @nodoc
abstract mixin class $Val_IdentifierCopyWith<$Res> implements $ValCopyWith<$Res> {
  factory $Val_IdentifierCopyWith(Val_Identifier value, $Res Function(Val_Identifier) _then) = _$Val_IdentifierCopyWithImpl;
@useResult
$Res call({
 Identifier field0
});




}
/// @nodoc
class _$Val_IdentifierCopyWithImpl<$Res>
    implements $Val_IdentifierCopyWith<$Res> {
  _$Val_IdentifierCopyWithImpl(this._self, this._then);

  final Val_Identifier _self;
  final $Res Function(Val_Identifier) _then;

/// Create a copy of Val
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? field0 = null,}) {
  return _then(Val_Identifier(
null == field0 ? _self.field0 : field0 // ignore: cast_nullable_to_non_nullable
as Identifier,
  ));
}


}

/// @nodoc


class Val_String extends Val {
  const Val_String(this.field0): super._();
  

 final  ValueString field0;

/// Create a copy of Val
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$Val_StringCopyWith<Val_String> get copyWith => _$Val_StringCopyWithImpl<Val_String>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Val_String&&(identical(other.field0, field0) || other.field0 == field0));
}


@override
int get hashCode => Object.hash(runtimeType,field0);

@override
String toString() {
  return 'Val.string(field0: $field0)';
}


}

/// @nodoc
abstract mixin class $Val_StringCopyWith<$Res> implements $ValCopyWith<$Res> {
  factory $Val_StringCopyWith(Val_String value, $Res Function(Val_String) _then) = _$Val_StringCopyWithImpl;
@useResult
$Res call({
 ValueString field0
});




}
/// @nodoc
class _$Val_StringCopyWithImpl<$Res>
    implements $Val_StringCopyWith<$Res> {
  _$Val_StringCopyWithImpl(this._self, this._then);

  final Val_String _self;
  final $Res Function(Val_String) _then;

/// Create a copy of Val
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? field0 = null,}) {
  return _then(Val_String(
null == field0 ? _self.field0 : field0 // ignore: cast_nullable_to_non_nullable
as ValueString,
  ));
}


}

/// @nodoc


class Val_Number extends Val {
  const Val_Number(this.field0): super._();
  

 final  ValueNumber field0;

/// Create a copy of Val
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$Val_NumberCopyWith<Val_Number> get copyWith => _$Val_NumberCopyWithImpl<Val_Number>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Val_Number&&(identical(other.field0, field0) || other.field0 == field0));
}


@override
int get hashCode => Object.hash(runtimeType,field0);

@override
String toString() {
  return 'Val.number(field0: $field0)';
}


}

/// @nodoc
abstract mixin class $Val_NumberCopyWith<$Res> implements $ValCopyWith<$Res> {
  factory $Val_NumberCopyWith(Val_Number value, $Res Function(Val_Number) _then) = _$Val_NumberCopyWithImpl;
@useResult
$Res call({
 ValueNumber field0
});




}
/// @nodoc
class _$Val_NumberCopyWithImpl<$Res>
    implements $Val_NumberCopyWith<$Res> {
  _$Val_NumberCopyWithImpl(this._self, this._then);

  final Val_Number _self;
  final $Res Function(Val_Number) _then;

/// Create a copy of Val
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? field0 = null,}) {
  return _then(Val_Number(
null == field0 ? _self.field0 : field0 // ignore: cast_nullable_to_non_nullable
as ValueNumber,
  ));
}


}

/// @nodoc


class Val_Boolean extends Val {
  const Val_Boolean(this.field0): super._();
  

 final  ValueBoolean field0;

/// Create a copy of Val
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$Val_BooleanCopyWith<Val_Boolean> get copyWith => _$Val_BooleanCopyWithImpl<Val_Boolean>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Val_Boolean&&(identical(other.field0, field0) || other.field0 == field0));
}


@override
int get hashCode => Object.hash(runtimeType,field0);

@override
String toString() {
  return 'Val.boolean(field0: $field0)';
}


}

/// @nodoc
abstract mixin class $Val_BooleanCopyWith<$Res> implements $ValCopyWith<$Res> {
  factory $Val_BooleanCopyWith(Val_Boolean value, $Res Function(Val_Boolean) _then) = _$Val_BooleanCopyWithImpl;
@useResult
$Res call({
 ValueBoolean field0
});




}
/// @nodoc
class _$Val_BooleanCopyWithImpl<$Res>
    implements $Val_BooleanCopyWith<$Res> {
  _$Val_BooleanCopyWithImpl(this._self, this._then);

  final Val_Boolean _self;
  final $Res Function(Val_Boolean) _then;

/// Create a copy of Val
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? field0 = null,}) {
  return _then(Val_Boolean(
null == field0 ? _self.field0 : field0 // ignore: cast_nullable_to_non_nullable
as ValueBoolean,
  ));
}


}

/// @nodoc


class Val_Object extends Val {
  const Val_Object(this.field0): super._();
  

 final  ValueObject field0;

/// Create a copy of Val
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$Val_ObjectCopyWith<Val_Object> get copyWith => _$Val_ObjectCopyWithImpl<Val_Object>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Val_Object&&(identical(other.field0, field0) || other.field0 == field0));
}


@override
int get hashCode => Object.hash(runtimeType,field0);

@override
String toString() {
  return 'Val.object(field0: $field0)';
}


}

/// @nodoc
abstract mixin class $Val_ObjectCopyWith<$Res> implements $ValCopyWith<$Res> {
  factory $Val_ObjectCopyWith(Val_Object value, $Res Function(Val_Object) _then) = _$Val_ObjectCopyWithImpl;
@useResult
$Res call({
 ValueObject field0
});




}
/// @nodoc
class _$Val_ObjectCopyWithImpl<$Res>
    implements $Val_ObjectCopyWith<$Res> {
  _$Val_ObjectCopyWithImpl(this._self, this._then);

  final Val_Object _self;
  final $Res Function(Val_Object) _then;

/// Create a copy of Val
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? field0 = null,}) {
  return _then(Val_Object(
null == field0 ? _self.field0 : field0 // ignore: cast_nullable_to_non_nullable
as ValueObject,
  ));
}


}

/// @nodoc


class Val_Computed extends Val {
  const Val_Computed(this.field0): super._();
  

 final  ValueComputed field0;

/// Create a copy of Val
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$Val_ComputedCopyWith<Val_Computed> get copyWith => _$Val_ComputedCopyWithImpl<Val_Computed>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Val_Computed&&(identical(other.field0, field0) || other.field0 == field0));
}


@override
int get hashCode => Object.hash(runtimeType,field0);

@override
String toString() {
  return 'Val.computed(field0: $field0)';
}


}

/// @nodoc
abstract mixin class $Val_ComputedCopyWith<$Res> implements $ValCopyWith<$Res> {
  factory $Val_ComputedCopyWith(Val_Computed value, $Res Function(Val_Computed) _then) = _$Val_ComputedCopyWithImpl;
@useResult
$Res call({
 ValueComputed field0
});




}
/// @nodoc
class _$Val_ComputedCopyWithImpl<$Res>
    implements $Val_ComputedCopyWith<$Res> {
  _$Val_ComputedCopyWithImpl(this._self, this._then);

  final Val_Computed _self;
  final $Res Function(Val_Computed) _then;

/// Create a copy of Val
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? field0 = null,}) {
  return _then(Val_Computed(
null == field0 ? _self.field0 : field0 // ignore: cast_nullable_to_non_nullable
as ValueComputed,
  ));
}


}

// dart format on
