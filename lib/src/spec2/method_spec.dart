part of 'spec.dart';

abstract class MethodSpec extends Spec {
  MethodSpec._();

  factory MethodSpec.general(String methodName) {
    return _MethodSpecImpl.build(methodName);
  }
}

class _MethodSpecImpl extends MethodSpec {
  DocumentSpec get document => _childWhereType<DocumentSpec>();

  List<AnnotationSpec> get annotations => _childrenWhereType<AnnotationSpec>();

  List<ParameterSpec> get parameters => _childrenWhereType<ParameterSpec>();

  TypeToken returnType;
  String _methodName;

  set methodName(String name) => _methodName = name;

  String get methodName => _methodName;

  List<TypeToken> genericTypes = [];
  CodeBlockSpec codeBlock;
  bool isStatic;

  bool get hasGenericType => genericTypes.isNotEmpty;

  @override
  SpecKind get kind => SpecKind.METHOD;

  @override
  List<SpecKind> get supportedChildKinds => [SpecKind.DOC, SpecKind.META, SpecKind.PARAMETER];

  _MethodSpecImpl.build(
    String methodName, {
    DocumentSpec doc,
    List<AnnotationSpec> metas,
    List<ParameterSpec> parameters,
    this.returnType,
    CodeBlockSpec codeBlock,
    this.isStatic = false,
    List<TypeToken> genericTypes = const [],
  }) : super._() {
    _collectSpecs([doc, metas, parameters]);
    this.methodName = methodName;
    this.codeBlock = codeBlock ?? CodeBlockSpec.empty();
    this.genericTypes.addAll(genericTypes);
  }

  @override
  CodeWriter code() {
    CodeWriter codeWriter = CodeWriter();
    codeWriter
        .beginFragments()
        .putIf(isStatic && !isTopLevel, "static")
        .putIf(returnType != null, returnType.fullTypeName)
        .put(methodName)
        .commit()
        .addCodeIf(genericTypes.isNotEmpty, "<${genericTypes.map((type) => type.fullTypeName).join(", ")}>")
        .addCode("(${_collectParameters(parameters)})")
        .beginClosure()
        .endClosure();

    return codeWriter;
  }

//  @override
//  String code([Map<String, dynamic> args = const {}]) {
//    String raw = '';
//    var elements = [];
//    if (isFactory) elements.add('factory');
//    if (isStatic) elements.add('static');
//    if (returnType != null) elements.add(returnType.fullTypeName);
//    elements.add(methodName);
//    if (hasGenericType) elements.add("<${genericTypes.join(", ")}>");
//    raw += elements.join(' ');
//    raw += '(${_collectParameters(parameters)})';
//    raw += ' ' + _collectCodeBlock(codeBlock, withLambda: true);
//    raw = _collectWithMeta(annotations, raw);
//    raw = _collectWithDoc(doc, raw);
//    return raw;
//  }
}
