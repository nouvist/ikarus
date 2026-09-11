// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'functions.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$FnCall {

 Object get field0;



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FnCall&&const DeepCollectionEquality().equals(other.field0, field0));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(field0));

@override
String toString() {
  return 'FnCall(field0: $field0)';
}


}

/// @nodoc
class $FnCallCopyWith<$Res>  {
$FnCallCopyWith(FnCall _, $Res Function(FnCall) __);
}


/// Adds pattern-matching-related methods to [FnCall].
extension FnCallPatterns on FnCall {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( FnCall_SystemStop value)?  systemStop,TResult Function( FnCall_SystemPrint value)?  systemPrint,TResult Function( FnCall_SystemSleep value)?  systemSleep,TResult Function( FnCall_PageNew value)?  pageNew,TResult Function( FnCall_PageGetByIndex value)?  pageGetByIndex,TResult Function( FnCall_PageGetCount value)?  pageGetCount,TResult Function( FnCall_PageWaitForNavigation value)?  pageWaitForNavigation,TResult Function( FnCall_PageClose value)?  pageClose,TResult Function( FnCall_PageFindElement value)?  pageFindElement,TResult Function( FnCall_ElementGetOuterHtml value)?  elementGetOuterHtml,TResult Function( FnCall_ElementGetInnerHtml value)?  elementGetInnerHtml,TResult Function( FnCall_ElementGetText value)?  elementGetText,TResult Function( FnCall_ElementType value)?  elementType,TResult Function( FnCall_ElementClick value)?  elementClick,TResult Function( FnCall_CsvNew value)?  csvNew,TResult Function( FnCall_CsvLoad value)?  csvLoad,TResult Function( FnCall_CsvSave value)?  csvSave,TResult Function( FnCall_CsvGet value)?  csvGet,TResult Function( FnCall_CsvSet value)?  csvSet,TResult Function( FnCall_CsvRowCount value)?  csvRowCount,required TResult orElse(),}){
final _that = this;
switch (_that) {
case FnCall_SystemStop() when systemStop != null:
return systemStop(_that);case FnCall_SystemPrint() when systemPrint != null:
return systemPrint(_that);case FnCall_SystemSleep() when systemSleep != null:
return systemSleep(_that);case FnCall_PageNew() when pageNew != null:
return pageNew(_that);case FnCall_PageGetByIndex() when pageGetByIndex != null:
return pageGetByIndex(_that);case FnCall_PageGetCount() when pageGetCount != null:
return pageGetCount(_that);case FnCall_PageWaitForNavigation() when pageWaitForNavigation != null:
return pageWaitForNavigation(_that);case FnCall_PageClose() when pageClose != null:
return pageClose(_that);case FnCall_PageFindElement() when pageFindElement != null:
return pageFindElement(_that);case FnCall_ElementGetOuterHtml() when elementGetOuterHtml != null:
return elementGetOuterHtml(_that);case FnCall_ElementGetInnerHtml() when elementGetInnerHtml != null:
return elementGetInnerHtml(_that);case FnCall_ElementGetText() when elementGetText != null:
return elementGetText(_that);case FnCall_ElementType() when elementType != null:
return elementType(_that);case FnCall_ElementClick() when elementClick != null:
return elementClick(_that);case FnCall_CsvNew() when csvNew != null:
return csvNew(_that);case FnCall_CsvLoad() when csvLoad != null:
return csvLoad(_that);case FnCall_CsvSave() when csvSave != null:
return csvSave(_that);case FnCall_CsvGet() when csvGet != null:
return csvGet(_that);case FnCall_CsvSet() when csvSet != null:
return csvSet(_that);case FnCall_CsvRowCount() when csvRowCount != null:
return csvRowCount(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( FnCall_SystemStop value)  systemStop,required TResult Function( FnCall_SystemPrint value)  systemPrint,required TResult Function( FnCall_SystemSleep value)  systemSleep,required TResult Function( FnCall_PageNew value)  pageNew,required TResult Function( FnCall_PageGetByIndex value)  pageGetByIndex,required TResult Function( FnCall_PageGetCount value)  pageGetCount,required TResult Function( FnCall_PageWaitForNavigation value)  pageWaitForNavigation,required TResult Function( FnCall_PageClose value)  pageClose,required TResult Function( FnCall_PageFindElement value)  pageFindElement,required TResult Function( FnCall_ElementGetOuterHtml value)  elementGetOuterHtml,required TResult Function( FnCall_ElementGetInnerHtml value)  elementGetInnerHtml,required TResult Function( FnCall_ElementGetText value)  elementGetText,required TResult Function( FnCall_ElementType value)  elementType,required TResult Function( FnCall_ElementClick value)  elementClick,required TResult Function( FnCall_CsvNew value)  csvNew,required TResult Function( FnCall_CsvLoad value)  csvLoad,required TResult Function( FnCall_CsvSave value)  csvSave,required TResult Function( FnCall_CsvGet value)  csvGet,required TResult Function( FnCall_CsvSet value)  csvSet,required TResult Function( FnCall_CsvRowCount value)  csvRowCount,}){
final _that = this;
switch (_that) {
case FnCall_SystemStop():
return systemStop(_that);case FnCall_SystemPrint():
return systemPrint(_that);case FnCall_SystemSleep():
return systemSleep(_that);case FnCall_PageNew():
return pageNew(_that);case FnCall_PageGetByIndex():
return pageGetByIndex(_that);case FnCall_PageGetCount():
return pageGetCount(_that);case FnCall_PageWaitForNavigation():
return pageWaitForNavigation(_that);case FnCall_PageClose():
return pageClose(_that);case FnCall_PageFindElement():
return pageFindElement(_that);case FnCall_ElementGetOuterHtml():
return elementGetOuterHtml(_that);case FnCall_ElementGetInnerHtml():
return elementGetInnerHtml(_that);case FnCall_ElementGetText():
return elementGetText(_that);case FnCall_ElementType():
return elementType(_that);case FnCall_ElementClick():
return elementClick(_that);case FnCall_CsvNew():
return csvNew(_that);case FnCall_CsvLoad():
return csvLoad(_that);case FnCall_CsvSave():
return csvSave(_that);case FnCall_CsvGet():
return csvGet(_that);case FnCall_CsvSet():
return csvSet(_that);case FnCall_CsvRowCount():
return csvRowCount(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( FnCall_SystemStop value)?  systemStop,TResult? Function( FnCall_SystemPrint value)?  systemPrint,TResult? Function( FnCall_SystemSleep value)?  systemSleep,TResult? Function( FnCall_PageNew value)?  pageNew,TResult? Function( FnCall_PageGetByIndex value)?  pageGetByIndex,TResult? Function( FnCall_PageGetCount value)?  pageGetCount,TResult? Function( FnCall_PageWaitForNavigation value)?  pageWaitForNavigation,TResult? Function( FnCall_PageClose value)?  pageClose,TResult? Function( FnCall_PageFindElement value)?  pageFindElement,TResult? Function( FnCall_ElementGetOuterHtml value)?  elementGetOuterHtml,TResult? Function( FnCall_ElementGetInnerHtml value)?  elementGetInnerHtml,TResult? Function( FnCall_ElementGetText value)?  elementGetText,TResult? Function( FnCall_ElementType value)?  elementType,TResult? Function( FnCall_ElementClick value)?  elementClick,TResult? Function( FnCall_CsvNew value)?  csvNew,TResult? Function( FnCall_CsvLoad value)?  csvLoad,TResult? Function( FnCall_CsvSave value)?  csvSave,TResult? Function( FnCall_CsvGet value)?  csvGet,TResult? Function( FnCall_CsvSet value)?  csvSet,TResult? Function( FnCall_CsvRowCount value)?  csvRowCount,}){
final _that = this;
switch (_that) {
case FnCall_SystemStop() when systemStop != null:
return systemStop(_that);case FnCall_SystemPrint() when systemPrint != null:
return systemPrint(_that);case FnCall_SystemSleep() when systemSleep != null:
return systemSleep(_that);case FnCall_PageNew() when pageNew != null:
return pageNew(_that);case FnCall_PageGetByIndex() when pageGetByIndex != null:
return pageGetByIndex(_that);case FnCall_PageGetCount() when pageGetCount != null:
return pageGetCount(_that);case FnCall_PageWaitForNavigation() when pageWaitForNavigation != null:
return pageWaitForNavigation(_that);case FnCall_PageClose() when pageClose != null:
return pageClose(_that);case FnCall_PageFindElement() when pageFindElement != null:
return pageFindElement(_that);case FnCall_ElementGetOuterHtml() when elementGetOuterHtml != null:
return elementGetOuterHtml(_that);case FnCall_ElementGetInnerHtml() when elementGetInnerHtml != null:
return elementGetInnerHtml(_that);case FnCall_ElementGetText() when elementGetText != null:
return elementGetText(_that);case FnCall_ElementType() when elementType != null:
return elementType(_that);case FnCall_ElementClick() when elementClick != null:
return elementClick(_that);case FnCall_CsvNew() when csvNew != null:
return csvNew(_that);case FnCall_CsvLoad() when csvLoad != null:
return csvLoad(_that);case FnCall_CsvSave() when csvSave != null:
return csvSave(_that);case FnCall_CsvGet() when csvGet != null:
return csvGet(_that);case FnCall_CsvSet() when csvSet != null:
return csvSet(_that);case FnCall_CsvRowCount() when csvRowCount != null:
return csvRowCount(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( FnCallSystemStop field0)?  systemStop,TResult Function( FnCallSystemPrint field0)?  systemPrint,TResult Function( FnCallSystemSleep field0)?  systemSleep,TResult Function( FnCallPageNew field0)?  pageNew,TResult Function( FnCallPageGetByIndex field0)?  pageGetByIndex,TResult Function( FnCallPageGetCount field0)?  pageGetCount,TResult Function( FnCallPageWaitForNavigation field0)?  pageWaitForNavigation,TResult Function( FnCallPageClose field0)?  pageClose,TResult Function( FnCallPageFindElement field0)?  pageFindElement,TResult Function( FnCallElementGetOuterHtml field0)?  elementGetOuterHtml,TResult Function( FnCallElementGetInnerHtml field0)?  elementGetInnerHtml,TResult Function( FnCallElementGetText field0)?  elementGetText,TResult Function( FnCallElementType field0)?  elementType,TResult Function( FnCallElementClick field0)?  elementClick,TResult Function( FnCallCsvNew field0)?  csvNew,TResult Function( FnCallCsvLoad field0)?  csvLoad,TResult Function( FnCallCsvSave field0)?  csvSave,TResult Function( FnCallCsvGet field0)?  csvGet,TResult Function( FnCallCsvSet field0)?  csvSet,TResult Function( FnCallCsvRowCount field0)?  csvRowCount,required TResult orElse(),}) {final _that = this;
switch (_that) {
case FnCall_SystemStop() when systemStop != null:
return systemStop(_that.field0);case FnCall_SystemPrint() when systemPrint != null:
return systemPrint(_that.field0);case FnCall_SystemSleep() when systemSleep != null:
return systemSleep(_that.field0);case FnCall_PageNew() when pageNew != null:
return pageNew(_that.field0);case FnCall_PageGetByIndex() when pageGetByIndex != null:
return pageGetByIndex(_that.field0);case FnCall_PageGetCount() when pageGetCount != null:
return pageGetCount(_that.field0);case FnCall_PageWaitForNavigation() when pageWaitForNavigation != null:
return pageWaitForNavigation(_that.field0);case FnCall_PageClose() when pageClose != null:
return pageClose(_that.field0);case FnCall_PageFindElement() when pageFindElement != null:
return pageFindElement(_that.field0);case FnCall_ElementGetOuterHtml() when elementGetOuterHtml != null:
return elementGetOuterHtml(_that.field0);case FnCall_ElementGetInnerHtml() when elementGetInnerHtml != null:
return elementGetInnerHtml(_that.field0);case FnCall_ElementGetText() when elementGetText != null:
return elementGetText(_that.field0);case FnCall_ElementType() when elementType != null:
return elementType(_that.field0);case FnCall_ElementClick() when elementClick != null:
return elementClick(_that.field0);case FnCall_CsvNew() when csvNew != null:
return csvNew(_that.field0);case FnCall_CsvLoad() when csvLoad != null:
return csvLoad(_that.field0);case FnCall_CsvSave() when csvSave != null:
return csvSave(_that.field0);case FnCall_CsvGet() when csvGet != null:
return csvGet(_that.field0);case FnCall_CsvSet() when csvSet != null:
return csvSet(_that.field0);case FnCall_CsvRowCount() when csvRowCount != null:
return csvRowCount(_that.field0);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( FnCallSystemStop field0)  systemStop,required TResult Function( FnCallSystemPrint field0)  systemPrint,required TResult Function( FnCallSystemSleep field0)  systemSleep,required TResult Function( FnCallPageNew field0)  pageNew,required TResult Function( FnCallPageGetByIndex field0)  pageGetByIndex,required TResult Function( FnCallPageGetCount field0)  pageGetCount,required TResult Function( FnCallPageWaitForNavigation field0)  pageWaitForNavigation,required TResult Function( FnCallPageClose field0)  pageClose,required TResult Function( FnCallPageFindElement field0)  pageFindElement,required TResult Function( FnCallElementGetOuterHtml field0)  elementGetOuterHtml,required TResult Function( FnCallElementGetInnerHtml field0)  elementGetInnerHtml,required TResult Function( FnCallElementGetText field0)  elementGetText,required TResult Function( FnCallElementType field0)  elementType,required TResult Function( FnCallElementClick field0)  elementClick,required TResult Function( FnCallCsvNew field0)  csvNew,required TResult Function( FnCallCsvLoad field0)  csvLoad,required TResult Function( FnCallCsvSave field0)  csvSave,required TResult Function( FnCallCsvGet field0)  csvGet,required TResult Function( FnCallCsvSet field0)  csvSet,required TResult Function( FnCallCsvRowCount field0)  csvRowCount,}) {final _that = this;
switch (_that) {
case FnCall_SystemStop():
return systemStop(_that.field0);case FnCall_SystemPrint():
return systemPrint(_that.field0);case FnCall_SystemSleep():
return systemSleep(_that.field0);case FnCall_PageNew():
return pageNew(_that.field0);case FnCall_PageGetByIndex():
return pageGetByIndex(_that.field0);case FnCall_PageGetCount():
return pageGetCount(_that.field0);case FnCall_PageWaitForNavigation():
return pageWaitForNavigation(_that.field0);case FnCall_PageClose():
return pageClose(_that.field0);case FnCall_PageFindElement():
return pageFindElement(_that.field0);case FnCall_ElementGetOuterHtml():
return elementGetOuterHtml(_that.field0);case FnCall_ElementGetInnerHtml():
return elementGetInnerHtml(_that.field0);case FnCall_ElementGetText():
return elementGetText(_that.field0);case FnCall_ElementType():
return elementType(_that.field0);case FnCall_ElementClick():
return elementClick(_that.field0);case FnCall_CsvNew():
return csvNew(_that.field0);case FnCall_CsvLoad():
return csvLoad(_that.field0);case FnCall_CsvSave():
return csvSave(_that.field0);case FnCall_CsvGet():
return csvGet(_that.field0);case FnCall_CsvSet():
return csvSet(_that.field0);case FnCall_CsvRowCount():
return csvRowCount(_that.field0);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( FnCallSystemStop field0)?  systemStop,TResult? Function( FnCallSystemPrint field0)?  systemPrint,TResult? Function( FnCallSystemSleep field0)?  systemSleep,TResult? Function( FnCallPageNew field0)?  pageNew,TResult? Function( FnCallPageGetByIndex field0)?  pageGetByIndex,TResult? Function( FnCallPageGetCount field0)?  pageGetCount,TResult? Function( FnCallPageWaitForNavigation field0)?  pageWaitForNavigation,TResult? Function( FnCallPageClose field0)?  pageClose,TResult? Function( FnCallPageFindElement field0)?  pageFindElement,TResult? Function( FnCallElementGetOuterHtml field0)?  elementGetOuterHtml,TResult? Function( FnCallElementGetInnerHtml field0)?  elementGetInnerHtml,TResult? Function( FnCallElementGetText field0)?  elementGetText,TResult? Function( FnCallElementType field0)?  elementType,TResult? Function( FnCallElementClick field0)?  elementClick,TResult? Function( FnCallCsvNew field0)?  csvNew,TResult? Function( FnCallCsvLoad field0)?  csvLoad,TResult? Function( FnCallCsvSave field0)?  csvSave,TResult? Function( FnCallCsvGet field0)?  csvGet,TResult? Function( FnCallCsvSet field0)?  csvSet,TResult? Function( FnCallCsvRowCount field0)?  csvRowCount,}) {final _that = this;
switch (_that) {
case FnCall_SystemStop() when systemStop != null:
return systemStop(_that.field0);case FnCall_SystemPrint() when systemPrint != null:
return systemPrint(_that.field0);case FnCall_SystemSleep() when systemSleep != null:
return systemSleep(_that.field0);case FnCall_PageNew() when pageNew != null:
return pageNew(_that.field0);case FnCall_PageGetByIndex() when pageGetByIndex != null:
return pageGetByIndex(_that.field0);case FnCall_PageGetCount() when pageGetCount != null:
return pageGetCount(_that.field0);case FnCall_PageWaitForNavigation() when pageWaitForNavigation != null:
return pageWaitForNavigation(_that.field0);case FnCall_PageClose() when pageClose != null:
return pageClose(_that.field0);case FnCall_PageFindElement() when pageFindElement != null:
return pageFindElement(_that.field0);case FnCall_ElementGetOuterHtml() when elementGetOuterHtml != null:
return elementGetOuterHtml(_that.field0);case FnCall_ElementGetInnerHtml() when elementGetInnerHtml != null:
return elementGetInnerHtml(_that.field0);case FnCall_ElementGetText() when elementGetText != null:
return elementGetText(_that.field0);case FnCall_ElementType() when elementType != null:
return elementType(_that.field0);case FnCall_ElementClick() when elementClick != null:
return elementClick(_that.field0);case FnCall_CsvNew() when csvNew != null:
return csvNew(_that.field0);case FnCall_CsvLoad() when csvLoad != null:
return csvLoad(_that.field0);case FnCall_CsvSave() when csvSave != null:
return csvSave(_that.field0);case FnCall_CsvGet() when csvGet != null:
return csvGet(_that.field0);case FnCall_CsvSet() when csvSet != null:
return csvSet(_that.field0);case FnCall_CsvRowCount() when csvRowCount != null:
return csvRowCount(_that.field0);case _:
  return null;

}
}

}

/// @nodoc


class FnCall_SystemStop extends FnCall {
  const FnCall_SystemStop(this.field0): super._();
  

@override final  FnCallSystemStop field0;

/// Create a copy of FnCall
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FnCall_SystemStopCopyWith<FnCall_SystemStop> get copyWith => _$FnCall_SystemStopCopyWithImpl<FnCall_SystemStop>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FnCall_SystemStop&&(identical(other.field0, field0) || other.field0 == field0));
}


@override
int get hashCode => Object.hash(runtimeType,field0);

@override
String toString() {
  return 'FnCall.systemStop(field0: $field0)';
}


}

/// @nodoc
abstract mixin class $FnCall_SystemStopCopyWith<$Res> implements $FnCallCopyWith<$Res> {
  factory $FnCall_SystemStopCopyWith(FnCall_SystemStop value, $Res Function(FnCall_SystemStop) _then) = _$FnCall_SystemStopCopyWithImpl;
@useResult
$Res call({
 FnCallSystemStop field0
});




}
/// @nodoc
class _$FnCall_SystemStopCopyWithImpl<$Res>
    implements $FnCall_SystemStopCopyWith<$Res> {
  _$FnCall_SystemStopCopyWithImpl(this._self, this._then);

  final FnCall_SystemStop _self;
  final $Res Function(FnCall_SystemStop) _then;

/// Create a copy of FnCall
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? field0 = null,}) {
  return _then(FnCall_SystemStop(
null == field0 ? _self.field0 : field0 // ignore: cast_nullable_to_non_nullable
as FnCallSystemStop,
  ));
}


}

/// @nodoc


class FnCall_SystemPrint extends FnCall {
  const FnCall_SystemPrint(this.field0): super._();
  

@override final  FnCallSystemPrint field0;

/// Create a copy of FnCall
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FnCall_SystemPrintCopyWith<FnCall_SystemPrint> get copyWith => _$FnCall_SystemPrintCopyWithImpl<FnCall_SystemPrint>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FnCall_SystemPrint&&(identical(other.field0, field0) || other.field0 == field0));
}


@override
int get hashCode => Object.hash(runtimeType,field0);

@override
String toString() {
  return 'FnCall.systemPrint(field0: $field0)';
}


}

/// @nodoc
abstract mixin class $FnCall_SystemPrintCopyWith<$Res> implements $FnCallCopyWith<$Res> {
  factory $FnCall_SystemPrintCopyWith(FnCall_SystemPrint value, $Res Function(FnCall_SystemPrint) _then) = _$FnCall_SystemPrintCopyWithImpl;
@useResult
$Res call({
 FnCallSystemPrint field0
});




}
/// @nodoc
class _$FnCall_SystemPrintCopyWithImpl<$Res>
    implements $FnCall_SystemPrintCopyWith<$Res> {
  _$FnCall_SystemPrintCopyWithImpl(this._self, this._then);

  final FnCall_SystemPrint _self;
  final $Res Function(FnCall_SystemPrint) _then;

/// Create a copy of FnCall
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? field0 = null,}) {
  return _then(FnCall_SystemPrint(
null == field0 ? _self.field0 : field0 // ignore: cast_nullable_to_non_nullable
as FnCallSystemPrint,
  ));
}


}

/// @nodoc


class FnCall_SystemSleep extends FnCall {
  const FnCall_SystemSleep(this.field0): super._();
  

@override final  FnCallSystemSleep field0;

/// Create a copy of FnCall
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FnCall_SystemSleepCopyWith<FnCall_SystemSleep> get copyWith => _$FnCall_SystemSleepCopyWithImpl<FnCall_SystemSleep>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FnCall_SystemSleep&&(identical(other.field0, field0) || other.field0 == field0));
}


@override
int get hashCode => Object.hash(runtimeType,field0);

@override
String toString() {
  return 'FnCall.systemSleep(field0: $field0)';
}


}

/// @nodoc
abstract mixin class $FnCall_SystemSleepCopyWith<$Res> implements $FnCallCopyWith<$Res> {
  factory $FnCall_SystemSleepCopyWith(FnCall_SystemSleep value, $Res Function(FnCall_SystemSleep) _then) = _$FnCall_SystemSleepCopyWithImpl;
@useResult
$Res call({
 FnCallSystemSleep field0
});




}
/// @nodoc
class _$FnCall_SystemSleepCopyWithImpl<$Res>
    implements $FnCall_SystemSleepCopyWith<$Res> {
  _$FnCall_SystemSleepCopyWithImpl(this._self, this._then);

  final FnCall_SystemSleep _self;
  final $Res Function(FnCall_SystemSleep) _then;

/// Create a copy of FnCall
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? field0 = null,}) {
  return _then(FnCall_SystemSleep(
null == field0 ? _self.field0 : field0 // ignore: cast_nullable_to_non_nullable
as FnCallSystemSleep,
  ));
}


}

/// @nodoc


class FnCall_PageNew extends FnCall {
  const FnCall_PageNew(this.field0): super._();
  

@override final  FnCallPageNew field0;

/// Create a copy of FnCall
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FnCall_PageNewCopyWith<FnCall_PageNew> get copyWith => _$FnCall_PageNewCopyWithImpl<FnCall_PageNew>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FnCall_PageNew&&(identical(other.field0, field0) || other.field0 == field0));
}


@override
int get hashCode => Object.hash(runtimeType,field0);

@override
String toString() {
  return 'FnCall.pageNew(field0: $field0)';
}


}

/// @nodoc
abstract mixin class $FnCall_PageNewCopyWith<$Res> implements $FnCallCopyWith<$Res> {
  factory $FnCall_PageNewCopyWith(FnCall_PageNew value, $Res Function(FnCall_PageNew) _then) = _$FnCall_PageNewCopyWithImpl;
@useResult
$Res call({
 FnCallPageNew field0
});




}
/// @nodoc
class _$FnCall_PageNewCopyWithImpl<$Res>
    implements $FnCall_PageNewCopyWith<$Res> {
  _$FnCall_PageNewCopyWithImpl(this._self, this._then);

  final FnCall_PageNew _self;
  final $Res Function(FnCall_PageNew) _then;

/// Create a copy of FnCall
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? field0 = null,}) {
  return _then(FnCall_PageNew(
null == field0 ? _self.field0 : field0 // ignore: cast_nullable_to_non_nullable
as FnCallPageNew,
  ));
}


}

/// @nodoc


class FnCall_PageGetByIndex extends FnCall {
  const FnCall_PageGetByIndex(this.field0): super._();
  

@override final  FnCallPageGetByIndex field0;

/// Create a copy of FnCall
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FnCall_PageGetByIndexCopyWith<FnCall_PageGetByIndex> get copyWith => _$FnCall_PageGetByIndexCopyWithImpl<FnCall_PageGetByIndex>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FnCall_PageGetByIndex&&(identical(other.field0, field0) || other.field0 == field0));
}


@override
int get hashCode => Object.hash(runtimeType,field0);

@override
String toString() {
  return 'FnCall.pageGetByIndex(field0: $field0)';
}


}

/// @nodoc
abstract mixin class $FnCall_PageGetByIndexCopyWith<$Res> implements $FnCallCopyWith<$Res> {
  factory $FnCall_PageGetByIndexCopyWith(FnCall_PageGetByIndex value, $Res Function(FnCall_PageGetByIndex) _then) = _$FnCall_PageGetByIndexCopyWithImpl;
@useResult
$Res call({
 FnCallPageGetByIndex field0
});




}
/// @nodoc
class _$FnCall_PageGetByIndexCopyWithImpl<$Res>
    implements $FnCall_PageGetByIndexCopyWith<$Res> {
  _$FnCall_PageGetByIndexCopyWithImpl(this._self, this._then);

  final FnCall_PageGetByIndex _self;
  final $Res Function(FnCall_PageGetByIndex) _then;

/// Create a copy of FnCall
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? field0 = null,}) {
  return _then(FnCall_PageGetByIndex(
null == field0 ? _self.field0 : field0 // ignore: cast_nullable_to_non_nullable
as FnCallPageGetByIndex,
  ));
}


}

/// @nodoc


class FnCall_PageGetCount extends FnCall {
  const FnCall_PageGetCount(this.field0): super._();
  

@override final  FnCallPageGetCount field0;

/// Create a copy of FnCall
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FnCall_PageGetCountCopyWith<FnCall_PageGetCount> get copyWith => _$FnCall_PageGetCountCopyWithImpl<FnCall_PageGetCount>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FnCall_PageGetCount&&(identical(other.field0, field0) || other.field0 == field0));
}


@override
int get hashCode => Object.hash(runtimeType,field0);

@override
String toString() {
  return 'FnCall.pageGetCount(field0: $field0)';
}


}

/// @nodoc
abstract mixin class $FnCall_PageGetCountCopyWith<$Res> implements $FnCallCopyWith<$Res> {
  factory $FnCall_PageGetCountCopyWith(FnCall_PageGetCount value, $Res Function(FnCall_PageGetCount) _then) = _$FnCall_PageGetCountCopyWithImpl;
@useResult
$Res call({
 FnCallPageGetCount field0
});




}
/// @nodoc
class _$FnCall_PageGetCountCopyWithImpl<$Res>
    implements $FnCall_PageGetCountCopyWith<$Res> {
  _$FnCall_PageGetCountCopyWithImpl(this._self, this._then);

  final FnCall_PageGetCount _self;
  final $Res Function(FnCall_PageGetCount) _then;

/// Create a copy of FnCall
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? field0 = null,}) {
  return _then(FnCall_PageGetCount(
null == field0 ? _self.field0 : field0 // ignore: cast_nullable_to_non_nullable
as FnCallPageGetCount,
  ));
}


}

/// @nodoc


class FnCall_PageWaitForNavigation extends FnCall {
  const FnCall_PageWaitForNavigation(this.field0): super._();
  

@override final  FnCallPageWaitForNavigation field0;

/// Create a copy of FnCall
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FnCall_PageWaitForNavigationCopyWith<FnCall_PageWaitForNavigation> get copyWith => _$FnCall_PageWaitForNavigationCopyWithImpl<FnCall_PageWaitForNavigation>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FnCall_PageWaitForNavigation&&(identical(other.field0, field0) || other.field0 == field0));
}


@override
int get hashCode => Object.hash(runtimeType,field0);

@override
String toString() {
  return 'FnCall.pageWaitForNavigation(field0: $field0)';
}


}

/// @nodoc
abstract mixin class $FnCall_PageWaitForNavigationCopyWith<$Res> implements $FnCallCopyWith<$Res> {
  factory $FnCall_PageWaitForNavigationCopyWith(FnCall_PageWaitForNavigation value, $Res Function(FnCall_PageWaitForNavigation) _then) = _$FnCall_PageWaitForNavigationCopyWithImpl;
@useResult
$Res call({
 FnCallPageWaitForNavigation field0
});




}
/// @nodoc
class _$FnCall_PageWaitForNavigationCopyWithImpl<$Res>
    implements $FnCall_PageWaitForNavigationCopyWith<$Res> {
  _$FnCall_PageWaitForNavigationCopyWithImpl(this._self, this._then);

  final FnCall_PageWaitForNavigation _self;
  final $Res Function(FnCall_PageWaitForNavigation) _then;

/// Create a copy of FnCall
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? field0 = null,}) {
  return _then(FnCall_PageWaitForNavigation(
null == field0 ? _self.field0 : field0 // ignore: cast_nullable_to_non_nullable
as FnCallPageWaitForNavigation,
  ));
}


}

/// @nodoc


class FnCall_PageClose extends FnCall {
  const FnCall_PageClose(this.field0): super._();
  

@override final  FnCallPageClose field0;

/// Create a copy of FnCall
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FnCall_PageCloseCopyWith<FnCall_PageClose> get copyWith => _$FnCall_PageCloseCopyWithImpl<FnCall_PageClose>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FnCall_PageClose&&(identical(other.field0, field0) || other.field0 == field0));
}


@override
int get hashCode => Object.hash(runtimeType,field0);

@override
String toString() {
  return 'FnCall.pageClose(field0: $field0)';
}


}

/// @nodoc
abstract mixin class $FnCall_PageCloseCopyWith<$Res> implements $FnCallCopyWith<$Res> {
  factory $FnCall_PageCloseCopyWith(FnCall_PageClose value, $Res Function(FnCall_PageClose) _then) = _$FnCall_PageCloseCopyWithImpl;
@useResult
$Res call({
 FnCallPageClose field0
});




}
/// @nodoc
class _$FnCall_PageCloseCopyWithImpl<$Res>
    implements $FnCall_PageCloseCopyWith<$Res> {
  _$FnCall_PageCloseCopyWithImpl(this._self, this._then);

  final FnCall_PageClose _self;
  final $Res Function(FnCall_PageClose) _then;

/// Create a copy of FnCall
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? field0 = null,}) {
  return _then(FnCall_PageClose(
null == field0 ? _self.field0 : field0 // ignore: cast_nullable_to_non_nullable
as FnCallPageClose,
  ));
}


}

/// @nodoc


class FnCall_PageFindElement extends FnCall {
  const FnCall_PageFindElement(this.field0): super._();
  

@override final  FnCallPageFindElement field0;

/// Create a copy of FnCall
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FnCall_PageFindElementCopyWith<FnCall_PageFindElement> get copyWith => _$FnCall_PageFindElementCopyWithImpl<FnCall_PageFindElement>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FnCall_PageFindElement&&(identical(other.field0, field0) || other.field0 == field0));
}


@override
int get hashCode => Object.hash(runtimeType,field0);

@override
String toString() {
  return 'FnCall.pageFindElement(field0: $field0)';
}


}

/// @nodoc
abstract mixin class $FnCall_PageFindElementCopyWith<$Res> implements $FnCallCopyWith<$Res> {
  factory $FnCall_PageFindElementCopyWith(FnCall_PageFindElement value, $Res Function(FnCall_PageFindElement) _then) = _$FnCall_PageFindElementCopyWithImpl;
@useResult
$Res call({
 FnCallPageFindElement field0
});




}
/// @nodoc
class _$FnCall_PageFindElementCopyWithImpl<$Res>
    implements $FnCall_PageFindElementCopyWith<$Res> {
  _$FnCall_PageFindElementCopyWithImpl(this._self, this._then);

  final FnCall_PageFindElement _self;
  final $Res Function(FnCall_PageFindElement) _then;

/// Create a copy of FnCall
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? field0 = null,}) {
  return _then(FnCall_PageFindElement(
null == field0 ? _self.field0 : field0 // ignore: cast_nullable_to_non_nullable
as FnCallPageFindElement,
  ));
}


}

/// @nodoc


class FnCall_ElementGetOuterHtml extends FnCall {
  const FnCall_ElementGetOuterHtml(this.field0): super._();
  

@override final  FnCallElementGetOuterHtml field0;

/// Create a copy of FnCall
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FnCall_ElementGetOuterHtmlCopyWith<FnCall_ElementGetOuterHtml> get copyWith => _$FnCall_ElementGetOuterHtmlCopyWithImpl<FnCall_ElementGetOuterHtml>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FnCall_ElementGetOuterHtml&&(identical(other.field0, field0) || other.field0 == field0));
}


@override
int get hashCode => Object.hash(runtimeType,field0);

@override
String toString() {
  return 'FnCall.elementGetOuterHtml(field0: $field0)';
}


}

/// @nodoc
abstract mixin class $FnCall_ElementGetOuterHtmlCopyWith<$Res> implements $FnCallCopyWith<$Res> {
  factory $FnCall_ElementGetOuterHtmlCopyWith(FnCall_ElementGetOuterHtml value, $Res Function(FnCall_ElementGetOuterHtml) _then) = _$FnCall_ElementGetOuterHtmlCopyWithImpl;
@useResult
$Res call({
 FnCallElementGetOuterHtml field0
});




}
/// @nodoc
class _$FnCall_ElementGetOuterHtmlCopyWithImpl<$Res>
    implements $FnCall_ElementGetOuterHtmlCopyWith<$Res> {
  _$FnCall_ElementGetOuterHtmlCopyWithImpl(this._self, this._then);

  final FnCall_ElementGetOuterHtml _self;
  final $Res Function(FnCall_ElementGetOuterHtml) _then;

/// Create a copy of FnCall
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? field0 = null,}) {
  return _then(FnCall_ElementGetOuterHtml(
null == field0 ? _self.field0 : field0 // ignore: cast_nullable_to_non_nullable
as FnCallElementGetOuterHtml,
  ));
}


}

/// @nodoc


class FnCall_ElementGetInnerHtml extends FnCall {
  const FnCall_ElementGetInnerHtml(this.field0): super._();
  

@override final  FnCallElementGetInnerHtml field0;

/// Create a copy of FnCall
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FnCall_ElementGetInnerHtmlCopyWith<FnCall_ElementGetInnerHtml> get copyWith => _$FnCall_ElementGetInnerHtmlCopyWithImpl<FnCall_ElementGetInnerHtml>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FnCall_ElementGetInnerHtml&&(identical(other.field0, field0) || other.field0 == field0));
}


@override
int get hashCode => Object.hash(runtimeType,field0);

@override
String toString() {
  return 'FnCall.elementGetInnerHtml(field0: $field0)';
}


}

/// @nodoc
abstract mixin class $FnCall_ElementGetInnerHtmlCopyWith<$Res> implements $FnCallCopyWith<$Res> {
  factory $FnCall_ElementGetInnerHtmlCopyWith(FnCall_ElementGetInnerHtml value, $Res Function(FnCall_ElementGetInnerHtml) _then) = _$FnCall_ElementGetInnerHtmlCopyWithImpl;
@useResult
$Res call({
 FnCallElementGetInnerHtml field0
});




}
/// @nodoc
class _$FnCall_ElementGetInnerHtmlCopyWithImpl<$Res>
    implements $FnCall_ElementGetInnerHtmlCopyWith<$Res> {
  _$FnCall_ElementGetInnerHtmlCopyWithImpl(this._self, this._then);

  final FnCall_ElementGetInnerHtml _self;
  final $Res Function(FnCall_ElementGetInnerHtml) _then;

/// Create a copy of FnCall
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? field0 = null,}) {
  return _then(FnCall_ElementGetInnerHtml(
null == field0 ? _self.field0 : field0 // ignore: cast_nullable_to_non_nullable
as FnCallElementGetInnerHtml,
  ));
}


}

/// @nodoc


class FnCall_ElementGetText extends FnCall {
  const FnCall_ElementGetText(this.field0): super._();
  

@override final  FnCallElementGetText field0;

/// Create a copy of FnCall
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FnCall_ElementGetTextCopyWith<FnCall_ElementGetText> get copyWith => _$FnCall_ElementGetTextCopyWithImpl<FnCall_ElementGetText>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FnCall_ElementGetText&&(identical(other.field0, field0) || other.field0 == field0));
}


@override
int get hashCode => Object.hash(runtimeType,field0);

@override
String toString() {
  return 'FnCall.elementGetText(field0: $field0)';
}


}

/// @nodoc
abstract mixin class $FnCall_ElementGetTextCopyWith<$Res> implements $FnCallCopyWith<$Res> {
  factory $FnCall_ElementGetTextCopyWith(FnCall_ElementGetText value, $Res Function(FnCall_ElementGetText) _then) = _$FnCall_ElementGetTextCopyWithImpl;
@useResult
$Res call({
 FnCallElementGetText field0
});




}
/// @nodoc
class _$FnCall_ElementGetTextCopyWithImpl<$Res>
    implements $FnCall_ElementGetTextCopyWith<$Res> {
  _$FnCall_ElementGetTextCopyWithImpl(this._self, this._then);

  final FnCall_ElementGetText _self;
  final $Res Function(FnCall_ElementGetText) _then;

/// Create a copy of FnCall
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? field0 = null,}) {
  return _then(FnCall_ElementGetText(
null == field0 ? _self.field0 : field0 // ignore: cast_nullable_to_non_nullable
as FnCallElementGetText,
  ));
}


}

/// @nodoc


class FnCall_ElementType extends FnCall {
  const FnCall_ElementType(this.field0): super._();
  

@override final  FnCallElementType field0;

/// Create a copy of FnCall
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FnCall_ElementTypeCopyWith<FnCall_ElementType> get copyWith => _$FnCall_ElementTypeCopyWithImpl<FnCall_ElementType>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FnCall_ElementType&&(identical(other.field0, field0) || other.field0 == field0));
}


@override
int get hashCode => Object.hash(runtimeType,field0);

@override
String toString() {
  return 'FnCall.elementType(field0: $field0)';
}


}

/// @nodoc
abstract mixin class $FnCall_ElementTypeCopyWith<$Res> implements $FnCallCopyWith<$Res> {
  factory $FnCall_ElementTypeCopyWith(FnCall_ElementType value, $Res Function(FnCall_ElementType) _then) = _$FnCall_ElementTypeCopyWithImpl;
@useResult
$Res call({
 FnCallElementType field0
});




}
/// @nodoc
class _$FnCall_ElementTypeCopyWithImpl<$Res>
    implements $FnCall_ElementTypeCopyWith<$Res> {
  _$FnCall_ElementTypeCopyWithImpl(this._self, this._then);

  final FnCall_ElementType _self;
  final $Res Function(FnCall_ElementType) _then;

/// Create a copy of FnCall
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? field0 = null,}) {
  return _then(FnCall_ElementType(
null == field0 ? _self.field0 : field0 // ignore: cast_nullable_to_non_nullable
as FnCallElementType,
  ));
}


}

/// @nodoc


class FnCall_ElementClick extends FnCall {
  const FnCall_ElementClick(this.field0): super._();
  

@override final  FnCallElementClick field0;

/// Create a copy of FnCall
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FnCall_ElementClickCopyWith<FnCall_ElementClick> get copyWith => _$FnCall_ElementClickCopyWithImpl<FnCall_ElementClick>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FnCall_ElementClick&&(identical(other.field0, field0) || other.field0 == field0));
}


@override
int get hashCode => Object.hash(runtimeType,field0);

@override
String toString() {
  return 'FnCall.elementClick(field0: $field0)';
}


}

/// @nodoc
abstract mixin class $FnCall_ElementClickCopyWith<$Res> implements $FnCallCopyWith<$Res> {
  factory $FnCall_ElementClickCopyWith(FnCall_ElementClick value, $Res Function(FnCall_ElementClick) _then) = _$FnCall_ElementClickCopyWithImpl;
@useResult
$Res call({
 FnCallElementClick field0
});




}
/// @nodoc
class _$FnCall_ElementClickCopyWithImpl<$Res>
    implements $FnCall_ElementClickCopyWith<$Res> {
  _$FnCall_ElementClickCopyWithImpl(this._self, this._then);

  final FnCall_ElementClick _self;
  final $Res Function(FnCall_ElementClick) _then;

/// Create a copy of FnCall
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? field0 = null,}) {
  return _then(FnCall_ElementClick(
null == field0 ? _self.field0 : field0 // ignore: cast_nullable_to_non_nullable
as FnCallElementClick,
  ));
}


}

/// @nodoc


class FnCall_CsvNew extends FnCall {
  const FnCall_CsvNew(this.field0): super._();
  

@override final  FnCallCsvNew field0;

/// Create a copy of FnCall
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FnCall_CsvNewCopyWith<FnCall_CsvNew> get copyWith => _$FnCall_CsvNewCopyWithImpl<FnCall_CsvNew>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FnCall_CsvNew&&(identical(other.field0, field0) || other.field0 == field0));
}


@override
int get hashCode => Object.hash(runtimeType,field0);

@override
String toString() {
  return 'FnCall.csvNew(field0: $field0)';
}


}

/// @nodoc
abstract mixin class $FnCall_CsvNewCopyWith<$Res> implements $FnCallCopyWith<$Res> {
  factory $FnCall_CsvNewCopyWith(FnCall_CsvNew value, $Res Function(FnCall_CsvNew) _then) = _$FnCall_CsvNewCopyWithImpl;
@useResult
$Res call({
 FnCallCsvNew field0
});




}
/// @nodoc
class _$FnCall_CsvNewCopyWithImpl<$Res>
    implements $FnCall_CsvNewCopyWith<$Res> {
  _$FnCall_CsvNewCopyWithImpl(this._self, this._then);

  final FnCall_CsvNew _self;
  final $Res Function(FnCall_CsvNew) _then;

/// Create a copy of FnCall
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? field0 = null,}) {
  return _then(FnCall_CsvNew(
null == field0 ? _self.field0 : field0 // ignore: cast_nullable_to_non_nullable
as FnCallCsvNew,
  ));
}


}

/// @nodoc


class FnCall_CsvLoad extends FnCall {
  const FnCall_CsvLoad(this.field0): super._();
  

@override final  FnCallCsvLoad field0;

/// Create a copy of FnCall
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FnCall_CsvLoadCopyWith<FnCall_CsvLoad> get copyWith => _$FnCall_CsvLoadCopyWithImpl<FnCall_CsvLoad>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FnCall_CsvLoad&&(identical(other.field0, field0) || other.field0 == field0));
}


@override
int get hashCode => Object.hash(runtimeType,field0);

@override
String toString() {
  return 'FnCall.csvLoad(field0: $field0)';
}


}

/// @nodoc
abstract mixin class $FnCall_CsvLoadCopyWith<$Res> implements $FnCallCopyWith<$Res> {
  factory $FnCall_CsvLoadCopyWith(FnCall_CsvLoad value, $Res Function(FnCall_CsvLoad) _then) = _$FnCall_CsvLoadCopyWithImpl;
@useResult
$Res call({
 FnCallCsvLoad field0
});




}
/// @nodoc
class _$FnCall_CsvLoadCopyWithImpl<$Res>
    implements $FnCall_CsvLoadCopyWith<$Res> {
  _$FnCall_CsvLoadCopyWithImpl(this._self, this._then);

  final FnCall_CsvLoad _self;
  final $Res Function(FnCall_CsvLoad) _then;

/// Create a copy of FnCall
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? field0 = null,}) {
  return _then(FnCall_CsvLoad(
null == field0 ? _self.field0 : field0 // ignore: cast_nullable_to_non_nullable
as FnCallCsvLoad,
  ));
}


}

/// @nodoc


class FnCall_CsvSave extends FnCall {
  const FnCall_CsvSave(this.field0): super._();
  

@override final  FnCallCsvSave field0;

/// Create a copy of FnCall
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FnCall_CsvSaveCopyWith<FnCall_CsvSave> get copyWith => _$FnCall_CsvSaveCopyWithImpl<FnCall_CsvSave>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FnCall_CsvSave&&(identical(other.field0, field0) || other.field0 == field0));
}


@override
int get hashCode => Object.hash(runtimeType,field0);

@override
String toString() {
  return 'FnCall.csvSave(field0: $field0)';
}


}

/// @nodoc
abstract mixin class $FnCall_CsvSaveCopyWith<$Res> implements $FnCallCopyWith<$Res> {
  factory $FnCall_CsvSaveCopyWith(FnCall_CsvSave value, $Res Function(FnCall_CsvSave) _then) = _$FnCall_CsvSaveCopyWithImpl;
@useResult
$Res call({
 FnCallCsvSave field0
});




}
/// @nodoc
class _$FnCall_CsvSaveCopyWithImpl<$Res>
    implements $FnCall_CsvSaveCopyWith<$Res> {
  _$FnCall_CsvSaveCopyWithImpl(this._self, this._then);

  final FnCall_CsvSave _self;
  final $Res Function(FnCall_CsvSave) _then;

/// Create a copy of FnCall
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? field0 = null,}) {
  return _then(FnCall_CsvSave(
null == field0 ? _self.field0 : field0 // ignore: cast_nullable_to_non_nullable
as FnCallCsvSave,
  ));
}


}

/// @nodoc


class FnCall_CsvGet extends FnCall {
  const FnCall_CsvGet(this.field0): super._();
  

@override final  FnCallCsvGet field0;

/// Create a copy of FnCall
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FnCall_CsvGetCopyWith<FnCall_CsvGet> get copyWith => _$FnCall_CsvGetCopyWithImpl<FnCall_CsvGet>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FnCall_CsvGet&&(identical(other.field0, field0) || other.field0 == field0));
}


@override
int get hashCode => Object.hash(runtimeType,field0);

@override
String toString() {
  return 'FnCall.csvGet(field0: $field0)';
}


}

/// @nodoc
abstract mixin class $FnCall_CsvGetCopyWith<$Res> implements $FnCallCopyWith<$Res> {
  factory $FnCall_CsvGetCopyWith(FnCall_CsvGet value, $Res Function(FnCall_CsvGet) _then) = _$FnCall_CsvGetCopyWithImpl;
@useResult
$Res call({
 FnCallCsvGet field0
});




}
/// @nodoc
class _$FnCall_CsvGetCopyWithImpl<$Res>
    implements $FnCall_CsvGetCopyWith<$Res> {
  _$FnCall_CsvGetCopyWithImpl(this._self, this._then);

  final FnCall_CsvGet _self;
  final $Res Function(FnCall_CsvGet) _then;

/// Create a copy of FnCall
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? field0 = null,}) {
  return _then(FnCall_CsvGet(
null == field0 ? _self.field0 : field0 // ignore: cast_nullable_to_non_nullable
as FnCallCsvGet,
  ));
}


}

/// @nodoc


class FnCall_CsvSet extends FnCall {
  const FnCall_CsvSet(this.field0): super._();
  

@override final  FnCallCsvSet field0;

/// Create a copy of FnCall
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FnCall_CsvSetCopyWith<FnCall_CsvSet> get copyWith => _$FnCall_CsvSetCopyWithImpl<FnCall_CsvSet>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FnCall_CsvSet&&(identical(other.field0, field0) || other.field0 == field0));
}


@override
int get hashCode => Object.hash(runtimeType,field0);

@override
String toString() {
  return 'FnCall.csvSet(field0: $field0)';
}


}

/// @nodoc
abstract mixin class $FnCall_CsvSetCopyWith<$Res> implements $FnCallCopyWith<$Res> {
  factory $FnCall_CsvSetCopyWith(FnCall_CsvSet value, $Res Function(FnCall_CsvSet) _then) = _$FnCall_CsvSetCopyWithImpl;
@useResult
$Res call({
 FnCallCsvSet field0
});




}
/// @nodoc
class _$FnCall_CsvSetCopyWithImpl<$Res>
    implements $FnCall_CsvSetCopyWith<$Res> {
  _$FnCall_CsvSetCopyWithImpl(this._self, this._then);

  final FnCall_CsvSet _self;
  final $Res Function(FnCall_CsvSet) _then;

/// Create a copy of FnCall
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? field0 = null,}) {
  return _then(FnCall_CsvSet(
null == field0 ? _self.field0 : field0 // ignore: cast_nullable_to_non_nullable
as FnCallCsvSet,
  ));
}


}

/// @nodoc


class FnCall_CsvRowCount extends FnCall {
  const FnCall_CsvRowCount(this.field0): super._();
  

@override final  FnCallCsvRowCount field0;

/// Create a copy of FnCall
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FnCall_CsvRowCountCopyWith<FnCall_CsvRowCount> get copyWith => _$FnCall_CsvRowCountCopyWithImpl<FnCall_CsvRowCount>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FnCall_CsvRowCount&&(identical(other.field0, field0) || other.field0 == field0));
}


@override
int get hashCode => Object.hash(runtimeType,field0);

@override
String toString() {
  return 'FnCall.csvRowCount(field0: $field0)';
}


}

/// @nodoc
abstract mixin class $FnCall_CsvRowCountCopyWith<$Res> implements $FnCallCopyWith<$Res> {
  factory $FnCall_CsvRowCountCopyWith(FnCall_CsvRowCount value, $Res Function(FnCall_CsvRowCount) _then) = _$FnCall_CsvRowCountCopyWithImpl;
@useResult
$Res call({
 FnCallCsvRowCount field0
});




}
/// @nodoc
class _$FnCall_CsvRowCountCopyWithImpl<$Res>
    implements $FnCall_CsvRowCountCopyWith<$Res> {
  _$FnCall_CsvRowCountCopyWithImpl(this._self, this._then);

  final FnCall_CsvRowCount _self;
  final $Res Function(FnCall_CsvRowCount) _then;

/// Create a copy of FnCall
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? field0 = null,}) {
  return _then(FnCall_CsvRowCount(
null == field0 ? _self.field0 : field0 // ignore: cast_nullable_to_non_nullable
as FnCallCsvRowCount,
  ));
}


}

// dart format on
