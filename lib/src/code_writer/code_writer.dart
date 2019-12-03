import 'package:dart_style/dart_style.dart';
import 'package:uuid/uuid.dart';

part 'package:dartpoet/src/code_writer/transaction/segment_transaction.dart';

part 'package:dartpoet/src/code_writer/transaction/if_else_transaction.dart';

part 'package:dartpoet/src/code_writer/transaction/code_transaction.dart';

part 'code_context.dart';

part 'transaction.dart';

part 'package:dartpoet/src/code_writer/transaction/method_transaction.dart';

class CodeWriter with CodeContext<CodeWriter> {
  StringBuffer _buffer = StringBuffer();
  DartFormatter _formatter = DartFormatter();

  CodeTransaction<CodeWriter> beginCode() => CodeTransaction(this);

  String output({bool format = true}) {
    var source = _buffer.toString();
    if (format) {
      return _formatter.format(source);
    } else {
      return source;
    }
  }

  @override
  void _commitFromChild(String code, [Map<String, dynamic> args]) => _buffer.write(code);
}
