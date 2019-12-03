part of '../code_writer.dart';

class SegmentTransaction<TParent extends CodeContext> extends _Transaction<TParent>
    with CodeContext<SegmentTransaction<TParent>> {
  List<String> _segments = [];

  SegmentTransaction(CodeContext context, [Map<String, dynamic> args]) : super(context, args);

  SegmentTransaction<TParent> put(String segment) {
    if (!_canDoAction()) return this;
    _segments.add(segment);
    return this;
  }

  @override
  String _collectCode() {
    return _segments.join(" ");
  }
}
