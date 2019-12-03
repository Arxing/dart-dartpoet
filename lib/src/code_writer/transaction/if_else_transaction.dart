part of '../code_writer.dart';

class IfElseTransaction<TParent extends CodeContext> extends _Transaction<TParent> with CodeContext<IfElseTransaction<TParent>> {
  static final String KEY_KIND = "kind";
  static final String KEY_UUID = "uuid";
  static final Uuid _uuid = Uuid();
  List<_IfElseBundle> _bundles = [];

  static String get uuid => _uuid.v1();

  IfElseTransaction(CodeContext context, [Map<String, dynamic> args]) : super(context, args);

  @override
  String _collectCode() {
    StringBuffer buffer = StringBuffer();
    var ifBundle = _bundles.firstWhere((o) => o.kind == _IfElseKind.IF);
    var elseIfBundles = _bundles.where((o) => o.kind == _IfElseKind.ELSE_IF).toList();
    var elseBundle = _bundles.firstWhere((o) => o.kind == _IfElseKind.ELSE, orElse: () => null);

    buffer.writeln("if (${ifBundle.condition}){${ifBundle.code}}");
    elseIfBundles.forEach((bundle) {
      buffer.writeln("else if (${bundle.condition}){${bundle.code}}");
    });
    if (elseBundle != null) {
      buffer.writeln("else {${elseBundle.code}}");
    }
    return buffer.toString();
  }

  @override
  void _commitFromChild(String code, [Map<String, dynamic> args]) {
    String key = args[KEY_UUID];
    _IfElseBundle bundle = _bundles.firstWhere((o) => o.key == key);
    bundle.code = code;
  }

  CodeTransaction<IfElseTransaction<TParent>> putIf(String condition) {
    if (_bundles.any((o) => o.kind == _IfElseKind.IF)) throw "If-else can only exist 1 if block";
    var key = uuid;
    _bundles.add(_IfElseBundle(_IfElseKind.IF, condition, key));
    return CodeTransaction<IfElseTransaction<TParent>>(this, {KEY_KIND: _IfElseKind.IF, KEY_UUID: key});
  }

  CodeTransaction<IfElseTransaction<TParent>> putElseIf(String condition) {
    var key = uuid;
    _bundles.add(_IfElseBundle(_IfElseKind.ELSE_IF, condition, key));
    return CodeTransaction<IfElseTransaction<TParent>>(this, {KEY_KIND: _IfElseKind.IF, KEY_UUID: key});
  }

  CodeTransaction<IfElseTransaction<TParent>> putElse() {
    if (_bundles.any((o) => o.kind == _IfElseKind.ELSE)) throw "If-else can only exist 1 else block";
    var key = uuid;
    _bundles.add(_IfElseBundle(_IfElseKind.ELSE, null, key));
    return CodeTransaction<IfElseTransaction<TParent>>(this, {KEY_KIND: _IfElseKind.IF, KEY_UUID: key});
  }
}

enum _IfElseKind { IF, ELSE_IF, ELSE }

class _IfElseBundle {
  _IfElseKind kind;
  String condition;
  String code;
  String key;

  _IfElseBundle(this.kind, this.condition, this.key);
}
