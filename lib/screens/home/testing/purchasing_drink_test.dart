import 'package:flutter_test/flutter_test.dart';

//Not necessary to write this test but I added it to cover basic case
void main() {
  test('purchasing drink change money', () {
    const inputCents = 1000;
    const priceCents = 510;

    const remain = inputCents - priceCents;
    expect(
      remain,
      equals(490),
    );
  });
}
