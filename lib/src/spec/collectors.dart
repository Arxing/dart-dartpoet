part of 'spec.dart';

String _collectClasses(List<ClassSpec> classes) {
  return classes.map((o) => o.code()).join('\n');
}

String _collectConstructors(List<ConstructorSpec> constructors) {
  return constructors.map((o) => o.code()).join("\n");
}

String _collectCodeBlock(
  CodeBlockSpec codeBlock, {
    bool withLambda = true,
    bool withBlock = true,
    CodeBlockEmptiedCollectingMode collectingMode = CodeBlockEmptiedCollectingMode.end,
  }) {
  if (codeBlock == null) {
    switch (collectingMode) {
      case CodeBlockEmptiedCollectingMode.nothing:
        return '';
      case CodeBlockEmptiedCollectingMode.emptyBlock:
        return '{}';
      case CodeBlockEmptiedCollectingMode.end:
        return ';';
    }
  }
  return codeBlock.code({KEY_WITH_BLOCK: withBlock, KEY_WITH_LAMBDA: withLambda});
}

String _collectCodeBlocks(List<CodeBlockSpec> codeBlocks) {
  return codeBlocks.map((o) => o.code()).join('\n');
}

String _collectWithDoc(DocSpec doc, String raw) {
  if (doc == null) return raw;
  return '${doc.code()}\n$raw';
}

String _collectDependencies(List<DependencySpec> dependencies) {
  dependencies.sort((o1, o2) => o1.mode.index - o2.mode.index);
  return dependencies.map((o) => o.code()).join('\n');
}

String _collectMetas(List<MetaSpec> metas) {
  return metas.map((o) => o.code()).join('\n');
}

String _collectWithMeta(List<MetaSpec> metas, String raw) {
  if (metas.isEmpty) return raw;
  return '${_collectMetas(metas)}\n$raw';
}

String _collectMethods(List<MethodSpec> methods) {
  return methods.map((o) => o.code()).join("\n\n");
}

String _collectOperatorMethods(List<OperatorSpec> operators) {
  return operators.map((o) => o.code()).join("\n\n");
}

String _collectParameters(List<ParameterSpec> parameters) {
  if (parameters == null || parameters.isEmpty) return '';
  var normalList = parameters.where((o) => o.parameterMode == ParameterMode.normal);
  var namedList = parameters.where((o) => o.parameterMode == ParameterMode.named);
  var indexedList = parameters.where((o) => o.parameterMode == ParameterMode.indexed);
  List<String> paramsList = [];
  if (normalList.isNotEmpty) paramsList.add(normalList.map((o) => o.code()).join(", "));
  if (namedList.isNotEmpty) paramsList.add('{' + namedList.map((o) => o.code({KEY_WITH_DEF_VALUE: true})).join(", ") + '}');
  if (indexedList.isNotEmpty) paramsList.add('[' + indexedList.map((o) => o.code({KEY_WITH_DEF_VALUE: true})).join(", ") + ']');
  return paramsList.join(", ");
}

String _collectProperties(List<PropertySpec> properties) {
  return properties.map((o) => o.code({KEY_WITH_DEF_VALUE: true})).join('\n');
}

String _collectSetters(List<SetterSpec> setters) {
  return setters.map((o) => o.code()).join("\n");
}

String _collectGetters(List<GetterSpec> getters) {
  return getters.map((o) => o.code()).join("\n");
}