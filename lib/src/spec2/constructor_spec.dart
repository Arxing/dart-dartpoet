part of 'spec.dart';

class ConstructorSpec implements Spec {
  DocumentSpec doc;

  ClassSpec owner;

  ConstructorMode mode;

  List<ParameterSpec> parameters = [];

  CodeBlockSpec codeBlock;

  String inherit;

  String name;

  @override
  SpecKind get kind => SpecKind.CONSTRUCTOR;

//todo initializer list

  ConstructorSpec._build(
    this.owner, {
      this.doc,
      this.mode,
      this.parameters,
      this.codeBlock,
      this.inherit,
      this.name,
    }) {
    parameters ?? (parameters = []);
  }

  ConstructorSpec.normal(
    ClassSpec owner, {
      List<ParameterSpec> parameters,
      CodeBlockSpec codeBlock,
      String inherit,
      DocumentSpec doc,
    }) : this._build(
    owner,
    parameters: parameters,
    codeBlock: codeBlock,
    inherit: inherit,
    mode: ConstructorMode.normal,
    doc: doc,
  );

  ConstructorSpec.named(
    ClassSpec owner,
    String name, {
      List<ParameterSpec> parameters = const [],
      CodeBlockSpec codeBlock,
      String inherit,
      DocumentSpec doc,
    }) : this._build(
    owner,
    parameters: parameters,
    codeBlock: codeBlock,
    inherit: inherit,
    mode: ConstructorMode.named,
    name: name,
    doc: doc,
  );

  ConstructorSpec.factory(
    ClassSpec owner, {
      List<ParameterSpec> parameters = const [],
      CodeBlockSpec codeBlock,
      String inherit,
      DocumentSpec doc,
    }) : this._build(
    owner,
    parameters: parameters,
    codeBlock: codeBlock,
    inherit: inherit,
    mode: ConstructorMode.factory,
    doc: doc,
  );

  ConstructorSpec.namedFactory(
    ClassSpec owner,
    String name, {
      List<ParameterSpec> parameters = const [],
      CodeBlockSpec codeBlock,
      String inherit,
      DocumentSpec doc,
    }) : this._build(
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
  String code([Map<String, dynamic> args = const {}]) {
    String raw = '';
    switch (mode) {
      case ConstructorMode.normal:
        raw += '$_constructorName(${_collectParameters(parameters)})';
        break;
      case ConstructorMode.factory:
        raw += 'factory $_constructorName(${_collectParameters(parameters)})';
        break;
      case ConstructorMode.named:
        raw += '$_constructorName.$name(${_collectParameters(parameters)})';
        break;
      case ConstructorMode.namedFactory:
        raw += 'factory ${owner.className}.$name(${_collectParameters(parameters)})';
        break;
    }
    if (inherit != null) {
      raw += ' : $inherit';
    }
    raw += '${_collectCodeBlock(codeBlock)}';
    raw = _collectWithDoc(doc, raw);
    return raw;
  }
}

enum ConstructorMode { normal, factory, named, namedFactory }