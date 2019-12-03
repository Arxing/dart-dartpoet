part of 'spec.dart';

class DocumentSpec extends Spec {
  String content;

  @override
  SpecKind get kind => SpecKind.DOC;

  DocumentSpec.text(this.content);

  @override
  String code() {
    return '/// $content';
  }

  @override
  // TODO: implement supportedChildKinds
  List<SpecKind> get supportedChildKinds => null;
}