You can use this library to programmatically generate dart file. Like Javapoet.

## Usage

A simple usage example:

```dart
import 'package:dartpoet/dartpoet.dart';

main() {
  // define a file spec
  FileSpec fileSpec = FileSpec.build(
    dependencies: [
      DependencySpec.import('dart:convert'),
    ],
    // define methods in this file
    methods: [
      // define method1
      MethodSpec.build(
        'globalFunc1',
        // define parameters in this method
        parameters: [
          ParameterSpec.normal('param1', type: TypeToken.ofInt()),
        ],
        // define code block spec in this method
        codeBlock: CodeBlockSpec.line('print(\'hello world!\');'),
      ),
    ],
    classes: [
      ClassSpec.build(
        'Student',
        properties: [
          PropertySpec.ofString('name'),
          PropertySpec.ofInt('score'),
        ],
        constructorBuilder: (owner) sync* {
          yield ConstructorSpec.normal(
            owner,
            parameters: [
              ParameterSpec.normal('name', isSelfParameter: true, type: TypeToken.ofString()),
              ParameterSpec.normal('score', isSelfParameter: true, type: TypeToken.ofInt()),
            ],
          );
        },
        doc: DocSpec.text('this is a student class'),
      ),
      ClassSpec.build(
        'HelloWorld',
        metas: [MetaSpec.of('Object()')],
        doc: DocSpec.text('hello! world!.'),
        superClass: TypeToken.of(Object),
        methods: [
          MethodSpec.build('sayHello', codeBlock: CodeBlockSpec.line('print(\'hello\');')),
        ],
        properties: [
          PropertySpec.of('students', type: TypeToken.ofListByToken(TypeToken.ofName('Student')), defaultValue: []),
          PropertySpec.of('studentScores', defaultValue: {'John': 100, 'Rek': 50}, type: TypeToken.ofMap<String, int>()),
          PropertySpec.of('run', type: TypeToken.ofBool()),
        ],
        getters: [
          GetterSpec.build('studentCount', type: TypeToken.ofInt(), codeBlock: CodeBlockSpec.lines(['students.length;'])),
        ],
        setters: [
          SetterSpec.build('newStudent', ParameterSpec.normal('student', type: TypeToken.ofName('Student')),
              codeBlock: CodeBlockSpec.line('students.add(student);'))
        ],
      ),
    ],
  );

  // define a dart file
  DartFile dartFile = DartFile.fromFileSpec(fileSpec);
  // output file content
  print(dartFile.outputContent());
  dartFile.outputSync('./example/example_output.dart');
}
```

## Output

The sample code generate a file at [./example/example_output.dart](https://github.com/Arxing/dart-dartpoet/blob/master/example/example_output.dart)

```dart

import 'dart:convert';

/// this is a student class
class Student {
  String name;
  int score;

  Student(this.name, this.score);
}

/// hello! world!.
@Object()
class HelloWorld extends Object {
  List<Student> students=[];
  Map<String, int> studentScores={"John":100,"Rek":50};
  bool run;

  int get studentCount  => students.length;

  set newStudent(Student student) => students.add(student);

  sayHello()  => print('hello');
}


globalFunc1(int param1)  => print('hello world!');
```

## Features and bugs

Please file feature requests and bugs at the [issue tracker][tracker].

[tracker]: https://github.com/Arxing/dart-dartpoet/issues
