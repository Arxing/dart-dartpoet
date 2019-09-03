import 'package:dartpoet/dartpoet.dart';

class GetterSpec implements Spec {
  DocSpec doc;
  TypeToken type;
  String getterName;
  CodeBlockSpec codeBlock;

  GetterSpec.build(
    this.getterName, {
    this.doc,
    this.type,
    this.codeBlock,
  });

  @override
  String code({Map<String, dynamic> args = const {}}) {
    String raw = '';
    if (type == null) {
      raw += 'get $getterName ${collectCodeBlock(codeBlock)}';
    } else {
      raw += '${type.typeName} get $getterName ${collectCodeBlock(codeBlock)}';
    }
    raw = collectWithDoc(doc, raw);
    return raw;
  }
}

String collectGetters(List<GetterSpec> getters) {
  return getters.map((o) => o.code()).join("\n");
}

class SetterSpec implements Spec {
  DocSpec doc;
  ParameterSpec parameter;
  String setterName;
  CodeBlockSpec codeBlock;

  SetterSpec.build(
    this.setterName,
    this.parameter, {
    this.doc,
    this.codeBlock,
  });

  @override
  String code({Map<String, dynamic> args = const {}}) {
    String raw = 'set $setterName(${collectParameters([parameter])})${collectCodeBlock(codeBlock)}';
    raw = collectWithDoc(doc, raw);
    return raw;
  }
}

String collectSetters(List<SetterSpec> setters) {
  return setters.map((o) => o.code()).join("\n");
}
