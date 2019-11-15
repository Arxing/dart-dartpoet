part of 'spec.dart';

class GetterSpec implements Spec {
  DocumentSpec doc;
  TypeToken type;
  String getterName;
  CodeBlockSpec codeBlock;

  @override
  SpecKind get kind => SpecKind.GETTER;

  GetterSpec.build(
    this.getterName, {
      this.doc,
      this.type,
      this.codeBlock,
    });

  @override
  String code([Map<String, dynamic> args = const {}]) {
    String raw = '';
    if (type == null) {
      raw += 'get $getterName ${_collectCodeBlock(codeBlock)}';
    } else {
      raw += '${type.fullTypeName} get $getterName ${_collectCodeBlock(codeBlock)}';
    }
    raw = _collectWithDoc(doc, raw);
    return raw;
  }
}