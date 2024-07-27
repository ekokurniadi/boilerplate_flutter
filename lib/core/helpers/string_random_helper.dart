import 'dart:math';

class StringRandomHelper {
  const StringRandomHelper._();

  static String generate({int? length}) {
    String randomString = '';
    const chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    final Random rnd = Random();
    randomString = String.fromCharCodes(
      Iterable.generate(
        length ?? 5,
        (_) => chars.codeUnitAt(
          rnd.nextInt(chars.length),
        ),
      ),
    );

    return randomString;
  }

  static String generatePhoneNumber() {
    String randomString = '';
    const chars = '1234567890';
    final Random rnd = Random();
    randomString = String.fromCharCodes(
      Iterable.generate(
        12,
            (_) => chars.codeUnitAt(rnd.nextInt(chars.length)),
      ),
    );

    return randomString;
  }

  static String generateEmailFromName(String name) {
    final randomString = generate(length: 4);

    return '${name.replaceAll(' ', '')}$randomString@mail.com';
  }
}
