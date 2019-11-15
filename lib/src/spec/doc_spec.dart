part of 'spec.dart';

class DocSpec implements Spec {
  String content;

  @override
  SpecKind get kind => SpecKind.DOC;

  DocSpec.text(this.content);

  @override
  String code([Map<String, dynamic> args = const {}]) {
    return '/// $content';
  }
}