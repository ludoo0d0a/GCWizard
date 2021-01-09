import 'package:gc_wizard/logic/tools/science_and_technology/number_sequence.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/base/numbersequences_check.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/base/numbersequences_contains.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/base/numbersequences_digits.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/base/numbersequences_nthnumber.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/base/numbersequences_range.dart';

class NumberSequenceMersenneFermatCheckNumber extends NumberSequenceCheckNumber {
  NumberSequenceMersenneFermatCheckNumber() : super(mode: NumberSequencesMode.MERSENNE_FERMAT, maxIndex: 111111);
}

class NumberSequenceMersenneFermatDigits extends NumberSequenceDigits {
  NumberSequenceMersenneFermatDigits() : super(mode: NumberSequencesMode.MERSENNE_FERMAT, maxDigits: 111);
}

class NumberSequenceMersenneFermatRange extends NumberSequenceRange {
  NumberSequenceMersenneFermatRange() : super(mode: NumberSequencesMode.MERSENNE_FERMAT, maxIndex: 111111);
}

class NumberSequenceMersenneFermatNthNumber extends NumberSequenceNthNumber {
  NumberSequenceMersenneFermatNthNumber() : super(mode: NumberSequencesMode.MERSENNE_FERMAT, maxIndex: 111111);
}

class NumberSequenceMersenneFermatContains extends NumberSequenceContains {
  NumberSequenceMersenneFermatContains() : super(mode: NumberSequencesMode.MERSENNE_FERMAT, maxIndex: 111111);
}