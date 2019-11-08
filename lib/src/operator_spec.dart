import 'package:dartpoet/dartpoet.dart';

class OperatorSpec implements Spec {
  String operator;
  TypeToken returnType;
  List<ParameterSpec> parameters = [];
  CodeBlockSpec codeBlock;

  OperatorSpec.build(this.operator, this.returnType, this.parameters, this.codeBlock);

  @override
  String code({Map<String, dynamic> args = const {}}) {
    return "${returnType.fullTypeName} operator $operator(${collectParameters(parameters)})${collectCodeBlock(codeBlock)}";
  }
}

String collectOperatorMethods(List<OperatorSpec> operators) {
  return operators.map((o) => o.code()).join("\n\n");
}
