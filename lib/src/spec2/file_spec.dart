part of 'spec.dart';

class FileSpec extends Spec {
  List<DependencySpec> dependencies = [];
  List<ClassSpec> classes = [];
  List<PropertySpec> properties = [];
  List<GetterSpec> getters = [];
  List<SetterSpec> setters = [];
  List<CodeBlockSpec> codeBlocks = [];
  List<MethodSpec> methods = [];

  @override
  SpecKind get kind => SpecKind.FILE;

  @override
  List<SpecKind> get supportedChildKinds => [SpecKind.DEPENDENCY, SpecKind.CLASS, SpecKind.PROPERTY, SpecKind.GETTER, SpecKind
    .s];

  FileSpec.build({
    this.methods,
    this.classes,
    this.properties,
    this.getters,
    this.setters,
    this.codeBlocks,
    this.dependencies,
  }) {
    if (methods == null) methods = [];
    if (classes == null) classes = [];
    if (properties == null) properties = [];
    if (getters == null) getters = [];
    if (setters == null) setters = [];
    if (codeBlocks == null) codeBlocks = [];
    if (dependencies == null) dependencies = [];
  }

  @override
  String code([Map<String, dynamic> args = const {}]) {
    bool reverseClasses = args[KEY_REVERSE_CLASSES] ?? false;
    if (reverseClasses) classes = classes.reversed.toList();
    StringBuffer inner = StringBuffer();
    String dependenciesBlock = _collectDependencies(dependencies);
    String classesBlock = _collectClasses(classes);
    String propertiesBlock = _collectProperties(properties);
    String gettersBlock = _collectGetters(getters);
    String settersBlock = _collectSetters(setters);
    String codeBlocksBlock = _collectCodeBlocks(codeBlocks);
    String methodsBlock = _collectMethods(methods);
    if (dependenciesBlock.isNotEmpty) inner..writeln()..writeln(dependenciesBlock);
    if (propertiesBlock.isNotEmpty) inner..writeln()..writeln(propertiesBlock);
    if (gettersBlock.isNotEmpty) inner..writeln()..writeln(gettersBlock);
    if (settersBlock.isNotEmpty) inner..writeln()..writeln(settersBlock);
    if (codeBlocksBlock.isNotEmpty) inner..writeln()..writeln(codeBlocksBlock);
    if (classesBlock.isNotEmpty) inner..writeln()..writeln(classesBlock);
    if (methodsBlock.isNotEmpty) inner..writeln()..writeln(methodsBlock);
    String raw = inner.toString();
    return raw;
  }
}