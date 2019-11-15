part of 'spec.dart';

class DocumentSpec implements Spec {
  String content;

  @override
  SpecKind get kind => SpecKind.DOC;

  DocumentSpec.text(this.content);

  @override
  String code([Map<String, dynamic> args = const {}]) {
    return '/// $content';
  }
}