/// Support for doing something awesome.
///
/// More dartdocs go here.
library dartpoet;

import 'package:dart_style/dart_style.dart';

export 'src/class_spec.dart';
export 'src/code_block_spec.dart';
export 'src/dart_file.dart';
export 'src/doc_spec.dart';
export 'src/file_spec.dart';
export 'src/meta_spec.dart';
export 'src/method_spec.dart';
export 'src/operator_spec.dart';
export 'src/parameter_spec.dart';
export 'src/property_spec.dart';
export 'src/setter_getter_spec.dart';
export 'src/spec.dart';
export 'package:type_token/type_token.dart';

const String KEY_WITH_BLOCK = 'with_block';
const String KEY_WITH_LAMBDA = 'with_lambda';
const String KEY_WITH_DEF_VALUE = 'with_def_value';
const String KEY_REVERSE_CLASSES = 'reverse_classes';

DartFormatter _formatter = DartFormatter();

String format(String source) => _formatter.format(source);
