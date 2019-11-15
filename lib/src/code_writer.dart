class CodeWriter extends StringBuffer {
  _LineTransaction currentLineToken;

  _LineTransaction beginLine(){
    return _
  }
}

class _LineTransaction{
  List<String> segments = [];

  void put(String segment) => segments.add(segment);
}
