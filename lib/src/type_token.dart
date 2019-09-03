class TypeToken {
  String _typeName;

  TypeToken.parse(Object obj) : this.of(obj == null ? dynamic : obj.runtimeType);

  TypeToken.ofName(this._typeName);

  TypeToken.of(Type type) : this.ofName(type == null ? dynamic.toString() : type.toString());

  TypeToken.ofDynamic() : this.of(dynamic);

  TypeToken.ofInt() : this.of(int);

  TypeToken.ofString() : this.of(String);

  TypeToken.ofDouble() : this.of(double);

  TypeToken.ofBool() : this.of(bool);

  static TypeToken ofListByToken(TypeToken componentType) {
    return TypeToken.ofName('List<${componentType.typeName}>');
  }

  static TypeToken ofMapByToken(TypeToken keyType, TypeToken valueType) {
    return TypeToken.ofName('Map<${keyType.typeName}, ${valueType.typeName}>');
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

  bool get isList => RegExp('List(<.+>)?').hasMatch(typeName);

  bool get isMap => RegExp('Map(<.+, .+>)?').hasMatch(typeName);
}

bool isPrimitive(Type type) => TypeToken.of(type).isPrimitive;

bool isInt(Type type) => TypeToken.of(type).isInt;

bool isDouble(Type type) => TypeToken.of(type).isDouble;

bool isBool(Type type) => TypeToken.of(type).isBool;

bool isString(Type type) => TypeToken.of(type).isString;

bool isList(Type type) => TypeToken.of(type).isList;

bool isMap(Type type) => TypeToken.of(type).isMap;
