part of 'spec.dart';

class MethodSpec implements Spec {
  DocSpec doc;
  String methodName;
  List<MetaSpec> metas = [];
  List<ParameterSpec> parameters = [];
  TypeToken returnType;
  CodeBlockSpec codeBlock;
  bool isStatic;
  bool isFactory;
  List<TypeToken> generics = [];
  bool get hasGeneric => generics.isNotEmpty;

  @override
  SpecKind get kind => SpecKind.METHOD;

  MethodSpec.build(
    this.methodName, {
    this.doc,
    this.metas,
    this.parameters,
    this.returnType,
    this.codeBlock,
    this.isStatic = false,
    this.isFactory = false,
    this.generics,
  }) {
    if (metas == null) metas = [];
    if (parameters == null) parameters = [];
    if (generics == null) generics = [];
  }

  @override
  String code([Map<String, dynamic> args = const {}]) {
    String raw = '';
    var elements = [];
    if (isFactory) elements.add('factory');
    if (isStatic) elements.add('static');
    if (returnType != null) elements.add(returnType.fullTypeName);
    elements.add(methodName);
    if (hasGeneric) elements.add("<${generics.join(", ")}>");
    raw += elements.join(' ');
    raw += '(${_collectParameters(parameters)})';
    raw += ' ' + _collectCodeBlock(codeBlock, withLambda: true);
    raw = _collectWithMeta(metas, raw);
    raw = _collectWithDoc(doc, raw);
    return raw;
  }
}