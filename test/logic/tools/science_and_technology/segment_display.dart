import "package:flutter_test/flutter_test.dart";
import 'package:gc_wizard/logic/tools/science_and_technology/segment_display.dart';
import 'package:gc_wizard/utils/constants.dart';

void main() {
  group("SegmentDisplay.encodeSegment:", () {
    List<Map<String, dynamic>> _inputsToExpected = [
      {'input' : null, 'segmentType' : SegmentDisplayType.SEVEN, 'expectedOutput': []},
      {'input' : '', 'segmentType' : SegmentDisplayType.SEVEN, 'expectedOutput': []},

      {'input' : 'A', 'segmentType' : SegmentDisplayType.SEVEN, 'expectedOutput': [['a', 'b', 'c', 'e', 'f', 'g']]},
      {'input' : 'AB', 'segmentType' : SegmentDisplayType.SEVEN, 'expectedOutput': [['a', 'b', 'c', 'e', 'f', 'g'], ['c', 'd', 'e', 'f', 'g']]},
      {'input' : '1', 'segmentType' : SegmentDisplayType.SEVEN, 'expectedOutput': [['b', 'c']]},

      {'input' : 'A', 'segmentType' : SegmentDisplayType.SIXTEEN, 'expectedOutput': [['a1', 'a2', 'b', 'c', 'e', 'f', 'g1', 'g2']]},
      {'input' : 'AB', 'segmentType' : SegmentDisplayType.SIXTEEN, 'expectedOutput': [['a1', 'a2', 'b', 'c', 'e', 'f', 'g1', 'g2'],['a1', 'a2', 'b', 'c', 'd1', 'd2', 'g2', 'i', 'l']]},
      {'input' : '1', 'segmentType' : SegmentDisplayType.SIXTEEN, 'expectedOutput': [['b', 'c','j']]},

      {'input' : '.', 'segmentType' : SegmentDisplayType.SEVEN, 'expectedOutput': [['dp']]},
      {'input' : '..', 'segmentType' : SegmentDisplayType.SEVEN, 'expectedOutput': [['dp'],['dp']]},
      {'input' : '1.', 'segmentType' : SegmentDisplayType.SEVEN, 'expectedOutput': [['b','c','dp']]},
      {'input' : '1..', 'segmentType' : SegmentDisplayType.SEVEN, 'expectedOutput': [['b','c','dp'],['dp']]},
      {'input' : '.1.', 'segmentType' : SegmentDisplayType.SEVEN, 'expectedOutput': [['dp'], ['b', 'c', 'dp']]},
      {'input' : '.1..', 'segmentType' : SegmentDisplayType.SEVEN, 'expectedOutput': [['dp'], ['b', 'c', 'dp'], ['dp']]},
      {'input' : '..1.', 'segmentType' : SegmentDisplayType.SEVEN, 'expectedOutput': [['dp'], ['dp'], ['b', 'c', 'dp']]},
      {'input' : '..1..', 'segmentType' : SegmentDisplayType.SEVEN, 'expectedOutput': [['dp'], ['dp'], ['b', 'c', 'dp'], ['dp']]},
      {'input' : '11.', 'segmentType' : SegmentDisplayType.SEVEN, 'expectedOutput': [['b', 'c'], ['b', 'c', 'dp']]},
      {'input' : '1.1', 'segmentType' : SegmentDisplayType.SEVEN, 'expectedOutput': [['b', 'c', 'dp'], ['b', 'c']]},
      {'input' : '1.1.', 'segmentType' : SegmentDisplayType.SEVEN, 'expectedOutput': [['b', 'c', 'dp'], ['b', 'c', 'dp']]},
      {'input' : '.1.1.', 'segmentType' : SegmentDisplayType.SEVEN, 'expectedOutput': [['dp'], ['b', 'c', 'dp'], ['b', 'c', 'dp']]},
      {'input' : '..1.1.', 'segmentType' : SegmentDisplayType.SEVEN, 'expectedOutput': [['dp'], ['dp'], ['b', 'c', 'dp'], ['b', 'c', 'dp']]},
      {'input' : '..1.1..', 'segmentType' : SegmentDisplayType.SEVEN, 'expectedOutput': [['dp'], ['dp'], ['b', 'c', 'dp'], ['b', 'c', 'dp'], ['dp']]},
      {'input' : '1..1', 'segmentType' : SegmentDisplayType.SEVEN, 'expectedOutput': [['b', 'c', 'dp'], ['dp'], ['b', 'c']]},
      {'input' : '1..1.', 'segmentType' : SegmentDisplayType.SEVEN, 'expectedOutput': [['b', 'c', 'dp'], ['dp'], ['b', 'c', 'dp']]},
      {'input' : '1..1..', 'segmentType' : SegmentDisplayType.SEVEN, 'expectedOutput': [['b', 'c', 'dp'], ['dp'], ['b', 'c', 'dp'], ['dp']]},
      {'input' : '..1..1..', 'segmentType' : SegmentDisplayType.SEVEN, 'expectedOutput': [['dp'], ['dp'], ['b', 'c', 'dp'], ['dp'], ['b', 'c', 'dp'], ['dp']]},
      {'input' : '1.11', 'segmentType' : SegmentDisplayType.SEVEN, 'expectedOutput': [['b', 'c', 'dp'], ['b', 'c'], ['b', 'c']]},
      {'input' : '1.11.', 'segmentType' : SegmentDisplayType.SEVEN, 'expectedOutput': [['b', 'c', 'dp'], ['b', 'c'], ['b', 'c', 'dp']]},

      {'input' : ' ', 'segmentType' : SegmentDisplayType.SEVEN, 'expectedOutput': [[]]},
      {'input' : '  ', 'segmentType' : SegmentDisplayType.SEVEN, 'expectedOutput': [[],[]]},
      {'input' : ' .', 'segmentType' : SegmentDisplayType.SEVEN, 'expectedOutput': [['dp']]},
      {'input' : '  .', 'segmentType' : SegmentDisplayType.SEVEN, 'expectedOutput': [[],['dp']]},
      {'input' : '1 1', 'segmentType' : SegmentDisplayType.SEVEN, 'expectedOutput': [['b', 'c'], [], ['b', 'c']]},
    ];

    _inputsToExpected.forEach((elem) {
      test('input: ${elem['input']}, segmentType: ${elem['segmentType']}', () {
        var _actual = encodeSegment(elem['input'], elem['segmentType']);
        expect(_actual, elem['expectedOutput']);
      });
    });
  });

  group("SegmentDisplay.decodeSegment:", () {
    List<Map<String, dynamic>> _inputsToExpected = [
      {'input' : null, 'segmentType' : SegmentDisplayType.SEVEN, 'expectedOutput': {'displays':[], 'text': ''}},
      {'input' : '', 'segmentType' : SegmentDisplayType.SEVEN, 'expectedOutput': {'displays':[], 'text': ''}},

      {'input' : 'bc', 'segmentType' : SegmentDisplayType.SEVEN, 'expectedOutput': {'displays':[['b','c']], 'text': '1'}},
      {'input' : 'bc bc', 'segmentType' : SegmentDisplayType.SEVEN, 'expectedOutput': {'displays':[['b','c'],['b','c']], 'text': '11'}},
      {'input' : 'bbcc', 'segmentType' : SegmentDisplayType.SEVEN, 'expectedOutput': {'displays':[['b','c']], 'text': '1'}},

      {'input' : 'cb', 'segmentType' : SegmentDisplayType.SEVEN, 'expectedOutput': {'displays':[['b','c']], 'text': '1'}},

      {'input' : 'ba', 'segmentType' : SegmentDisplayType.SEVEN, 'expectedOutput': {'displays':[['a','b']], 'text': UNKNOWN_ELEMENT}},
      {'input' : 'a', 'segmentType' : SegmentDisplayType.SEVEN, 'expectedOutput': {'displays':[['a']], 'text': UNKNOWN_ELEMENT}},
      {'input' : 'bc a', 'segmentType' : SegmentDisplayType.SEVEN, 'expectedOutput': {'displays':[['b','c'],['a']], 'text': '1' + UNKNOWN_ELEMENT}},
      {'input' : 'a cb', 'segmentType' : SegmentDisplayType.SEVEN, 'expectedOutput': {'displays':[['a'],['b','c']], 'text': UNKNOWN_ELEMENT + '1'}},
      {'input' : 'a CB', 'segmentType' : SegmentDisplayType.SEVEN, 'expectedOutput': {'displays':[['a'],['b','c']], 'text': UNKNOWN_ELEMENT + '1'}},

      {'input' : 'z', 'segmentType' : SegmentDisplayType.SEVEN, 'expectedOutput': {'displays':[], 'text': ''}},
      {'input' : 'z bc', 'segmentType' : SegmentDisplayType.SEVEN, 'expectedOutput': {'displays':[['b','c']], 'text': '1'}},
      {'input' : 'bc z', 'segmentType' : SegmentDisplayType.SEVEN, 'expectedOutput': {'displays':[['b','c']], 'text': '1'}},
      {'input' : 'bczbc', 'segmentType' : SegmentDisplayType.SEVEN, 'expectedOutput': {'displays':[['b','c'],['b','c']], 'text': '11'}},
      {'input' : 'bczzz zzzbc', 'segmentType' : SegmentDisplayType.SEVEN, 'expectedOutput': {'displays':[['b','c'],['b','c']], 'text': '11'}},

      {'input' : 'a1', 'segmentType' : SegmentDisplayType.SIXTEEN, 'expectedOutput': {'displays':[['a1']], 'text': UNKNOWN_ELEMENT}},
      {'input' : 'a1a1', 'segmentType' : SegmentDisplayType.SIXTEEN, 'expectedOutput': {'displays':[['a1']], 'text': UNKNOWN_ELEMENT}},
      {'input' : 'ba1a2c', 'segmentType' : SegmentDisplayType.SIXTEEN, 'expectedOutput': {'displays':[['a1','a2','b','c']], 'text': '7'}},

      {'input' : 'b1', 'segmentType' : SegmentDisplayType.SIXTEEN, 'expectedOutput': {'displays':[], 'text': ''}},
      {'input' : 'a1 b1', 'segmentType' : SegmentDisplayType.SIXTEEN, 'expectedOutput': {'displays':[['a1']], 'text': UNKNOWN_ELEMENT}},
      {'input' : 'a1 b1a2', 'segmentType' : SegmentDisplayType.SIXTEEN, 'expectedOutput': {'displays':[['a1'],['a2']], 'text': UNKNOWN_ELEMENT * 2}},
      {'input' : 'a3', 'segmentType' : SegmentDisplayType.SIXTEEN, 'expectedOutput': {'displays':[], 'text': ''}},
      {'input' : 'b1a', 'segmentType' : SegmentDisplayType.SIXTEEN, 'expectedOutput': {'displays':[], 'text': ''}},
      {'input' : '1a', 'segmentType' : SegmentDisplayType.SIXTEEN, 'expectedOutput': {'displays':[], 'text': ''}},
      {'input' : '1a1', 'segmentType' : SegmentDisplayType.SIXTEEN, 'expectedOutput': {'displays': [['a1']], 'text': '<?>'}},

      {'input' : 'dp', 'segmentType' : SegmentDisplayType.SEVEN, 'expectedOutput': {'displays':[['dp']], 'text': '.'}},
      {'input' : 'dpdp', 'segmentType' : SegmentDisplayType.SEVEN, 'expectedOutput': {'displays':[['dp']], 'text': '.'}},
      {'input' : 'dp dp', 'segmentType' : SegmentDisplayType.SEVEN, 'expectedOutput': {'displays': [['dp'], ['dp']], 'text': '..'}},
      {'input' : 'bcdp', 'segmentType' : SegmentDisplayType.SEVEN, 'expectedOutput': {'displays': [['b', 'c', 'dp']], 'text': '1.'}},
      {'input' : 'bc dp', 'segmentType' : SegmentDisplayType.SEVEN, 'expectedOutput': {'displays': [['b', 'c'], ['dp']], 'text': '1.'}},
      {'input' : 'bcdp dp', 'segmentType' : SegmentDisplayType.SEVEN, 'expectedOutput': {'displays': [['b', 'c', 'dp'], ['dp']], 'text': '1..'}},
      {'input' : 'dpcb bdpc', 'segmentType' : SegmentDisplayType.SEVEN, 'expectedOutput': {'displays': [['b', 'c', 'dp'], ['b', 'c', 'dp']], 'text': '1.1.'}},
      {'input' : 'dp bc', 'segmentType' : SegmentDisplayType.SEVEN, 'expectedOutput': {'displays': [['dp'], ['b', 'c']], 'text': '.1'}},
      {'input' : 'dp bcdp', 'segmentType' : SegmentDisplayType.SEVEN, 'expectedOutput': {'displays': [['dp'], ['b', 'c', 'dp']], 'text': '.1.'}},
      {'input' : 'dp bcdpdp', 'segmentType' : SegmentDisplayType.SEVEN, 'expectedOutput': {'displays': [['dp'], ['b', 'c', 'dp']], 'text': '.1.'}},
      {'input' : 'dp bcdp dp', 'segmentType' : SegmentDisplayType.SEVEN, 'expectedOutput': {'displays': [['dp'], ['b', 'c', 'dp'], ['dp']], 'text': '.1..'}},
    ];

    _inputsToExpected.forEach((elem) {
      test('input: ${elem['input']}, segmentType: ${elem['segmentType']}', () {
        var _actual = decodeSegment(elem['input'], elem['segmentType']);
        expect(_actual, elem['expectedOutput']);
      });
    });
  });
}