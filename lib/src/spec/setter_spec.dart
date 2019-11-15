part of 'spec.dart';

class SetterSpec implements Spec {
  DocSpec doc;
  ParameterSpec parameter;
  String setterName;
  CodeBlockSpec codeBlock;

  @override
  SpecKind get kind => SpecKind.SETTER;

  SetterSpec.build(
    this.setterName,
    this.parameter, {
    this.doc,
    this.codeBlock,
  });

  @override
  String code([Map<String, dynamic> args = const {}]) {
    String raw = 'set $setterName(${_collectParameters([parameter])})${_collectCodeBlock(codeBlock)}';
    raw = _collectWithDoc(doc, raw);
    return raw;
  }
}
