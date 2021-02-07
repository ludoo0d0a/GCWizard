import 'package:gc_wizard/utils/common_utils.dart';
import 'package:gc_wizard/utils/constants.dart';

enum BrailleLanguage {DEU, ENG}

Map<BrailleLanguage, String> BRAILLE_LANGUAGES = {
  BrailleLanguage.DEU: 'common_language_german',
  BrailleLanguage.ENG: 'common_language_english',
};


final Map<String, List<String>> _charsToSegmentsDEU = {
  ' ' : [],
  '1' : ['a'],
  '2' : ['a', 'c'],
  '3' : ['a', 'b'],
  '4' : ['a', 'b', 'd'],
  '5' : ['a', 'd'],
  '6' : ['a', 'b', 'c'],
  '7' : ['a', 'b', 'c', 'd'],
  '8' : ['a', 'c', 'd'],
  '9' : ['b', 'c'],
  '0' : ['b', 'c', 'd'],
  'A' : ['a'],
  'B' : ['a', 'c'],
  'C' : ['a', 'b'],
  'D' : ['a', 'b', 'd'],
  'E' : ['a', 'd'],
  'F' : ['a', 'b', 'c'],
  'G' : ['a', 'b', 'c', 'd'],
  'H' : ['a', 'c', 'd'],
  'I' : ['b', 'c'],
  'J' : ['b', 'c', 'd'],
  'K' : ['a', 'e'],
  'L' : ['a', 'c', 'e'],
  'M' : ['a', 'b', 'e'],
  'N' : ['a', 'b', 'd', 'e'],
  'O' : ['a', 'd', 'e'],
  'P' : ['a', 'b', 'c', 'e'],
  'Q' : ['a', 'b', 'c', 'd', 'e'],
  'R' : ['a', 'c', 'd', 'e'],
  'S' : ['b', 'c', 'e'],
  'T' : ['b', 'c', 'd', 'e'],
  'U' : ['a', 'e', 'f'],
  'V' : ['a', 'c', 'e', 'e'],
  'W' : ['b', 'c', 'd', 'f'],
  'X' : ['a', 'b', 'e', 'f'],
  'Y' : ['a', 'b', 'd', 'e', 'f'],
  'Z' : ['a', 'd', 'e', 'f'],
  'Ä' : ['b', 'd', 'e'],
  'Ö' : ['b', 'c', 'f'],
  'Ü' : ['a', 'c', 'd', 'f'],
  'ß' : ['b', 'c', 'e', 'f'],
  'ST' : ['b', 'c', 'd', 'e', 'f'],
  'AU' : ['a', 'f'],
  'EU' : ['a', 'c', 'f'],
  'EI' : ['a', 'b', 'f'],
  'ÄU' : ['b', 'e'],
  'IE' : ['b', 'e', 'e'],
  'CH' : ['a', 'b', 'd', 'f'],
  'SCH' : ['a', 'd', 'f'],
  ',' : ['c'],
  ';' : ['c', 'e'],
  ':' : ['c', 'd'],
  '.' : ['e'],
  '?' : ['c', 'f'],
  '+' : ['c', 'd', 'e'],
  '#' : ['b', 'd', 'e', 'f'], // number follows
  '=' : ['c', 'd', 'e', 'f'],
  '-' : ['e', 'f'],
  '§' : ['b', 'e', 'f'],
  '"' : ['c', 'e', 'f'],
  //'"' : ['d','e', 'f'],
  "'" : ['f'],
  '~' : ['d'],
  '>' : ['b', 'd'],
  '<' : ['d', 'f'],
  '/' : ['c', 'd', 'f'],
  '\$' : ['b', 'f'],
  '_' : ['b', 'd', 'f'],

};

final Map<String, List<String>> _charsToSegmentsENG = {
  ' ' : [],
  '1' : ['a'],
  '2' : ['a', 'c'],
  '3' : ['a', 'b'],
  '4' : ['a', 'b', 'd'],
  '5' : ['a', 'd'],
  '6' : ['a', 'b', 'c'],
  '7' : ['a', 'b', 'c', 'd'],
  '8' : ['a', 'c', 'd'],
  '9' : ['b', 'c'],
  '0' : ['b', 'c', 'd'],
  'A' : ['a'],
  'B' : ['a', 'c'],
  'C' : ['a', 'b'],
  'D' : ['a', 'b', 'd'],
  'E' : ['a', 'd'],
  'F' : ['a', 'b', 'c'],
  'G' : ['a', 'b', 'c', 'd'],
  'H' : ['a', 'c', 'd'],
  'I' : ['b', 'c'],
  'J' : ['b', 'c', 'd'],
  'K' : ['a', 'e'],
  'L' : ['a', 'c', 'e'],
  'M' : ['a', 'b', 'e'],
  'N' : ['a', 'b', 'd', 'e'],
  'O' : ['a', 'd', 'e'],
  'P' : ['a', 'b', 'c', 'e'],
  'Q' : ['a', 'b', 'c', 'd', 'e'],
  'R' : ['a', 'c', 'd', 'e'],
  'S' : ['b', 'c', 'e'],
  'T' : ['b', 'c', 'd', 'e'],
  'U' : ['a', 'e', 'f'],
  'V' : ['a', 'c', 'e', 'e'],
  'W' : ['b', 'c', 'd', 'f'],
  'X' : ['a', 'b', 'e', 'f'],
  'Y' : ['a', 'b', 'd', 'e', 'f'],
  'Z' : ['a', 'd', 'e', 'f'],
  'AND' : ['a', 'b', 'c', 'e', 'f'],
  'FOR' : ['a', 'b', 'c', 'd', 'e', 'f'],
  'OF' : ['a', 'c', 'd', 'e', 'f'],
  'THE' : ['b', 'c', 'e', 'f'],
  'WITH' : ['b', 'c', 'd', 'e', 'f'],
  'CH' : ['a', 'f'],
  'GH' : ['a', 'c', 'f'],
  'SH' : ['a', 'b', 'f'],
  'TH' : ['a', 'b', 'd', 'f'],
  'WH' : ['a', 'd', 'f'],
  'ED' : ['a', 'b', 'c', 'f'],
  'ER' : ['a', 'b', 'c', 'd', 'f'],
  'OU' : ['a', 'c', 'd', 'f'],
  'OW' : ['b', 'c', 'f'],
  'ST' : ['b', 'e'],
  'AR' : ['b', 'd', 'e'],
  'ING' : ['b', 'e', 'f'],
  'BLE' : ['b', 'd', 'e', 'f'],
  'BB' : ['c', 'e'],
  'CC' : ['c', 'd'],
  'EN' : ['c', 'f'],
  'FF' : ['c', 'd', 'e'],
  'IN' : ['d', 'e'],
  ',' : ['c'],
  ';' : ['c', 'e'],
  ':' : ['c', 'd'],
  '.' : ['c', 'd', 'f'],
  '?' : ['c', 'e', 'f'],
  '+' : ['c', 'd', 'e'],
  '#' : ['b', 'd', 'e', 'f'], // number follows
  '=' : ['c', 'd', 'e', 'f'],
  '-' : ['e', 'f'],
  '§' : ['b', 'e', 'f'],
  '"' : ['c', 'e', 'f'],
  //'"' : ['d','e', 'f'],
  "'" : ['f'],
  '~' : ['d'],
  '>' : ['b', 'd'],
  '<' : ['d', 'f'],
  '/' : ['b', 'e'],
  '_' : ['e', 'f'],
};

var _segmentsToCharsDEU = switchMapKeyValue(_charsToSegmentsDEU);
var _segmentsToCharsENG = switchMapKeyValue(_charsToSegmentsENG);

final Numbers = {'0', '1', '2', '3', '4', '5', '6', '7', '8', '9'};

List<List<String>> encodeBraille(String input, BrailleLanguage language) {
  if (input == null)
    return [];

  var _charsToSegments;

  switch (language) {
    case BrailleLanguage.DEU: _charsToSegments = _charsToSegmentsDEU; break;
    case BrailleLanguage.ENG: _charsToSegments = _charsToSegmentsENG; break;
  }

  List<String> inputs = input.split('');
  List<List<String>> result = new List<List<String>>();
  for (int i = 0; i < inputs.length; i++){
    if (language == BrailleLanguage.DEU) {
      if (Numbers.contains(inputs[i])) {
        result.add(_charsToSegments['#']);
        result.add(_charsToSegments[inputs[i]]);
      }
      else {
        if (inputs[i] == 'S' && i < inputs.length - 1 && inputs[i + 1] == 'T') {
          result.add(_charsToSegments['ST']);
          i++;
        } else
        if (inputs[i] == 'A' && i < inputs.length - 1 && inputs[i + 1] == 'U') {
          result.add(_charsToSegments['AU']);
          i++;
        } else
        if (inputs[i] == 'E' && i < inputs.length - 1 && inputs[i + 1] == 'U') {
          result.add(_charsToSegments['EU']);
          i++;
        } else
        if (inputs[i] == 'E' && i < inputs.length - 1 && inputs[i + 1] == 'I') {
          result.add(_charsToSegments['EI']);
          i++;
        } else
        if (inputs[i] == 'Ä' && i < inputs.length - 1 && inputs[i + 1] == 'U') {
          result.add(_charsToSegments['ÄU']);
          i++;
        } else
        if (inputs[i] == 'I' && i < inputs.length - 1 && inputs[i + 1] == 'E') {
          result.add(_charsToSegments['IE']);
          i++;
        } else
        if (inputs[i] == 'C' && i < inputs.length - 1 && inputs[i + 1] == 'H') {
          result.add(_charsToSegments['CH']);
          i++;
        } else
        if (inputs[i] == 'S' && i < inputs.length - 2 && inputs[i + 1] == 'C' && inputs[i + 2] == 'H') {
          result.add(_charsToSegments['SCH']);
          i = i + 2;
        } else
          result.add(_charsToSegments[inputs[i]]);
      }
    }
    else {
      if (Numbers.contains(inputs[i])) {
        result.add(_charsToSegments['#']);
        result.add(_charsToSegments[inputs[i]]);
      }
      else {
        if (inputs[i] == 'S' && i < inputs.length - 1 && inputs[i + 1] == 'H') {
          result.add(_charsToSegments['SH']);
          i++;
        } else
        if (inputs[i] == 'A' && i < inputs.length - 1 && inputs[i + 1] == 'U') {
          result.add(_charsToSegments['AU']);
          i++;
        } else
        if (inputs[i] == 'E' && i < inputs.length - 1 && inputs[i + 1] == 'U') {
          result.add(_charsToSegments['EU']);
          i++;
        } else
        if (inputs[i] == 'E' && i < inputs.length - 1 && inputs[i + 1] == 'I') {
          result.add(_charsToSegments['EI']);
          i++;
        } else
        if (inputs[i] == 'Ä' && i < inputs.length - 1 && inputs[i + 1] == 'U') {
          result.add(_charsToSegments['ÄU']);
          i++;
        } else
        if (inputs[i] == 'I' && i < inputs.length - 1 && inputs[i + 1] == 'E') {
          result.add(_charsToSegments['IE']);
          i++;
        } else
        if (inputs[i] == 'C' && i < inputs.length - 1 && inputs[i + 1] == 'H') {
          result.add(_charsToSegments['CH']);
          i++;
        } else
        if (inputs[i] == 'S' && i < inputs.length - 2 && inputs[i + 1] == 'C' &&
            inputs[i + 2] == 'H') {
          result.add(_charsToSegments['SCH']);
          i = i + 2;
        } else
          result.add(_charsToSegments[inputs[i]]);
      }
    }
  }
  return result;
}

Map<String, dynamic> decodeBraille(List<String> inputs, BrailleLanguage language) {
  if (inputs == null || inputs.length == 0)
    return {'displays': [[]], 'chars': [0]};

  var displays = <List<String>>[];
  var _segmentsToChars;
  switch (language) {
    case BrailleLanguage.DEU:
      _segmentsToChars = _segmentsToCharsDEU;
      _segmentsToChars[['d', 'e', 'f']] = '"';
      break;
    case BrailleLanguage.ENG: _segmentsToChars = _segmentsToCharsENG; break;
  }

  bool numberFollows = false;

  List<String> text = inputs
      .where((input) => input != null)
      .map((input) {
        var char = '';
        var charH = '';
        var display = <String>[];
        input.split('').forEach((element) {
          display.add(element);
        });
        if (_segmentsToChars.map((key, value) => MapEntry(key.join(), value.toString()))[input.split('').join()] == null)
          char = char + UNKNOWN_ELEMENT;
        else {
          charH = _segmentsToChars.map((key, value) => MapEntry(key.join(), value.toString()))[input.split('').join()];
          if (charH == '#')
            numberFollows = !numberFollows;
          else {
            if (numberFollows && charH == 'A') charH = '1';
            else if (numberFollows && charH == 'B') charH = '2';
            else if (numberFollows && charH == 'C') charH = '3';
            else if (numberFollows && charH == 'D') charH = '4';
            else if (numberFollows && charH == 'E') charH = '5';
            else if (numberFollows && charH == 'F') charH = '6';
            else if (numberFollows && charH == 'G') charH = '7';
            else if (numberFollows && charH == 'H') charH = '8';
            else if (numberFollows && charH == 'I') charH = '9';
            else if (numberFollows && charH == 'J') charH = '0';
            char = char + charH;
            numberFollows = false;
          }
        }

        displays.add(display);

        return char;
      }).toList();


  return {'displays': displays, 'chars': text};
}

