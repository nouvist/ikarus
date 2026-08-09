// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$DtoStatement {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DtoStatement);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'DtoStatement()';
}


}

/// @nodoc
class $DtoStatementCopyWith<$Res>  {
$DtoStatementCopyWith(DtoStatement _, $Res Function(DtoStatement) __);
}


/// Adds pattern-matching-related methods to [DtoStatement].
extension DtoStatementPatterns on DtoStatement {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( DtoStatement_Assignment value)?  assignment,TResult Function( DtoStatement_If value)?  if_,TResult Function( DtoStatement_For value)?  for_,TResult Function( DtoStatement_End value)?  end,required TResult orElse(),}){
final _that = this;
switch (_that) {
case DtoStatement_Assignment() when assignment != null:
return assignment(_that);case DtoStatement_If() when if_ != null:
return if_(_that);case DtoStatement_For() when for_ != null:
return for_(_that);case DtoStatement_End() when end != null:
return end(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( DtoStatement_Assignment value)  assignment,required TResult Function( DtoStatement_If value)  if_,required TResult Function( DtoStatement_For value)  for_,required TResult Function( DtoStatement_End value)  end,}){
final _that = this;
switch (_that) {
case DtoStatement_Assignment():
return assignment(_that);case DtoStatement_If():
return if_(_that);case DtoStatement_For():
return for_(_that);case DtoStatement_End():
return end(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( DtoStatement_Assignment value)?  assignment,TResult? Function( DtoStatement_If value)?  if_,TResult? Function( DtoStatement_For value)?  for_,TResult? Function( DtoStatement_End value)?  end,}){
final _that = this;
switch (_that) {
case DtoStatement_Assignment() when assignment != null:
return assignment(_that);case DtoStatement_If() when if_ != null:
return if_(_that);case DtoStatement_For() when for_ != null:
return for_(_that);case DtoStatement_End() when end != null:
return end(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String identifier,  DtoValue value)?  assignment,TResult Function( DtoVariable left,  DtoVariable right,  DtoCondition condition)?  if_,TResult Function( DtoVariable left,  DtoVariable right,  DtoCondition condition)?  for_,TResult Function()?  end,required TResult orElse(),}) {final _that = this;
switch (_that) {
case DtoStatement_Assignment() when assignment != null:
return assignment(_that.identifier,_that.value);case DtoStatement_If() when if_ != null:
return if_(_that.left,_that.right,_that.condition);case DtoStatement_For() when for_ != null:
return for_(_that.left,_that.right,_that.condition);case DtoStatement_End() when end != null:
return end();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String identifier,  DtoValue value)  assignment,required TResult Function( DtoVariable left,  DtoVariable right,  DtoCondition condition)  if_,required TResult Function( DtoVariable left,  DtoVariable right,  DtoCondition condition)  for_,required TResult Function()  end,}) {final _that = this;
switch (_that) {
case DtoStatement_Assignment():
return assignment(_that.identifier,_that.value);case DtoStatement_If():
return if_(_that.left,_that.right,_that.condition);case DtoStatement_For():
return for_(_that.left,_that.right,_that.condition);case DtoStatement_End():
return end();}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String identifier,  DtoValue value)?  assignment,TResult? Function( DtoVariable left,  DtoVariable right,  DtoCondition condition)?  if_,TResult? Function( DtoVariable left,  DtoVariable right,  DtoCondition condition)?  for_,TResult? Function()?  end,}) {final _that = this;
switch (_that) {
case DtoStatement_Assignment() when assignment != null:
return assignment(_that.identifier,_that.value);case DtoStatement_If() when if_ != null:
return if_(_that.left,_that.right,_that.condition);case DtoStatement_For() when for_ != null:
return for_(_that.left,_that.right,_that.condition);case DtoStatement_End() when end != null:
return end();case _:
  return null;

}
}

}

/// @nodoc


class DtoStatement_Assignment extends DtoStatement {
  const DtoStatement_Assignment({required this.identifier, required this.value}): super._();
  

 final  String identifier;
 final  DtoValue value;

/// Create a copy of DtoStatement
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DtoStatement_AssignmentCopyWith<DtoStatement_Assignment> get copyWith => _$DtoStatement_AssignmentCopyWithImpl<DtoStatement_Assignment>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DtoStatement_Assignment&&(identical(other.identifier, identifier) || other.identifier == identifier)&&(identical(other.value, value) || other.value == value));
}


@override
int get hashCode => Object.hash(runtimeType,identifier,value);

@override
String toString() {
  return 'DtoStatement.assignment(identifier: $identifier, value: $value)';
}


}

/// @nodoc
abstract mixin class $DtoStatement_AssignmentCopyWith<$Res> implements $DtoStatementCopyWith<$Res> {
  factory $DtoStatement_AssignmentCopyWith(DtoStatement_Assignment value, $Res Function(DtoStatement_Assignment) _then) = _$DtoStatement_AssignmentCopyWithImpl;
@useResult
$Res call({
 String identifier, DtoValue value
});


$DtoValueCopyWith<$Res> get value;

}
/// @nodoc
class _$DtoStatement_AssignmentCopyWithImpl<$Res>
    implements $DtoStatement_AssignmentCopyWith<$Res> {
  _$DtoStatement_AssignmentCopyWithImpl(this._self, this._then);

  final DtoStatement_Assignment _self;
  final $Res Function(DtoStatement_Assignment) _then;

/// Create a copy of DtoStatement
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? identifier = null,Object? value = null,}) {
  return _then(DtoStatement_Assignment(
identifier: null == identifier ? _self.identifier : identifier // ignore: cast_nullable_to_non_nullable
as String,value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as DtoValue,
  ));
}

/// Create a copy of DtoStatement
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DtoValueCopyWith<$Res> get value {
  
  return $DtoValueCopyWith<$Res>(_self.value, (value) {
    return _then(_self.copyWith(value: value));
  });
}
}

/// @nodoc


class DtoStatement_If extends DtoStatement {
  const DtoStatement_If({required this.left, required this.right, required this.condition}): super._();
  

 final  DtoVariable left;
 final  DtoVariable right;
 final  DtoCondition condition;

/// Create a copy of DtoStatement
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DtoStatement_IfCopyWith<DtoStatement_If> get copyWith => _$DtoStatement_IfCopyWithImpl<DtoStatement_If>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DtoStatement_If&&(identical(other.left, left) || other.left == left)&&(identical(other.right, right) || other.right == right)&&(identical(other.condition, condition) || other.condition == condition));
}


@override
int get hashCode => Object.hash(runtimeType,left,right,condition);

@override
String toString() {
  return 'DtoStatement.if_(left: $left, right: $right, condition: $condition)';
}


}

/// @nodoc
abstract mixin class $DtoStatement_IfCopyWith<$Res> implements $DtoStatementCopyWith<$Res> {
  factory $DtoStatement_IfCopyWith(DtoStatement_If value, $Res Function(DtoStatement_If) _then) = _$DtoStatement_IfCopyWithImpl;
@useResult
$Res call({
 DtoVariable left, DtoVariable right, DtoCondition condition
});


$DtoVariableCopyWith<$Res> get left;$DtoVariableCopyWith<$Res> get right;

}
/// @nodoc
class _$DtoStatement_IfCopyWithImpl<$Res>
    implements $DtoStatement_IfCopyWith<$Res> {
  _$DtoStatement_IfCopyWithImpl(this._self, this._then);

  final DtoStatement_If _self;
  final $Res Function(DtoStatement_If) _then;

/// Create a copy of DtoStatement
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? left = null,Object? right = null,Object? condition = null,}) {
  return _then(DtoStatement_If(
left: null == left ? _self.left : left // ignore: cast_nullable_to_non_nullable
as DtoVariable,right: null == right ? _self.right : right // ignore: cast_nullable_to_non_nullable
as DtoVariable,condition: null == condition ? _self.condition : condition // ignore: cast_nullable_to_non_nullable
as DtoCondition,
  ));
}

/// Create a copy of DtoStatement
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DtoVariableCopyWith<$Res> get left {
  
  return $DtoVariableCopyWith<$Res>(_self.left, (value) {
    return _then(_self.copyWith(left: value));
  });
}/// Create a copy of DtoStatement
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DtoVariableCopyWith<$Res> get right {
  
  return $DtoVariableCopyWith<$Res>(_self.right, (value) {
    return _then(_self.copyWith(right: value));
  });
}
}

/// @nodoc


class DtoStatement_For extends DtoStatement {
  const DtoStatement_For({required this.left, required this.right, required this.condition}): super._();
  

 final  DtoVariable left;
 final  DtoVariable right;
 final  DtoCondition condition;

/// Create a copy of DtoStatement
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DtoStatement_ForCopyWith<DtoStatement_For> get copyWith => _$DtoStatement_ForCopyWithImpl<DtoStatement_For>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DtoStatement_For&&(identical(other.left, left) || other.left == left)&&(identical(other.right, right) || other.right == right)&&(identical(other.condition, condition) || other.condition == condition));
}


@override
int get hashCode => Object.hash(runtimeType,left,right,condition);

@override
String toString() {
  return 'DtoStatement.for_(left: $left, right: $right, condition: $condition)';
}


}

/// @nodoc
abstract mixin class $DtoStatement_ForCopyWith<$Res> implements $DtoStatementCopyWith<$Res> {
  factory $DtoStatement_ForCopyWith(DtoStatement_For value, $Res Function(DtoStatement_For) _then) = _$DtoStatement_ForCopyWithImpl;
@useResult
$Res call({
 DtoVariable left, DtoVariable right, DtoCondition condition
});


$DtoVariableCopyWith<$Res> get left;$DtoVariableCopyWith<$Res> get right;

}
/// @nodoc
class _$DtoStatement_ForCopyWithImpl<$Res>
    implements $DtoStatement_ForCopyWith<$Res> {
  _$DtoStatement_ForCopyWithImpl(this._self, this._then);

  final DtoStatement_For _self;
  final $Res Function(DtoStatement_For) _then;

/// Create a copy of DtoStatement
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? left = null,Object? right = null,Object? condition = null,}) {
  return _then(DtoStatement_For(
left: null == left ? _self.left : left // ignore: cast_nullable_to_non_nullable
as DtoVariable,right: null == right ? _self.right : right // ignore: cast_nullable_to_non_nullable
as DtoVariable,condition: null == condition ? _self.condition : condition // ignore: cast_nullable_to_non_nullable
as DtoCondition,
  ));
}

/// Create a copy of DtoStatement
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DtoVariableCopyWith<$Res> get left {
  
  return $DtoVariableCopyWith<$Res>(_self.left, (value) {
    return _then(_self.copyWith(left: value));
  });
}/// Create a copy of DtoStatement
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DtoVariableCopyWith<$Res> get right {
  
  return $DtoVariableCopyWith<$Res>(_self.right, (value) {
    return _then(_self.copyWith(right: value));
  });
}
}

/// @nodoc


class DtoStatement_End extends DtoStatement {
  const DtoStatement_End(): super._();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DtoStatement_End);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'DtoStatement.end()';
}


}




/// @nodoc
mixin _$DtoValue {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DtoValue);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'DtoValue()';
}


}

/// @nodoc
class $DtoValueCopyWith<$Res>  {
$DtoValueCopyWith(DtoValue _, $Res Function(DtoValue) __);
}


/// Adds pattern-matching-related methods to [DtoValue].
extension DtoValuePatterns on DtoValue {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( DtoValue_Undefined value)?  undefined,TResult Function( DtoValue_Number value)?  number,TResult Function( DtoValue_String value)?  string,TResult Function( DtoValue_Boolean value)?  boolean,TResult Function( DtoValue_Element value)?  element,required TResult orElse(),}){
final _that = this;
switch (_that) {
case DtoValue_Undefined() when undefined != null:
return undefined(_that);case DtoValue_Number() when number != null:
return number(_that);case DtoValue_String() when string != null:
return string(_that);case DtoValue_Boolean() when boolean != null:
return boolean(_that);case DtoValue_Element() when element != null:
return element(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( DtoValue_Undefined value)  undefined,required TResult Function( DtoValue_Number value)  number,required TResult Function( DtoValue_String value)  string,required TResult Function( DtoValue_Boolean value)  boolean,required TResult Function( DtoValue_Element value)  element,}){
final _that = this;
switch (_that) {
case DtoValue_Undefined():
return undefined(_that);case DtoValue_Number():
return number(_that);case DtoValue_String():
return string(_that);case DtoValue_Boolean():
return boolean(_that);case DtoValue_Element():
return element(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( DtoValue_Undefined value)?  undefined,TResult? Function( DtoValue_Number value)?  number,TResult? Function( DtoValue_String value)?  string,TResult? Function( DtoValue_Boolean value)?  boolean,TResult? Function( DtoValue_Element value)?  element,}){
final _that = this;
switch (_that) {
case DtoValue_Undefined() when undefined != null:
return undefined(_that);case DtoValue_Number() when number != null:
return number(_that);case DtoValue_String() when string != null:
return string(_that);case DtoValue_Boolean() when boolean != null:
return boolean(_that);case DtoValue_Element() when element != null:
return element(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  undefined,TResult Function( double field0)?  number,TResult Function( String field0)?  string,TResult Function( bool field0)?  boolean,TResult Function()?  element,required TResult orElse(),}) {final _that = this;
switch (_that) {
case DtoValue_Undefined() when undefined != null:
return undefined();case DtoValue_Number() when number != null:
return number(_that.field0);case DtoValue_String() when string != null:
return string(_that.field0);case DtoValue_Boolean() when boolean != null:
return boolean(_that.field0);case DtoValue_Element() when element != null:
return element();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  undefined,required TResult Function( double field0)  number,required TResult Function( String field0)  string,required TResult Function( bool field0)  boolean,required TResult Function()  element,}) {final _that = this;
switch (_that) {
case DtoValue_Undefined():
return undefined();case DtoValue_Number():
return number(_that.field0);case DtoValue_String():
return string(_that.field0);case DtoValue_Boolean():
return boolean(_that.field0);case DtoValue_Element():
return element();}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  undefined,TResult? Function( double field0)?  number,TResult? Function( String field0)?  string,TResult? Function( bool field0)?  boolean,TResult? Function()?  element,}) {final _that = this;
switch (_that) {
case DtoValue_Undefined() when undefined != null:
return undefined();case DtoValue_Number() when number != null:
return number(_that.field0);case DtoValue_String() when string != null:
return string(_that.field0);case DtoValue_Boolean() when boolean != null:
return boolean(_that.field0);case DtoValue_Element() when element != null:
return element();case _:
  return null;

}
}

}

/// @nodoc


class DtoValue_Undefined extends DtoValue {
  const DtoValue_Undefined(): super._();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DtoValue_Undefined);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'DtoValue.undefined()';
}


}




/// @nodoc


class DtoValue_Number extends DtoValue {
  const DtoValue_Number(this.field0): super._();
  

 final  double field0;

/// Create a copy of DtoValue
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DtoValue_NumberCopyWith<DtoValue_Number> get copyWith => _$DtoValue_NumberCopyWithImpl<DtoValue_Number>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DtoValue_Number&&(identical(other.field0, field0) || other.field0 == field0));
}


@override
int get hashCode => Object.hash(runtimeType,field0);

@override
String toString() {
  return 'DtoValue.number(field0: $field0)';
}


}

/// @nodoc
abstract mixin class $DtoValue_NumberCopyWith<$Res> implements $DtoValueCopyWith<$Res> {
  factory $DtoValue_NumberCopyWith(DtoValue_Number value, $Res Function(DtoValue_Number) _then) = _$DtoValue_NumberCopyWithImpl;
@useResult
$Res call({
 double field0
});




}
/// @nodoc
class _$DtoValue_NumberCopyWithImpl<$Res>
    implements $DtoValue_NumberCopyWith<$Res> {
  _$DtoValue_NumberCopyWithImpl(this._self, this._then);

  final DtoValue_Number _self;
  final $Res Function(DtoValue_Number) _then;

/// Create a copy of DtoValue
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? field0 = null,}) {
  return _then(DtoValue_Number(
null == field0 ? _self.field0 : field0 // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

/// @nodoc


class DtoValue_String extends DtoValue {
  const DtoValue_String(this.field0): super._();
  

 final  String field0;

/// Create a copy of DtoValue
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DtoValue_StringCopyWith<DtoValue_String> get copyWith => _$DtoValue_StringCopyWithImpl<DtoValue_String>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DtoValue_String&&(identical(other.field0, field0) || other.field0 == field0));
}


@override
int get hashCode => Object.hash(runtimeType,field0);

@override
String toString() {
  return 'DtoValue.string(field0: $field0)';
}


}

/// @nodoc
abstract mixin class $DtoValue_StringCopyWith<$Res> implements $DtoValueCopyWith<$Res> {
  factory $DtoValue_StringCopyWith(DtoValue_String value, $Res Function(DtoValue_String) _then) = _$DtoValue_StringCopyWithImpl;
@useResult
$Res call({
 String field0
});




}
/// @nodoc
class _$DtoValue_StringCopyWithImpl<$Res>
    implements $DtoValue_StringCopyWith<$Res> {
  _$DtoValue_StringCopyWithImpl(this._self, this._then);

  final DtoValue_String _self;
  final $Res Function(DtoValue_String) _then;

/// Create a copy of DtoValue
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? field0 = null,}) {
  return _then(DtoValue_String(
null == field0 ? _self.field0 : field0 // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class DtoValue_Boolean extends DtoValue {
  const DtoValue_Boolean(this.field0): super._();
  

 final  bool field0;

/// Create a copy of DtoValue
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DtoValue_BooleanCopyWith<DtoValue_Boolean> get copyWith => _$DtoValue_BooleanCopyWithImpl<DtoValue_Boolean>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DtoValue_Boolean&&(identical(other.field0, field0) || other.field0 == field0));
}


@override
int get hashCode => Object.hash(runtimeType,field0);

@override
String toString() {
  return 'DtoValue.boolean(field0: $field0)';
}


}

/// @nodoc
abstract mixin class $DtoValue_BooleanCopyWith<$Res> implements $DtoValueCopyWith<$Res> {
  factory $DtoValue_BooleanCopyWith(DtoValue_Boolean value, $Res Function(DtoValue_Boolean) _then) = _$DtoValue_BooleanCopyWithImpl;
@useResult
$Res call({
 bool field0
});




}
/// @nodoc
class _$DtoValue_BooleanCopyWithImpl<$Res>
    implements $DtoValue_BooleanCopyWith<$Res> {
  _$DtoValue_BooleanCopyWithImpl(this._self, this._then);

  final DtoValue_Boolean _self;
  final $Res Function(DtoValue_Boolean) _then;

/// Create a copy of DtoValue
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? field0 = null,}) {
  return _then(DtoValue_Boolean(
null == field0 ? _self.field0 : field0 // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class DtoValue_Element extends DtoValue {
  const DtoValue_Element(): super._();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DtoValue_Element);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'DtoValue.element()';
}


}




/// @nodoc
mixin _$DtoVariable {

 Object get field0;



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DtoVariable&&const DeepCollectionEquality().equals(other.field0, field0));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(field0));

@override
String toString() {
  return 'DtoVariable(field0: $field0)';
}


}

/// @nodoc
class $DtoVariableCopyWith<$Res>  {
$DtoVariableCopyWith(DtoVariable _, $Res Function(DtoVariable) __);
}


/// Adds pattern-matching-related methods to [DtoVariable].
extension DtoVariablePatterns on DtoVariable {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( DtoVariable_Identifier value)?  identifier,TResult Function( DtoVariable_Value value)?  value,required TResult orElse(),}){
final _that = this;
switch (_that) {
case DtoVariable_Identifier() when identifier != null:
return identifier(_that);case DtoVariable_Value() when value != null:
return value(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( DtoVariable_Identifier value)  identifier,required TResult Function( DtoVariable_Value value)  value,}){
final _that = this;
switch (_that) {
case DtoVariable_Identifier():
return identifier(_that);case DtoVariable_Value():
return value(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( DtoVariable_Identifier value)?  identifier,TResult? Function( DtoVariable_Value value)?  value,}){
final _that = this;
switch (_that) {
case DtoVariable_Identifier() when identifier != null:
return identifier(_that);case DtoVariable_Value() when value != null:
return value(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String field0)?  identifier,TResult Function( DtoValue field0)?  value,required TResult orElse(),}) {final _that = this;
switch (_that) {
case DtoVariable_Identifier() when identifier != null:
return identifier(_that.field0);case DtoVariable_Value() when value != null:
return value(_that.field0);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String field0)  identifier,required TResult Function( DtoValue field0)  value,}) {final _that = this;
switch (_that) {
case DtoVariable_Identifier():
return identifier(_that.field0);case DtoVariable_Value():
return value(_that.field0);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String field0)?  identifier,TResult? Function( DtoValue field0)?  value,}) {final _that = this;
switch (_that) {
case DtoVariable_Identifier() when identifier != null:
return identifier(_that.field0);case DtoVariable_Value() when value != null:
return value(_that.field0);case _:
  return null;

}
}

}

/// @nodoc


class DtoVariable_Identifier extends DtoVariable {
  const DtoVariable_Identifier(this.field0): super._();
  

@override final  String field0;

/// Create a copy of DtoVariable
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DtoVariable_IdentifierCopyWith<DtoVariable_Identifier> get copyWith => _$DtoVariable_IdentifierCopyWithImpl<DtoVariable_Identifier>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DtoVariable_Identifier&&(identical(other.field0, field0) || other.field0 == field0));
}


@override
int get hashCode => Object.hash(runtimeType,field0);

@override
String toString() {
  return 'DtoVariable.identifier(field0: $field0)';
}


}

/// @nodoc
abstract mixin class $DtoVariable_IdentifierCopyWith<$Res> implements $DtoVariableCopyWith<$Res> {
  factory $DtoVariable_IdentifierCopyWith(DtoVariable_Identifier value, $Res Function(DtoVariable_Identifier) _then) = _$DtoVariable_IdentifierCopyWithImpl;
@useResult
$Res call({
 String field0
});




}
/// @nodoc
class _$DtoVariable_IdentifierCopyWithImpl<$Res>
    implements $DtoVariable_IdentifierCopyWith<$Res> {
  _$DtoVariable_IdentifierCopyWithImpl(this._self, this._then);

  final DtoVariable_Identifier _self;
  final $Res Function(DtoVariable_Identifier) _then;

/// Create a copy of DtoVariable
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? field0 = null,}) {
  return _then(DtoVariable_Identifier(
null == field0 ? _self.field0 : field0 // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class DtoVariable_Value extends DtoVariable {
  const DtoVariable_Value(this.field0): super._();
  

@override final  DtoValue field0;

/// Create a copy of DtoVariable
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DtoVariable_ValueCopyWith<DtoVariable_Value> get copyWith => _$DtoVariable_ValueCopyWithImpl<DtoVariable_Value>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DtoVariable_Value&&(identical(other.field0, field0) || other.field0 == field0));
}


@override
int get hashCode => Object.hash(runtimeType,field0);

@override
String toString() {
  return 'DtoVariable.value(field0: $field0)';
}


}

/// @nodoc
abstract mixin class $DtoVariable_ValueCopyWith<$Res> implements $DtoVariableCopyWith<$Res> {
  factory $DtoVariable_ValueCopyWith(DtoVariable_Value value, $Res Function(DtoVariable_Value) _then) = _$DtoVariable_ValueCopyWithImpl;
@useResult
$Res call({
 DtoValue field0
});


$DtoValueCopyWith<$Res> get field0;

}
/// @nodoc
class _$DtoVariable_ValueCopyWithImpl<$Res>
    implements $DtoVariable_ValueCopyWith<$Res> {
  _$DtoVariable_ValueCopyWithImpl(this._self, this._then);

  final DtoVariable_Value _self;
  final $Res Function(DtoVariable_Value) _then;

/// Create a copy of DtoVariable
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? field0 = null,}) {
  return _then(DtoVariable_Value(
null == field0 ? _self.field0 : field0 // ignore: cast_nullable_to_non_nullable
as DtoValue,
  ));
}

/// Create a copy of DtoVariable
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DtoValueCopyWith<$Res> get field0 {
  
  return $DtoValueCopyWith<$Res>(_self.field0, (value) {
    return _then(_self.copyWith(field0: value));
  });
}
}

// dart format on
