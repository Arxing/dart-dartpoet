import 'dart:io';

import 'package:dartpoet/dartpoet.dart';
import 'package:xfile/xfile.dart';

class DartFile {
  FileSpec fileSpec;

  String get _content => format(fileSpec?.code(args: {KEY_REVERSE_CLASSES: true}));

  DartFile.empty();

  DartFile.fromFileSpec(FileSpec fileSpec) {
    this.fileSpec = fileSpec;
  }

  String outputContent() => _content;

  Future<File> outputFileAsync(String path) => XFile.fromPath(path).file.writeAsString(outputContent());

  File outputSync(String path) => XFile.fromPath(path).file..writeAsStringSync(outputContent());
}
