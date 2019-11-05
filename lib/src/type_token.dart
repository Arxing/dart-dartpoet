class TypeToken {
  String _typeName;
  List<TypeToken> _generics = [];

  TypeToken.ofName(this._typeName, [List<TypeToken> generics = const []]) {
    _generics.addAll(generics);
  }

  TypeToken.ofName2(String typeName, [List<Type> generics = const []])
      : this.ofName(typeName, generics.map((o) => TypeToken.of(o)).toList());

  factory TypeToken.ofFullName(String fullTypeName) {
    String typeName = resolveTypeName(fullTypeName);
    List<TypeToken> generics = resolveGenerics(fullTypeName).toList();
    return TypeToken.ofName(typeName, generics);
  }

  factory TypeToken.parse(Object obj) => TypeToken.of(obj?.runtimeType);

  factory TypeToken.of(Type type) => TypeToken.ofFullName(type.toString());

  factory TypeToken.ofDynamic() => TypeToken.of(dynamic);

  factory TypeToken.ofInt() => TypeToken.of(int);

  factory TypeToken.ofString() => TypeToken.of(String);

  factory TypeToken.ofDouble() => TypeToken.of(double);

  factory TypeToken.ofBool() => TypeToken.of(bool);

  static TypeToken ofListByToken(TypeToken componentType) {
    return TypeToken.ofName('List', [componentType]);
  }

  static TypeToken ofListByType(Type componentType) {
    return TypeToken.ofListByToken(TypeToken.of(componentType));
  }

  static TypeToken ofMapByToken(TypeToken keyType, TypeToken valueType) {
    return TypeToken.ofName('Map', [keyType, valueType]);
  }

  static TypeToken ofMapByType(Type keyType, Type valueType) {
    return TypeToken.ofMapByToken(TypeToken.of(keyType), TypeToken.of(valueType));
  }

  static TypeToken ofList<T>() {
    return ofListByToken(TypeToken.of(T));
  }

  static TypeToken ofMap<K, V>() {
    return ofMapByToken(TypeToken.of(K), TypeToken.of(V));
  }

  String get typeName => _typeName;

  bool get isPrimitive => ['int', 'double', 'bool', 'String'].contains(typeName);

  bool get isNotPrimitive => !isPrimitive;

  bool get isInt => typeName == 'int';

  bool get isDouble => typeName == 'double';

  bool get isBool => typeName == 'bool';

  bool get isString => typeName == 'String';

  bool get isList => typeName == "List";

  bool get isMap => typeName == "Map";

  bool get isDynamic => typeName == "dynamic";

  List<TypeToken> get generics => _generics;

  TypeToken get firstGeneric => generics.first;

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is TypeToken && runtimeType == other.runtimeType && _typeName == other._typeName;

  @override
  int get hashCode => _typeName.hashCode;

  @override
  String toString() {
    return typeName + (generics.isNotEmpty ? "<${generics.join(", ")}>" : "");
  }
}

bool isPrimitive(Type type) => TypeToken.of(type).isPrimitive;

bool isInt(Type type) => TypeToken.of(type).isInt;

bool isDouble(Type type) => TypeToken.of(type).isDouble;

bool isBool(Type type) => TypeToken.of(type).isBool;

bool isString(Type type) => TypeToken.of(type).isString;

bool isList(Type type) => TypeToken.of(type).isList;

bool isMap(Type type) => TypeToken.of(type).isMap;

String resolveTypeName(String fullTypeName) {
  var regex = RegExp("([a-zA-Z0-9\$_]+)(<((.+))>)?");
  return regex.firstMatch(fullTypeName).group(1);
}

Iterable<TypeToken> resolveGenerics(String fullTypeName) sync* {
  String fullGeneric = _getGenericsString(fullTypeName);
  List<String> genericStrings = _splitGenerics(fullGeneric).toList();
  for (var genericString in genericStrings) {
    String childGenericString = _getGenericsString(genericString);
    if (childGenericString == null) {
      yield TypeToken.ofName(genericString);
    } else {
      yield TypeToken.ofName(resolveTypeName(genericString), resolveGenerics(genericString).toList());
    }
  }
}

String _getGenericsString(String typeName) {
  var regex = RegExp("[a-zA-Z0-9\$_]+<((.+))>");
  if (regex.hasMatch(typeName)) {
    return regex.firstMatch(typeName).group(1);
  } else {
    return null;
  }
}

Iterable<String> _splitGenerics(String genericsString) sync* {
  if (genericsString == null) {
    yield* [];
  } else {
    genericsString = genericsString.replaceAll(" ", "");
    String tmp = "";
    for (var idx = 0; idx < genericsString.length; idx++) {
      String s = genericsString[idx];
      if (s == ",") {
        yield tmp;
        tmp = "";
      } else {
        tmp += s;
      }
    }
    yield tmp;
  }
}
