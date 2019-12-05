import 'package:dartpoet/dartpoet.dart';

main() {
  // define a file spec
  FileSpec fileSpec = FileSpec.build(
    dependencies: [
      DependencySpec.import('dart:convert'),
    ], // define methods in this file
    methods: [
      // define method1
      MethodSpec.build(
        'globalFunc1', // define parameters in this method
        parameters: [
          ParameterSpec.normal('param1', type: TypeToken.ofInt(), metas: [
            MetaSpec.ofInstance("override"),
            MetaSpec.ofInstance("override2"),
          ]),
        ], // define code block spec in this method
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
        metas: [
          MetaSpec.ofConstructor(TypeToken.ofName("Object")),
          MetaSpec.ofInstance("deprecated"),
          MetaSpec.ofConstructor(TypeToken.ofName("JsonKey"), parameters: [
            ParameterSpec.named("ignored", isValue: true, value: false),
            ParameterSpec.normal("p1", isValue: true, value: "aa1234"),
          ]),
        ],
        doc: DocSpec.text('hello! world!.'),
        superClass: TypeToken.of(Object),
        methods: [
          MethodSpec.build('sayHello',
              codeBlock: CodeBlockSpec.line('print(\'hello\');'),
              isAbstract: false,
              asynchronousMode: AsynchronousMode.asyncFuture),
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
