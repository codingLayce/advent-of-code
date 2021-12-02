import 'package:test/test.dart';

class Test {
  String name;
  List<String> data;
  Future<int> Function(List<String>) resolver;
  int? expectedResult;
  TypeMatcher? expectedError;

  Test(this.name, this.data, this.resolver, this.expectedResult,
      this.expectedError);

  testResult() {
    Future<int> future = resolver(data);
    expectLater(future, completion(equals(expectedResult)));
  }

  testError() {
    Future<int> future = resolver(data);
    expectLater(future, throwsA(expectedError));
  }
}
