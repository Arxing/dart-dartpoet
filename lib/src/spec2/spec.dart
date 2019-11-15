import 'package:dartpoet/dartpoet.dart';
import 'dart:convert';
import 'dart:io';

part 'package:dartpoet/src/spec2/class_spec.dart';

part 'package:dartpoet/src/spec2/code_block_spec.dart';

part 'package:dartpoet/src/spec2/document_spec.dart';

part 'package:dartpoet/src/spec2/file_spec.dart';

part 'package:dartpoet/src/spec2/annotation_spec.dart';

part 'package:dartpoet/src/spec2/method_spec.dart';

part 'package:dartpoet/src/spec2/operator_spec.dart';

part 'package:dartpoet/src/spec2/parameter_spec.dart';

part 'package:dartpoet/src/spec2/property_spec.dart';

part 'package:dartpoet/src/spec2/setter_spec.dart';

part 'package:dartpoet/src/spec2/getter_spec.dart';

part 'package:dartpoet/src/spec2/constructor_spec.dart';

part 'package:dartpoet/src/spec2/dependency_spec.dart';

part 'package:dartpoet/src/spec2/collectors.dart';

abstract class Spec {
  SpecKind get kind;

  List<SpecKind> get supportedChildKinds;

  Spec get parent => _parent;

  Spec _parent;

  List<Spec> _children = [];

  int _depth = 0;

  bool get isTopLevel => _depth == 0;

  List<T> _childrenWhereType<T extends Spec>() => _children.whereType<T>().toList();

  T _childWhereType<T extends Spec>() => _children.whereType<T>().first;

  bool isSupported(Spec spec) => supportedChildKinds.contains(spec.kind);

  void _collectSpecs(List<dynamic> specs) {
    specs.forEach((what) {
      if (what is Spec) _addChild(what);
      if (what is List<Spec>) _addChildren(what);
    });
  }

  void _addChild(Spec child) {
    if (child != null) {
      if (isSupported(child)) {
        child._parent = this;
        child._depth = this._depth + 1;
        _children.add(child);
      } else {
        throw "The kind ${child.kind.name} is not supported for ${kind.name}";
      }
    }
  }

  void _addChildren(List<Spec> children) {
    if (children != null && children.isNotEmpty) children.forEach((o) => this._addChild(o));
  }

  CodeWriter code();
}
