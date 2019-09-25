import 'package:dartpoet/dartpoet.dart';

class MetaSpec implements Spec {
  TypeToken _typeToken;
  List<ParameterSpec> _parameters = [];
  String _instanceName;
  bool _isInstance = false;

  MetaSpec.ofInstance(String instanceName) {
    _instanceName = instanceName;
    _isInstance = true;
  }

  MetaSpec.ofConstructor(TypeToken type, {List<ParameterSpec> parameters}) {
    _typeToken = type;
    _parameters = parameters ?? [];
    _isInstance = false;
  }

  @override
  String code({Map<String, dynamic> args = const {}}) {
    if (_isInstance) {
      return "@$_instanceName";
    } else {
      var list = _parameters.where((o) => o.isValue).toList();
      list.sort((o1, o2) => o1.parameterMode.index - o2.parameterMode.index);
      return "@${_typeToken.typeName}(${list.map((o) => o.code()).join(", ")})";
    }
  }
}

String collectMetas(List<MetaSpec> metas) {
  return metas.map((o) => o.code()).join('\n');
}

String collectWithMeta(List<MetaSpec> metas, String raw) {
  if (metas.isEmpty) return raw;
  return '${collectMetas(metas)}\n$raw';
}
