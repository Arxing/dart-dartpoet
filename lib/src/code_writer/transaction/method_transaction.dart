part of '../code_writer.dart';

class MethodTransaction<TParent extends CodeContext> extends _Transaction<TParent> with CodeContext<MethodTransaction<TParent>> {
  MethodTransaction(TParent context, [Map<String, dynamic> args]) : super(context, args);

  @override
  String _collectCode() {
    return null;
  }

  MethodTransaction methodName(String methodName){
    return this;
  }
}
