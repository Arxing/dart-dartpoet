import 'package:dartpoet/src/code_writer.dart';

void main(){
  CodeWriter codeWriter = CodeWriter();

  var r = codeWriter.beginFragments().put("static").put("class").put("Output").commit().output();
  print(r);
}