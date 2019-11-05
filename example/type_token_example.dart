import 'package:dartpoet/dartpoet.dart';

void main() {
  print(TypeToken.ofFullName("GG<int, bool, double, List<int>,Pl>"));
  print(TypeToken.ofName2("Data", [int, bool]));
  var o = Data<int, Map<String, List<int>>>();
  print(TypeToken.of(o.runtimeType));
  print(TypeToken.parse(o));
  print(TypeToken.parse(o).firstGeneric);
}

class Data<T, R> {}
