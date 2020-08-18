import "package:flutter_test/flutter_test.dart";
import 'package:gc_wizard/logic/tools/science_and_technology/dna.dart';

void main() {
  group("DNA.encodeRNANucleobaseSequence:", () {
    List<Map<String, dynamic>> _inputsToExpected = [
      {'input' : null, 'expectedOutput' : ''},
      {'input' : '', 'expectedOutput' : ''},

      {'input' : 'HALLO', 'expectedOutput' : 'CAUGCUUUAUUA'},
      {'input' : 'THE WORLD IS NOT FAIR', 'expectedOutput' : 'ACUCAUGAAUGGCGAUUAGAUAUUUCUAAUACUUUCGCUAUUCGA'},
    ];

    _inputsToExpected.forEach((elem) {
      test('input: ${elem['input']}', () {
        var _actual = encodeRNANucleobaseSequence(elem['input']);
        expect(_actual, elem['expectedOutput']);
      });
    });
  });

  group("DNA.decodeRNANucleobaseSequence:", () {
    List<Map<String, dynamic>> _inputsToExpected = [
      {'input' : null, 'expectedOutput' : ''},
      {'input' : '', 'expectedOutput' : ''},

      {'expectedOutput' : 'HALL', 'input' : 'CAUGCUUUAUUA'},
      {'expectedOutput' : 'THEWRLDISNTFAIR', 'input' : 'ACUCAUGAAUGGCGAUUAGAUAUUUCUAAUACUUUCGCUAUUCGA'},
      {'expectedOutput' : 'THEWRLDISNTFAI', 'input' : 'ACUCAUGAAUGGCGAUUAGAUAUUUCUAAUACUUUCGCUAUUC'},
    ];

    _inputsToExpected.forEach((elem) {
      test('input: ${elem['input']}', () {
        var _actual = decodeRNANucleobaseSequence(elem['input']).map((e) => e.symbolShort).join();
        expect(_actual, elem['expectedOutput']);
      });
    });
  });

  group("DNA.decodeRNANucleobaseSequenceWithStop:", () {
    List<Map<String, dynamic>> _inputsToExpected = [
      {'expectedOutput' : [NucleobaseSequenceType.STOP, NucleobaseSequenceType.NORMAL, NucleobaseSequenceType.START], 'input' : 'UAACACGUG'},
    ];

    _inputsToExpected.forEach((elem) {
      test('input: ${elem['input']}', () {
        var _actual = decodeRNANucleobaseSequence(elem['input']).map((e) => e.type).toList();
        expect(_actual, elem['expectedOutput']);
      });
    });
  });

  group("DNA.encodeDNANucleobaseSequence:", () {
    List<Map<String, dynamic>> _inputsToExpected = [
      {'input' : null, 'expectedOutput' : ''},
      {'input' : '', 'expectedOutput' : ''},

      {'input' : 'HALLO', 'expectedOutput' : 'CATGCTTTATTA'},
      {'input' : 'THE WORLD IS NOT FAIR', 'expectedOutput' : 'ACTCATGAATGGCGATTAGATATTTCTAATACTTTCGCTATTCGA'},
    ];

    _inputsToExpected.forEach((elem) {
      test('input: ${elem['input']}', () {
        var _actual = encodeDNANucleobaseSequence(elem['input']);
        expect(_actual, elem['expectedOutput']);
      });
    });
  });

  group("DNA.decodeDNANucleobaseSequence:", () {
    List<Map<String, dynamic>> _inputsToExpected = [
      {'input' : null, 'expectedOutput' : ''},
      {'input' : '', 'expectedOutput' : ''},

      {'expectedOutput' : 'HALL', 'input' : 'CATGCTTTATTA'},
      {'expectedOutput' : 'THEWRLDISNTFAIR', 'input' : 'ACTCATGAATGGCGATTAGATATTTCTAATACTTTCGCTATTCGA'},
      {'expectedOutput' : 'THEWRLDISNTFAI', 'input' : 'ACTCATGAATGGCGATTAGATATTTCTAATACTTTCGCTATTC'},

      {'expectedOutput' : 'THEWRLDISNTFAI', 'input' : 'THIS IS MY WORLD'},
    ];

    _inputsToExpected.forEach((elem) {
      test('input: ${elem['input']}', () {
        var _actual = decodeDNANucleobaseSequence(elem['input']).map((e) => e.symbolShort).join();
        expect(_actual, elem['expectedOutput']);
      });
    });
  });

  group("DNA.encodeRNASymbolLong:", () {
    List<Map<String, dynamic>> _inputsToExpected = [
      {'input' : null, 'expectedOutput' : ''},
      {'input' : '', 'expectedOutput' : ''},

      {'input' : 'HALLO', 'expectedOutput' : 'HISALALEULEU'},
      {'input' : 'THE WORLD IS NOT FAIR', 'expectedOutput' : 'THRHISGLUTRPARGLEUASPILESERASNTHRPHEALAILEARG'},
    ];

    _inputsToExpected.forEach((elem) {
      test('input: ${elem['input']}', () {
        var _actual = encodeRNASymbolLong(elem['input']);
        expect(_actual, elem['expectedOutput']);
      });
    });
  });

  group("DNA.decodeRNASymbolLong:", () {
    List<Map<String, dynamic>> _inputsToExpected = [
      {'input' : null, 'expectedOutput' : ''},
      {'input' : '', 'expectedOutput' : ''},

      {'expectedOutput' : '', 'input' : 'H'},
      {'expectedOutput' : '', 'input' : 'HI'},
      {'expectedOutput' : 'H', 'input' : 'HIS'},
      {'expectedOutput' : 'H', 'input' : 'HISA'},
      {'expectedOutput' : 'H', 'input' : 'HISAL'},
      {'expectedOutput' : 'HA', 'input' : 'HISALA'},
      {'expectedOutput' : 'HA', 'input' : 'HISALAL'},
      {'expectedOutput' : 'HA', 'input' : 'HISALALE'},
      {'expectedOutput' : 'HA', 'input' : 'HISALALEI'},
      {'expectedOutput' : 'HA', 'input' : 'His Ala, Lei'},
      {'expectedOutput' : 'HA', 'input' : 'HISALALCY'},
      {'expectedOutput' : 'HAC', 'input' : 'HISALALCYS'},
      {'expectedOutput' : 'HAL', 'input' : 'HISALALEU'},
      {'expectedOutput' : 'HALL', 'input' : 'HisalaLeULeu'},
      {'expectedOutput' : 'THEWRLDISNTFAIR', 'input' : 'THRHISGLUTRPARGLEUASPILESERASNTHRPHEALAILEARG'},
    ];

    _inputsToExpected.forEach((elem) {
      test('input: ${elem['input']}', () {
        var _actual = decodeRNASymbolLong(elem['input']);
        expect(_actual, elem['expectedOutput']);
      });
    });
  });
}