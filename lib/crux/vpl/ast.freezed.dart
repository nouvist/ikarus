// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ast.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Assignment {

 String get name; Value get value;
/// Create a copy of Assignment
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AssignmentCopyWith<Assignment> get copyWith => _$AssignmentCopyWithImpl<Assignment>(this as Assignment, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Assignment&&(identical(other.name, name) || other.name == name)&&(identical(other.value, value) || other.value == value));
}


@override
int get hashCode => Object.hash(runtimeType,name,value);

@override
String toString() {
  return 'Assignment(name: $name, value: $value)';
}


}

/// @nodoc
abstract mixin class $AssignmentCopyWith<$Res>  {
  factory $AssignmentCopyWith(Assignment value, $Res Function(Assignment) _then) = _$AssignmentCopyWithImpl;
@useResult
$Res call({
 String name, Value value
});


$ValueCopyWith<$Res> get value;

}
/// @nodoc
class _$AssignmentCopyWithImpl<$Res>
    implements $AssignmentCopyWith<$Res> {
  _$AssignmentCopyWithImpl(this._self, this._then);

  final Assignment _self;
  final $Res Function(Assignment) _then;

/// Create a copy of Assignment
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? value = null,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as Value,
  ));
}
/// Create a copy of Assignment
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ValueCopyWith<$Res> get value {
  
  return $ValueCopyWith<$Res>(_self.value, (value) {
    return _then(_self.copyWith(value: value));
  });
}
}


/// Adds pattern-matching-related methods to [Assignment].
extension AssignmentPatterns on Assignment {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( Assignment_Declare value)?  declare,required TResult orElse(),}){
final _that = this;
switch (_that) {
case Assignment_Declare() when declare != null:
return declare(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( Assignment_Declare value)  declare,}){
final _that = this;
switch (_that) {
case Assignment_Declare():
return declare(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( Assignment_Declare value)?  declare,}){
final _that = this;
switch (_that) {
case Assignment_Declare() when declare != null:
return declare(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String name,  Value value)?  declare,required TResult orElse(),}) {final _that = this;
switch (_that) {
case Assignment_Declare() when declare != null:
return declare(_that.name,_that.value);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String name,  Value value)  declare,}) {final _that = this;
switch (_that) {
case Assignment_Declare():
return declare(_that.name,_that.value);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String name,  Value value)?  declare,}) {final _that = this;
switch (_that) {
case Assignment_Declare() when declare != null:
return declare(_that.name,_that.value);case _:
  return null;

}
}

}

/// @nodoc


class Assignment_Declare extends Assignment {
  const Assignment_Declare({required this.name, required this.value}): super._();
  

@override final  String name;
@override final  Value value;

/// Create a copy of Assignment
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$Assignment_DeclareCopyWith<Assignment_Declare> get copyWith => _$Assignment_DeclareCopyWithImpl<Assignment_Declare>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Assignment_Declare&&(identical(other.name, name) || other.name == name)&&(identical(other.value, value) || other.value == value));
}


@override
int get hashCode => Object.hash(runtimeType,name,value);

@override
String toString() {
  return 'Assignment.declare(name: $name, value: $value)';
}


}

/// @nodoc
abstract mixin class $Assignment_DeclareCopyWith<$Res> implements $AssignmentCopyWith<$Res> {
  factory $Assignment_DeclareCopyWith(Assignment_Declare value, $Res Function(Assignment_Declare) _then) = _$Assignment_DeclareCopyWithImpl;
@override @useResult
$Res call({
 String name, Value value
});


@override $ValueCopyWith<$Res> get value;

}
/// @nodoc
class _$Assignment_DeclareCopyWithImpl<$Res>
    implements $Assignment_DeclareCopyWith<$Res> {
  _$Assignment_DeclareCopyWithImpl(this._self, this._then);

  final Assignment_Declare _self;
  final $Res Function(Assignment_Declare) _then;

/// Create a copy of Assignment
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? value = null,}) {
  return _then(Assignment_Declare(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as Value,
  ));
}

/// Create a copy of Assignment
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ValueCopyWith<$Res> get value {
  
  return $ValueCopyWith<$Res>(_self.value, (value) {
    return _then(_self.copyWith(value: value));
  });
}
}

/// @nodoc
mixin _$Value {

 Object get field0;



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Value&&const DeepCollectionEquality().equals(other.field0, field0));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(field0));

@override
String toString() {
  return 'Value(field0: $field0)';
}


}

/// @nodoc
class $ValueCopyWith<$Res>  {
$ValueCopyWith(Value _, $Res Function(Value) __);
}


/// Adds pattern-matching-related methods to [Value].
extension ValuePatterns on Value {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( Value_Number value)?  number,TResult Function( Value_String value)?  string,TResult Function( Value_Boolean value)?  boolean,required TResult orElse(),}){
final _that = this;
switch (_that) {
case Value_Number() when number != null:
return number(_that);case Value_String() when string != null:
return string(_that);case Value_Boolean() when boolean != null:
return boolean(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( Value_Number value)  number,required TResult Function( Value_String value)  string,required TResult Function( Value_Boolean value)  boolean,}){
final _that = this;
switch (_that) {
case Value_Number():
return number(_that);case Value_String():
return string(_that);case Value_Boolean():
return boolean(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( Value_Number value)?  number,TResult? Function( Value_String value)?  string,TResult? Function( Value_Boolean value)?  boolean,}){
final _that = this;
switch (_that) {
case Value_Number() when number != null:
return number(_that);case Value_String() when string != null:
return string(_that);case Value_Boolean() when boolean != null:
return boolean(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( double field0)?  number,TResult Function( String field0)?  string,TResult Function( bool field0)?  boolean,required TResult orElse(),}) {final _that = this;
switch (_that) {
case Value_Number() when number != null:
return number(_that.field0);case Value_String() when string != null:
return string(_that.field0);case Value_Boolean() when boolean != null:
return boolean(_that.field0);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( double field0)  number,required TResult Function( String field0)  string,required TResult Function( bool field0)  boolean,}) {final _that = this;
switch (_that) {
case Value_Number():
return number(_that.field0);case Value_String():
return string(_that.field0);case Value_Boolean():
return boolean(_that.field0);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( double field0)?  number,TResult? Function( String field0)?  string,TResult? Function( bool field0)?  boolean,}) {final _that = this;
switch (_that) {
case Value_Number() when number != null:
return number(_that.field0);case Value_String() when string != null:
return string(_that.field0);case Value_Boolean() when boolean != null:
return boolean(_that.field0);case _:
  return null;

}
}

}

/// @nodoc


class Value_Number extends Value {
  const Value_Number(this.field0): super._();
  

@override final  double field0;

/// Create a copy of Value
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$Value_NumberCopyWith<Value_Number> get copyWith => _$Value_NumberCopyWithImpl<Value_Number>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Value_Number&&(identical(other.field0, field0) || other.field0 == field0));
}


@override
int get hashCode => Object.hash(runtimeType,field0);

@override
String toString() {
  return 'Value.number(field0: $field0)';
}


}

/// @nodoc
abstract mixin class $Value_NumberCopyWith<$Res> implements $ValueCopyWith<$Res> {
  factory $Value_NumberCopyWith(Value_Number value, $Res Function(Value_Number) _then) = _$Value_NumberCopyWithImpl;
@useResult
$Res call({
 double field0
});




}
/// @nodoc
class _$Value_NumberCopyWithImpl<$Res>
    implements $Value_NumberCopyWith<$Res> {
  _$Value_NumberCopyWithImpl(this._self, this._then);

  final Value_Number _self;
  final $Res Function(Value_Number) _then;

/// Create a copy of Value
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? field0 = null,}) {
  return _then(Value_Number(
null == field0 ? _self.field0 : field0 // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

/// @nodoc


class Value_String extends Value {
  const Value_String(this.field0): super._();
  

@override final  String field0;

/// Create a copy of Value
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$Value_StringCopyWith<Value_String> get copyWith => _$Value_StringCopyWithImpl<Value_String>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Value_String&&(identical(other.field0, field0) || other.field0 == field0));
}


@override
int get hashCode => Object.hash(runtimeType,field0);

@override
String toString() {
  return 'Value.string(field0: $field0)';
}


}

/// @nodoc
abstract mixin class $Value_StringCopyWith<$Res> implements $ValueCopyWith<$Res> {
  factory $Value_StringCopyWith(Value_String value, $Res Function(Value_String) _then) = _$Value_StringCopyWithImpl;
@useResult
$Res call({
 String field0
});




}
/// @nodoc
class _$Value_StringCopyWithImpl<$Res>
    implements $Value_StringCopyWith<$Res> {
  _$Value_StringCopyWithImpl(this._self, this._then);

  final Value_String _self;
  final $Res Function(Value_String) _then;

/// Create a copy of Value
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? field0 = null,}) {
  return _then(Value_String(
null == field0 ? _self.field0 : field0 // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class Value_Boolean extends Value {
  const Value_Boolean(this.field0): super._();
  

@override final  bool field0;

/// Create a copy of Value
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$Value_BooleanCopyWith<Value_Boolean> get copyWith => _$Value_BooleanCopyWithImpl<Value_Boolean>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Value_Boolean&&(identical(other.field0, field0) || other.field0 == field0));
}


@override
int get hashCode => Object.hash(runtimeType,field0);

@override
String toString() {
  return 'Value.boolean(field0: $field0)';
}


}

/// @nodoc
abstract mixin class $Value_BooleanCopyWith<$Res> implements $ValueCopyWith<$Res> {
  factory $Value_BooleanCopyWith(Value_Boolean value, $Res Function(Value_Boolean) _then) = _$Value_BooleanCopyWithImpl;
@useResult
$Res call({
 bool field0
});




}
/// @nodoc
class _$Value_BooleanCopyWithImpl<$Res>
    implements $Value_BooleanCopyWith<$Res> {
  _$Value_BooleanCopyWithImpl(this._self, this._then);

  final Value_Boolean _self;
  final $Res Function(Value_Boolean) _then;

/// Create a copy of Value
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? field0 = null,}) {
  return _then(Value_Boolean(
null == field0 ? _self.field0 : field0 // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
