import 'dart:convert';

/// this is a student class
class Student {
  String name;
  int score;

  Student(this.name, this.score);
}

/// hello! world!.
@Object()
@deprecated
@JsonKey("aa1234", ignored: false)
class HelloWorld extends Object {
  List<Student> students = [];
  Map<String, int> studentScores = {"John": 100, "Rek": 50};
  bool run;

  int get studentCount => students.length;

  set newStudent(Student student) => students.add(student);

  sayHello() async => print('hello');
}

globalFunc1(@override @override2 int param1) => print('hello world!');
