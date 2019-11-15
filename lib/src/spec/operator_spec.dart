part of 'spec.dart';

class OperatorSpec implements Spec {
  String operator;
  TypeToken returnType;
  List<ParameterSpec> parameters = [];
  CodeBlockSpec codeBlock;

  @override
  SpecKind get kind => SpecKind.OPERATOR;

  OperatorSpec.build(this.operator, this.returnType, this.parameters, this.codeBlock);

  @override
  String code([Map<String, dynamic> args = const {}]) {
    return "${returnType.fullTypeName} operator $operator(${_collectParameters(parameters)})${_collectCodeBlock(codeBlock)}";
  }
}