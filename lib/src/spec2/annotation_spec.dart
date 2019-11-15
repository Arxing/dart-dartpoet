part of 'spec.dart';

class AnnotationSpec implements Spec {
  TypeToken typeToken;
  List<ParameterSpec> parameters = [];
  String instanceName;
  bool isInstance = false;

  @override
  SpecKind get kind => SpecKind.META;

  AnnotationSpec.ofInstance(String instanceName) {
    this.instanceName = instanceName;
    this.isInstance = true;
  }

  AnnotationSpec.ofConstructor(TypeToken type, {List<ParameterSpec> parameters}) {
    this.isInstance = false;
    this.typeToken = type;
    this.parameters = parameters ?? [];
  }

  @override
  String code([Map<String, dynamic> args = const {}]) {
    if (isInstance) {
      return "@$instanceName";
    } else {
      var list = parameters.where((o) => o.isValue).toList();
      list.sort((o1, o2) => o1.parameterMode.index - o2.parameterMode.index);
      return "@${typeToken.fullTypeName}(${list.map((o) => o.code()).join(", ")})";
    }
  }
}