import "package:flutter_test/flutter_test.dart";
import 'package:gc_wizard/logic/tools/encodings/deadfish.dart';

void main() {
  group("Deadfish.encodeDeadfish:", () {
    List<Map<String, dynamic>> _inputsToExpected = [
      {'input' : null, 'expectedOutput' : ''},
      {'input' : '', 'expectedOutput' : ''},

      {'input' : 'Hallo Welt', 'expectedOutput' : 'iissiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiioiiiiiiiiiiiiiiiiiiiiiiiiioiiiiiiiiiiiooiiiodddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddoiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiioiiiiiiiiiiiiiioiiiiiiioiiiiiiiio'},
      {'input' : 'Test123', 'expectedOutput' : 'iissiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiioiiiiiiiiiiiiiiiiioiiiiiiiiiiiiiioiodddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddoioio'},

    ];

    _inputsToExpected.forEach((elem) {
      test('input: ${elem['input']}', () {
        var _actual = encodeDeadfish(elem['input']);
        expect(_actual, elem['expectedOutput']);
      });
    });
  });

  group("Deadfish.decodeDeadfish:", () {
    List<Map<String, dynamic>> _inputsToExpected = [
      {'input' : null, 'expectedOutput' : ''},
      {'input' : '', 'expectedOutput' : ''},

      {'expectedOutput' : 'Hallo Welt', 'input' : 'iisiiiisiiiiiiiioiiiiiiiiiiiiiiiiiiiiiiiiioiiiiiiiiiiiooiiiodddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddoiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiioiiiiiiiiiiiiiioiiiiiiioiiiiiiiio'},
      {'expectedOutput' : 'H', 'input' : 'IISIIIISIIIIIIIIO'},
      {'expectedOutput' : '', 'input' : 'hallo'},
    ];

    _inputsToExpected.forEach((elem) {
      test('input: ${elem['input']}', () {
        var _actual = decodeDeadfish(elem['input']);
        expect(_actual, elem['expectedOutput']);
      });
    });
  });
}
