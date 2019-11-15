import 'package:dartpoet/dartpoet.dart';

void main() {
  var spec = CodeBlockSpec.lines([
    "int a = 0;",
  ]);
  print("spec=\n${spec.code({CodeBlockSpec.KEY_USE_EXPRESSION_BODY: true})}");

//  ClassSpec classSpec = ClassSpec.general(
//    "Output",
//    superClass: TypeToken.ofName("Parent"),
//    isAbstract: true,
//    properties: [
//      PropertySpec.ofInt("aInt"),
//    ],
//    methods: [
//      MethodSpec.build(
//        "aMethod",
//        isStatic: true,
//      ),
//    ],
//  );
//
//  DartFile.fromFileSpec(FileSpec.build(classes: [classSpec])).outputSync("./example/output/generate_sample1.dart");
}
