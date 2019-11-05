import 'package:dartpoet/dartpoet.dart';

class ParameterSpec<T> implements Spec {
  TypeToken type;
  String parameterName;
  ParameterMode parameterMode;
  T defaultValue;
  List<MetaSpec> metas = [];
  bool isSelfParameter = false;
  bool isValue = false;
  dynamic value;
  bool valueString = true;

  ParameterSpec.build(
    this.parameterName, {
    this.type,
    this.metas,
    this.parameterMode = ParameterMode.normal,
    this.defaultValue,
    this.isSelfParameter = false,
    this.isValue,
    this.value,
    this.valueString,
  }) {
    if (metas == null) metas = [];
    this.isValue = isValue ?? false;
    this.valueString = valueString ?? true;
  }

  ParameterSpec.normal(
    String parameterName, {
    bool isSelfParameter = false,
    TypeToken type,
    List<MetaSpec> metas,
    bool isValue,
    dynamic value,
    bool valueString,
  }) : this.build(
          parameterName,
          type: type,
          parameterMode: ParameterMode.normal,
          metas: metas,
          isSelfParameter: isSelfParameter,
          isValue: isValue,
          value: value,
          valueString: valueString,
        );

  ParameterSpec.named(
    String parameterName, {
    bool isSelfParameter = false,
    TypeToken type,
    T defaultValue,
    List<MetaSpec> metas,
    bool isValue,
    dynamic value,
    bool valueString,
  }) : this.build(
          parameterName,
          type: type,
          defaultValue: defaultValue,
          parameterMode: ParameterMode.named,
          metas: metas,
          isSelfParameter: isSelfParameter,
          isValue: isValue,
          value: value,
          valueString: valueString,
        );

  ParameterSpec.indexed(
    String parameterName, {
    bool isSelfParameter = false,
    TypeToken type,
    T defaultValue,
    List<MetaSpec> metas,
    bool isValue,
    dynamic value,
    bool valueString,
  }) : this.build(
          parameterName,
          type: type,
          defaultValue: defaultValue,
          parameterMode: ParameterMode.indexed,
          metas: metas,
          isSelfParameter: isSelfParameter,
          isValue: isValue,
          value: value,
          valueString: valueString,
        );

  String _getType() {
    return type == null ? 'dynamic' : type.fullTypeName;
  }

  String _valueString(dynamic v) => v is String && valueString ? '"$v"' : "$v";

  @override
  String code({Map<String, dynamic> args = const {}}) {
    String raw;
    if (isValue) {
      raw = parameterMode == ParameterMode.named ? "$parameterName: ${_valueString(value)}" : "${_valueString(value)}";
    } else {
      bool withDefValue = args[KEY_WITH_DEF_VALUE] ?? false;
      raw = isSelfParameter ? 'this.$parameterName' : '${_getType()} $parameterName';
      if (withDefValue && defaultValue != null) raw += '=$defaultValue';
    }
    return raw;
  }
}

String collectParameters(List<ParameterSpec> parameters) {
  if (parameters == null || parameters.isEmpty) return '';
  var normalList = parameters.where((o) => o.parameterMode == ParameterMode.normal);
  var namedList = parameters.where((o) => o.parameterMode == ParameterMode.named);
  var indexedList = parameters.where((o) => o.parameterMode == ParameterMode.indexed);
  List<String> paramsList = [];
  if (normalList.isNotEmpty) paramsList.add(normalList.map((o) => o.code()).join(", "));
  if (namedList.isNotEmpty) paramsList.add('{' + namedList.map((o) => o.code(args: {KEY_WITH_DEF_VALUE: true})).join(", ") + '}');
  if (indexedList.isNotEmpty) paramsList.add('[' + indexedList.map((o) => o.code(args: {KEY_WITH_DEF_VALUE: true})).join(", ") + ']');
  return paramsList.join(", ");
}

enum ParameterMode { normal, indexed, named }
