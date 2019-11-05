import 'package:dartpoet/dartpoet.dart';

class OperatorSpec implements Spec {
  String operator;
  TypeToken returnType;
  List<ParameterSpec> parameters = [];
  CodeBlockSpec codeBlock;

  OperatorSpec.build(this.operator, this.returnType, this.parameters, this.codeBlock);

  @override
  String code({Map<String, dynamic> args = const {}}) {
    return "${returnType.fullTypeName} operator(${collectParameters(parameters)})${collectCodeBlock(codeBlock)}";
  }
}
