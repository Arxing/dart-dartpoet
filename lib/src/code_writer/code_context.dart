part of 'code_writer.dart';

abstract class CodeContext<TContext> {
  bool _actionFlag;

  bool _canDoAction() {
    bool b = _actionFlag ?? true;
    _actionFlag = null;
    return b;
  }

  TContext doNextActionIf(bool condition) {
    _actionFlag = condition;
    return this as TContext;
  }

  TContext doNextActionIfNot(bool condition) => doNextActionIf(!condition);

  void _commitFromChild(String code, [Map<String, dynamic> args]){
  }
}
