import 'package:flutter_test/flutter_test.dart';

void main() {
  test('', () {
    String createMessage() {
      print("Created this string");
      return "Hello World";
    }

    late final String message = createMessage();
    print("Hey, $message");
    print("Hey, $message");
  });
}
