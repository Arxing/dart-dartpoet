import 'package:dartpoet/dartpoet.dart';

class MetaSpec implements Spec {
  String metaData;

  MetaSpec.of(this.metaData);

  @override
  String code({Map<String, dynamic> args = const {}}) {
    return '@$metaData';
  }
}

String collectMetas(List<MetaSpec> metas) {
  return metas.map((o) => o.code()).join('\n');
}

String collectWithMeta(List<MetaSpec> metas, String raw){
  if (metas.isEmpty) return raw;
  return '${collectMetas(metas)}\n$raw';
}