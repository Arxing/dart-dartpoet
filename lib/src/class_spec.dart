import 'package:dartpoet/dartpoet.dart';

class ClassSpec implements Spec {
  DocSpec doc;

  List<MetaSpec> metas = [];

  List<GetterSpec> getters = [];

  List<SetterSpec> setters = [];

  List<MethodSpec> methods = [];

  List<ConstructorSpec> constructors = [];

  List<PropertySpec> properties = [];

  String className;

  TypeToken superClass;

  List<TypeToken> implementClasses = [];

  List<TypeToken> mixinClasses = [];

  ClassSpec.build(
    this.className, {
    this.doc,
    this.metas,
    this.properties,
    this.getters,
    this.setters,
    this.methods,
    this.superClass,
    this.implementClasses,
    this.mixinClasses,
    Iterable<ConstructorSpec> Function(ClassSpec owner) constructorBuilder,
  }) {
    if (constructorBuilder != null) constructors.addAll(constructorBuilder(this));
    if (metas == null) metas = [];
    if (properties == null) properties = [];
    if (getters == null) getters = [];
    if (setters == null) setters = [];
    if (methods == null) methods = [];
    if (implementClasses == null) implementClasses = [];
    if (mixinClasses == null) mixinClasses = [];
  }

  @override
  String code({Map<String, dynamic> args = const {}}) {
    StringBuffer inner = StringBuffer();
    inner.write('class $className');
    if (superClass != null) inner.write(' extends ${superClass.typeName}');
    if (implementClasses.isNotEmpty) inner.write(' implements ${implementClasses.map((o) => o.typeName).join(', ')}');
    if (mixinClasses.isNotEmpty) inner.write(' with ${mixinClasses.map((o) => o.typeName).join(', ')}');
    inner.writeln(' {');
    var blocks = [];
    String constructorsBlock = collectConstructors(constructors);
    String gettersBlock = collectGetters(getters);
    String settersBlock = collectSetters(setters);
    String methodsBlock = collectMethods(methods);
    String propertiesBlock = collectProperties(properties);
    if (propertiesBlock.isNotEmpty) blocks.add(propertiesBlock);
    if (constructorsBlock.isNotEmpty) blocks.add(constructorsBlock);
    if (gettersBlock.isNotEmpty) blocks.add(gettersBlock);
    if (settersBlock.isNotEmpty) blocks.add(settersBlock);
    if (methodsBlock.isNotEmpty) blocks.add(methodsBlock);
    inner.write(blocks.join('\n\n'));
    inner..writeln()..writeln('}');
    String raw = inner.toString();
    raw = collectWithMeta(metas, raw);
    raw = collectWithDoc(doc, raw);
    return raw;
  }
}

String collectClasses(List<ClassSpec> classes) {
  return classes.map((o) => o.code()).join('\n');
}

class ConstructorSpec implements Spec {
  DocSpec doc;

  ClassSpec owner;

  ConstructorMode mode;

  List<ParameterSpec> parameters = [];

  CodeBlockSpec codeBlock;

  String inherit;

  String name;

//todo initializer list

  ConstructorSpec.build(this.owner, {
    this.doc,
    this.mode,
    this.parameters,
    this.codeBlock,
    this.inherit,
    this.name,
  }) {
    if (parameters == null) parameters = [];
  }

  ConstructorSpec.normal(ClassSpec owner, {
    List<ParameterSpec> parameters = const [],
    CodeBlockSpec codeBlock,
    String inherit,
    DocSpec doc,
  }) : this.build(
    owner,
    parameters: parameters,
    codeBlock: codeBlock,
    inherit: inherit,
    mode: ConstructorMode.normal,
    doc: doc,
  );

  ConstructorSpec.named(ClassSpec owner,
      String name, {
        List<ParameterSpec> parameters = const [],
        CodeBlockSpec codeBlock,
        String inherit,
        DocSpec doc,
      }) : this.build(
    owner,
    parameters: parameters,
    codeBlock: codeBlock,
    inherit: inherit,
    mode: ConstructorMode.named,
    name: name,
    doc: doc,
  );

  ConstructorSpec.factory(ClassSpec owner, {
    List<ParameterSpec> parameters = const [],
    CodeBlockSpec codeBlock,
    String inherit,
    DocSpec doc,
  }) : this.build(
    owner,
    parameters: parameters,
    codeBlock: codeBlock,
    inherit: inherit,
    mode: ConstructorMode.factory,
    doc: doc,
  );

  ConstructorSpec.namedFactory(ClassSpec owner,
      String name, {
        List<ParameterSpec> parameters = const [],
        CodeBlockSpec codeBlock,
        String inherit,
        DocSpec doc,
      }) : this.build(
    owner,
    parameters: parameters,
    codeBlock: codeBlock,
    inherit: inherit,
    mode: ConstructorMode.namedFactory,
    doc: doc,
    name: name,
  );

  String get _constructorName => owner.className;

  @override
  String code({Map<String, dynamic> args = const {}}) {
    String raw = '';
    switch (mode) {
      case ConstructorMode.normal:
        raw += '$_constructorName(${collectParameters(parameters)})';
        break;
      case ConstructorMode.factory:
        raw += 'factory $_constructorName(${collectParameters(parameters)})';
        break;
      case ConstructorMode.named:
        raw += '$_constructorName.$name(${collectParameters(parameters)})';
        break;
      case ConstructorMode.namedFactory:
        raw += 'factory ${owner.className}.$name(${collectParameters(parameters)})';
        break;
    }
    if (inherit != null) {
      raw += ' : $inherit';
    }
    raw += '${collectCodeBlock(codeBlock)}';
    raw = collectWithDoc(doc, raw);
    return raw;
  }
}

String collectConstructors(List<ConstructorSpec> constructors) {
  return constructors.map((o) => o.code()).join("\n");
}

enum ConstructorMode { normal, factory, named, namedFactory }
