import 'package:gc_wizard/utils/common_utils.dart';
import 'package:gc_wizard/utils/constants.dart';

final Map<String, List<String>> _charsToSegments = {
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
  '!' : ['c', 'd', 'e'],
  '#' : ['b', 'd', 'e', 'f'], // number follows
  '(' : ['c', 'd', 'e', 'f'],
  '-' : ['e', 'f'],
  '§' : ['b', 'e', 'f'],
  '"' : ['c','e', 'f'],
  //'"' : ['d','e', 'f'],
  "'" : ['f'],
};

var _segmentsToChars = switchMapKeyValue(_charsToSegments);

List<List<String>> encodeBraille(String input) {
  if (input == null)
    return [];

  return input.split('').map((digit) {
    return _charsToSegments[digit];
  }).toList();
}

Map<String, dynamic> decodeBraille(List<String> inputs) {
  if (inputs == null || inputs.length == 0)
    return {'displays': [[]], 'chars': [0]};

   var displays = <List<String>>[];
   _segmentsToChars[['d','e', 'f']] = '"';
   bool numberFollows = false;

  List<String> text = inputs
      .where((input) => input != null)
      .map((input) {
    var char = '';
    var charH = '';
    var display = <String>[];
    display.add(input);
    if (_characterFromSegmentList(input.split('')) == null)
      char = char + UNKNOWN_ELEMENT;
    else {
      charH = _characterFromSegmentList(input.split(''));
      if (charH == '#')
        numberFollows = !numberFollows;
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
      char = char + _characterFromSegmentList(input.split(''));
    }

    displays.add(display);

    return char;
  }).toList();


  return {'displays': displays, 'chars': text};
}

_characterFromSegmentList(List<String> segments) {
  return _segmentsToChars.map((key, value) => MapEntry(key.join(), value.toString()))[segments.join()];
}
