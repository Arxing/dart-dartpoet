part of 'spec.dart';

class DependencySpec extends Spec {
  String route;
  DependencyMode mode;

  @override
  SpecKind get kind => SpecKind.DEPENDENCY;

  DependencySpec.build(
    this.mode,
    this.route,
    );

  DependencySpec.import(String route) : this.build(DependencyMode.import, route);

  DependencySpec.export(String route) : this.build(DependencyMode.export, route);

  DependencySpec.part(String route) : this.build(DependencyMode.part, route);

  DependencySpec.partOf(String route) : this.build(DependencyMode.partOf, route);

  @override
  String code() {
    String raw = '';
    switch (mode) {
      case DependencyMode.import:
        raw += "import '$route';";
        break;
      case DependencyMode.export:
        raw += "export '$route';";
        break;
      case DependencyMode.part:
        raw += "part '$route';";
        break;
      case DependencyMode.partOf:
        raw += "part of '$route";
        break;
    }
    return raw;
  }
}

enum DependencyMode { import, export, part, partOf }