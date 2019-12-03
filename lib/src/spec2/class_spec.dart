part of 'spec.dart';

class ClassSpec extends Spec {
  DocumentSpec get doc => _childrenWhereType<DocumentSpec>().single;

  List<AnnotationSpec> get metas => _childrenWhereType<AnnotationSpec>();

  List<MethodSpec> get methods => _childrenWhereType<MethodSpec>();

  List<ConstructorSpec> get constructors => _childrenWhereType<ConstructorSpec>();

  List<PropertySpec> get properties => _childrenWhereType<PropertySpec>();

  List<OperatorSpec> get operatorMethods => _childrenWhereType<OperatorSpec>();

  String className;

  TypeToken superClass;

  List<TypeToken> implementClasses = [];

  List<TypeToken> mixinClasses = [];

  List<TypeToken> generics = [];

  bool get hasGeneric => generics.isNotEmpty;

  @override
  SpecKind get kind => SpecKind.CLASS;

  @override
  List<SpecKind> get supportedChildKinds => [
        SpecKind.META,
        SpecKind.GETTER,
        SpecKind.SETTER,
        SpecKind.METHOD,
        SpecKind.CONSTRUCTOR,
        SpecKind.PROPERTY,
        SpecKind.OPERATOR
      ];

  bool isAbstract;

  bool isMixin;

  ClassSpec._build(
    this.className, {
    DocumentSpec doc,
    List<AnnotationSpec> metas,
    List<PropertySpec> properties,
    List<GetterSpec> getters,
    List<SetterSpec> setters,
    List<MethodSpec> methods,
    List<OperatorSpec> operatorMethods,
    this.superClass,
    this.implementClasses,
    this.mixinClasses,
    this.generics,
    this.isAbstract,
    this.isMixin,
    Iterable<ConstructorSpec> Function(ClassSpec owner) constructorBuilder,
  }) {
    if (constructorBuilder != null) constructors.addAll(constructorBuilder(this));
    _addChildren([
      [doc],
      metas,
      properties,
      getters,
      setters,
      methods,
      operatorMethods
    ].expand((o) => o).toList());
    implementClasses ?? (implementClasses = []);
    mixinClasses ?? (mixinClasses = []);
    generics ?? (generics = []);
  }

  ClassSpec.general(
    String className, {
    DocumentSpec doc,
    List<AnnotationSpec> metas,
    List<PropertySpec> properties,
    List<GetterSpec> getters,
    List<SetterSpec> setters,
    List<MethodSpec> methods,
    List<OperatorSpec> operatorMethods,
    TypeToken superClass,
    List<TypeToken> implementClasses,
    List<TypeToken> mixinClasses,
    List<TypeToken> generics,
    bool isAbstract = false,
    bool isMixin = false,
    Iterable<ConstructorSpec> Function(ClassSpec owner) constructorBuilder,
  }) : this._build(
          className,
          doc: doc,
          metas: metas,
          properties: properties,
          getters: getters,
          setters: setters,
          methods: methods,
          superClass: superClass,
          implementClasses: implementClasses,
          mixinClasses: mixinClasses,
          generics: generics,
          operatorMethods: operatorMethods,
          isAbstract: isAbstract,
          isMixin: isMixin,
          constructorBuilder: constructorBuilder,
        );

  @override
  String code() {
    StringBuffer code = StringBuffer();
    // class name
    if (isMixin) {
      code.write("mixin $className ");
    } else {
      if (isAbstract) code.write("abstract ");
      code.write("class $className ");
    }
    // generics
    if (hasGeneric) code.write("<${generics.map((o) => o.fullTypeName).join(", ")}> ");
    // super class
    if (superClass != null) {
      code.write(isMixin ? "on " : "extends ");
      code.write("${superClass.fullTypeName} ");
    }
    // mixin class
    if (mixinClasses.isNotEmpty) code.write("with ${mixinClasses.map((o) => o.fullTypeName).join(', ')} ");
    // implements class
    if (implementClasses.isNotEmpty) code.write("implements ${implementClasses.map((o) => o.fullTypeName).join(', ')} ");
    code.writeln("{");
    String constructorsBlock = _collectConstructors(constructors);
    String gettersBlock = _collectGetters(getters);
    String settersBlock = _collectSetters(setters);
    String methodsBlock = _collectMethods(methods);
    String propertiesBlock = _collectProperties(properties);
    String operatorsBlock = _collectOperatorMethods(operatorMethods);
    // properties
    propertiesBlock.isNotEmpty ? (code..writeln(propertiesBlock)..writeln()) : null;
    // getters
    gettersBlock.isNotEmpty ? (code..writeln(gettersBlock)..writeln()) : null;
    // setters
    settersBlock.isNotEmpty ? (code..writeln(settersBlock)..writeln()) : null;
    // constructors
    constructorsBlock.isNotEmpty ? (code..writeln(constructorsBlock)..writeln()) : null;
    // methods
    methodsBlock.isNotEmpty ? (code..writeln(methodsBlock)..writeln()) : null;
    // operator methods
    operatorsBlock.isNotEmpty ? (code..writeln(operatorsBlock)..writeln()) : null;
    code.write("}");

    String raw = code.toString();
    // meta
    raw = _collectWithMeta(metas, raw);
    // doc
    raw = _collectWithDoc(doc, raw);
    return raw;
  }
}
