class SpecKind {
  final int _value;
  final String _name;

  const SpecKind._(this._value, this._name);

  factory SpecKind(int value) {
    return values.firstWhere((o) => o.value == value, orElse: () => null);
  }

  int get value => _value;

  String get name => _name;

  static List<SpecKind> get values => [
    CLASS,
    CODE_BLOCK,
    DOC,
    FILE,
    META,
    METHOD,
    OPERATOR,
    PARAMETER,
    PROPERTY,
    SETTER,
    GETTER,
    CONSTRUCTOR,
    DEPENDENCY,
  ];

  static List<String> get names => [
    CLASS.name,
    CODE_BLOCK.name,
    DOC.name,
    FILE.name,
    META.name,
    METHOD.name,
    OPERATOR.name,
    PARAMETER.name,
    PROPERTY.name,
    SETTER.name,
    GETTER.name,
    CONSTRUCTOR.name,
    DEPENDENCY.name,
  ];

  ///
  static const CLASS = SpecKind._(_CLASS, 'CLASS');
  static const int _CLASS = 1;

  ///
  static const CODE_BLOCK = SpecKind._(_CODE_BLOCK, 'CODE_BLOCK');
  static const int _CODE_BLOCK = 2;

  ///
  static const DOC = SpecKind._(_DOC, 'DOC');
  static const int _DOC = 3;

  ///
  static const FILE = SpecKind._(_FILE, 'FILE');
  static const int _FILE = 4;

  ///
  static const META = SpecKind._(_META, 'META');
  static const int _META = 5;

  ///
  static const METHOD = SpecKind._(_METHOD, 'METHOD');
  static const int _METHOD = 6;

  ///
  static const OPERATOR = SpecKind._(_OPERATOR, 'OPERATOR');
  static const int _OPERATOR = 7;

  ///
  static const PARAMETER = SpecKind._(_PARAMETER, 'PARAMETER');
  static const int _PARAMETER = 8;

  ///
  static const PROPERTY = SpecKind._(_PROPERTY, 'PROPERTY');
  static const int _PROPERTY = 9;

  ///
  static const SETTER = SpecKind._(_SETTER, 'SETTER');
  static const int _SETTER = 10;

  ///
  static const GETTER = SpecKind._(_GETTER, 'GETTER');
  static const int _GETTER = 11;

  ///
  static const CONSTRUCTOR = SpecKind._(_CONSTRUCTOR, 'CONSTRUCTOR');
  static const int _CONSTRUCTOR = 12;

  ///
  static const DEPENDENCY = SpecKind._(_DEPENDENCY, 'DEPENDENCY');
  static const int _DEPENDENCY = 13;
}