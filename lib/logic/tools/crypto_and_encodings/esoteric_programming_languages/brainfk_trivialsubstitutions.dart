// https://esolangs.org/wiki/Trivial_brainfuck_substitution

import 'package:gc_wizard/utils/common_utils.dart';

enum BrainfkTrivial {ALPHUCK, BINARYFUCK, BLUB, FLUFFLEPUFF, KENNYSPEAK, MORSEFUCK, NAK, OMAM, OOK, PIKALANG, ROADRUNNER, SCREAMCODE, TERNARY, ZZZ, CUSTOM}

Map brainfkTrivialSubstitutions = {
//  '' : {'>' : '', '<' : '', '+' : '', '-' : '', '.' : '', ',' : '', '[' : '', ']' : ''},
  'Omam' : {
    '>' : 'hold your horses now',
    '<' : 'sleep until the sun goes down',
    '+' : 'through the woods we ran',
    '-' : 'deep into the mountain sound',
    '.' : 'don' + "'" + 't listen to a word i say',
    ',' : 'the screams all sound the same',
    '[' : '	though the truth may vary',
    ']' : 'this ship will carry'},
  'Alphuck'      : {'>': 'a', '<': 'c', '+': 'e', '-': 'i', '.': 'j', ',': 'o', '[': 'p', ']': 's'},
  'BinaryFuck'  : {'>' : '010', '<' : '011', '+' : '000', '-' : '001', '.' : '100', ',' : '101', '[' : '110', ']' : '111'},
  'Ternary'     : {'>' : '01', '<' : '00', '+' : '11', '-' : '10', '.' : '20', ',' : '21', '[' : '02', ']' : '12'},
  'Kenny Speak'  : {'>' : 'mmp', '<' : 'mmm', '+' : 'mpp', '-' : 'pmm', '.' : 'fmm', ',' : 'fpm', '[' : 'mmf', ']' : 'mpf'},
  'MorseFuck'   : {'>' : '.--', '<' : '--.', '+' : '..-', '-' : '-..', '.' : '-.-', ',' : '.-.', '[' : '---', ']' : '...'},
  'Blub'        : {'>' : 'Blub. Blub?', '<' : 'Blub? Blub.', '+' : 'Blub. Blub.', '-' : 'Blub! Blub!', '.' : 'Blub! Blub.', ',' : 'Blub. Blub!', '[' : 'Blub! Blub?', ']' : 'Blub? Blub!'},
  'Ook'         : {'>' : 'Ook. Ook?', '<' : 'Ook? Ook.', '+' : 'Ook. Ook.', '-' : 'Ook! Ook!', '.' : 'Ook! Ook.', ',' : 'Ook. Ook!', '[' : 'Ook! Ook?', ']' : 'Ook? Ook!'},
  'Nak'         : {'>' : 'Nak. Nak?', '<' : 'Nak? Nak.', '+' : 'Nak. Nak.', '-' : 'Nak! Nak!', '.' : 'Nak! Nak.', ',' : 'Nak. Nak!', '[' : 'Nak! Nak?', ']' : 'Nak? Nak!'},
  'PikaLang'    : {'>' : 'pipi', '<' : 'pichu', '+' : 'pi', '-' : 'ka', '.' : 'pikachu', ',' : 'pikapi', '[' : 'pika', ']' : 'chu'},
  'Roadrunner'  : {'>' : 'meeP', '<' : 'Meep', '+' : 'mEEp', '-' : 'MeeP', '.' : 'MEEP', ',' : 'meep', '[' : 'mEEP', ']' : 'MEEp'},
  'ZZZ'         : {'>' : 'zz', '<' : '-zz', '+' : 'z', '-' : '-z', '.' : 'zzz', ',' : '-zzz', '[' : 'z+z', ']' : 'z-z'},
  'ScreamCode'  : {'>' : 'AAAH', '<' : 'AAAAGH', '+' : 'F*CK', '-' : 'SHIT', '.' : '!!!!!!', ',' : 'WHAT?', '[' : 'OW', ']' : 'OWIE'},
  'Fluffle Puff' : {'>' : 'b', '<' : 't', '+' : 'pf', '-' : 'bl', '.' : '!', ',' : '?', '[' : '*gasp*', ']' : '*pomf*'},
  'Custom'      : {'>' : '', '<' : '', '+' : '', '-' : '', '.' : '', ',' : '', '[' : '', ']' : ''},
};

Map<BrainfkTrivial, String> BRAINFK_TRIVIAL_LIST = {
  BrainfkTrivial.ALPHUCK : 'Alphuck',
  BrainfkTrivial.BINARYFUCK : 'BinaryFuck',
  BrainfkTrivial.BLUB : 'Blub',
  BrainfkTrivial.NAK : 'Nak',
  BrainfkTrivial.FLUFFLEPUFF : 'Fluffle Puff',
  BrainfkTrivial.KENNYSPEAK : 'Kenny Speak',
  BrainfkTrivial.MORSEFUCK : 'MorseFuck',
  BrainfkTrivial.OMAM : 'Omam',
  BrainfkTrivial.OOK : 'Ook',
  BrainfkTrivial.PIKALANG : 'PikaLang',
  BrainfkTrivial.ROADRUNNER : 'Roadrunner',
  BrainfkTrivial.SCREAMCODE : 'ScreamCode',
  BrainfkTrivial.TERNARY : 'Ternary',
  BrainfkTrivial.ZZZ : 'ZZZ',
  BrainfkTrivial.CUSTOM : 'Custom',
};
final BrainFkTrivial = switchMapKeyValue(BRAINFK_TRIVIAL_LIST);


