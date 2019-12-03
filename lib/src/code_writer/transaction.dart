part of 'code_writer.dart';

abstract class _Transaction<TParent extends CodeContext> {
  TParent _context;
  Map<String, dynamic> args;

  _Transaction(this._context, [this.args = const {}]);

  String _collectCode();

  void _changeState() {}

  TParent commit() {
    _changeState();
    String collecting = _collectCode();
    if (collecting != null && collecting.isNotEmpty) _context._commitFromChild(collecting, args);
    return _context;
  }

  TParent cancel() {
    return _context;
  }
}
