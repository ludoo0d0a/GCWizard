import 'dart:math';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/vigenere.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/vigenere_breaker/guballa.de/breaker.dart' as guballa;
import 'package:gc_wizard/logic/tools/crypto_and_encodings/substitution_breaker/guballa.de/breaker.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/vigenere_breaker/bigrams/bigrams.dart';

import 'package:gc_wizard/logic/tools/crypto_and_encodings/vigenere_breaker/trigrams/trigrams.dart';


enum VigenereBreakerType{VIGENERE, AUTOKEYVIGENERE, BEAUFORT}
enum VigenereBreakerAlphabet{ENGLISH, GERMAN, SPANISH, FRENCH}
enum VigenereBreakerErrorCode{OK, KEY_LENGTH, KEY_TOO_LONG, CONSOLIDATE_PARAMETER, TEXT_TOO_SHORT, ALPHABET_TOO_LONG, WRONG_GENERATE_TEXT}

class VigenereBreakerResult {
  String plaintext;
  String key;
  double fitness;
  double fitnessFiltered;
  String alphabet;
  VigenereBreakerErrorCode errorCode;

  VigenereBreakerResult({
    this.plaintext = '',
    this.key = '',
    this.fitness = 0.0,
    this.fitnessFiltered = 0.0,
    this.alphabet = '',
    this.errorCode = VigenereBreakerErrorCode.OK
  });
}

const DEFAULT_ALPHABET = "abcdefghijklmnopqrstuvwxyz";

Future<VigenereBreakerResult> break_cipher(String input, VigenereBreakerType vigenereBreakerType, VigenereBreakerAlphabet alphabet, int keyLengthMin, int keyLengthMax) async {
  if (input == null || input == '')
    return VigenereBreakerResult(errorCode: VigenereBreakerErrorCode.OK);

  if (((keyLengthMin < 3) || (keyLengthMin > 1000)) || ((keyLengthMax < 1) || (keyLengthMax > 1000)))
    // key length not in the valid range 3..1000
    return VigenereBreakerResult(errorCode: VigenereBreakerErrorCode.KEY_LENGTH);

  var bigrams = getBigrams(alphabet);
  //var trigrams = getTrigrams(alphabet);

  var vigenereSquare = _createVigenereSquare(bigrams.alphabet.length, vigenereBreakerType == VigenereBreakerType.BEAUFORT);
  var cipher_bin = List<int>();
  var resultList = List <VigenereBreakerResult>();
  VigenereBreakerResult best_result = null;
  String out1 = '';
try {
  iterateText(input, bigrams.alphabet).forEach((char) {cipher_bin.add(char);});

  if (cipher_bin.length < 3)
    return VigenereBreakerResult(errorCode: VigenereBreakerErrorCode.TEXT_TOO_SHORT);

  if ((keyLengthMin > cipher_bin.length) && (keyLengthMax >  cipher_bin.length))
    // Minimum key length must be equal or greater than the length of the ciphertext
    return VigenereBreakerResult(errorCode: VigenereBreakerErrorCode.KEY_TOO_LONG);

  keyLengthMax = min(keyLengthMax, cipher_bin.length);

  for (int keyLength = keyLengthMin; keyLength <= keyLengthMax; keyLength++) {
    var breakerResult = guballa.break_vigenere(cipher_bin, keyLength, vigenereSquare, bigrams.bigrams);
    var result = VigenereBreakerResult();

    resultList.add(result);

    result.key = breakerResult.key.map((x) => bigrams.alphabet[x]).join();
    result.key = decryptVigenere(''.padRight(result.key.length, bigrams.alphabet[0]), result.key, false);

    result.plaintext = decryptVigenere(input, result.key, false);
    result.fitness = calc_fitnessBigrams(result.plaintext, bigrams);
  }
  best_result = bestSolution(resultList);
} on Exception
  {
    return VigenereBreakerResult(errorCode: VigenereBreakerErrorCode.WRONG_GENERATE_TEXT);
  };

  for (var i = 0; i < resultList.length; ++i)
    out1 = out1 + '\n' + resultList[i].fitness.toStringAsFixed(2) + '\t' + resultList[i].fitnessFiltered.toStringAsFixed(2) + '\t' +
        resultList[i].key ;

  return VigenereBreakerResult(plaintext: best_result.plaintext, key: best_result.key +'\n' + out1, fitness: best_result.fitness, errorCode: VigenereBreakerErrorCode.OK );
}

VigenereBreakerResult bestSolution(List<VigenereBreakerResult> keyList){
  if (keyList == null || keyList.length == 0)
    return null;

  keyList = _highPassFilter (0.98, keyList);
  var bestFitness = keyList[0];
  for (var i = 1; i < keyList.length; ++i)
    if (bestFitness.fitnessFiltered < keyList[i].fitnessFiltered)
      bestFitness = keyList[i];

  return bestFitness;
}


/// HighPass Filter
/// param alpha alpha should be in the range of [0..1]. If alpha = 1, the output equals the input. The smaller alpha gets, the stronger is the highpass effect.
List<VigenereBreakerResult> _highPassFilter( double alpha, List<VigenereBreakerResult> keyList) {
  keyList[0].fitnessFiltered = alpha * keyList[0].fitness;

  for (var i = 1; i < keyList.length; ++i)
    keyList[i].fitnessFiltered = alpha * (keyList[i - 1].fitnessFiltered + keyList[i].fitness - keyList[i - 1].fitness);

  return keyList;
}


List<List<int>> _createVigenereSquare(int size, bool beaufortVariant){
  var vigenereSquare = List<List<int>>(size);
  var rowList = List<int>();

  for (int i = 0; i < vigenereSquare.length; i++)
    rowList.add(i);

  if (beaufortVariant) {
    vigenereSquare[0] = rowList;
    rowList = createRowList(rowList);
    for (int row = vigenereSquare.length - 1; row > 0 ; row--) {
      vigenereSquare[row] = rowList;
      rowList = createRowList(rowList);
    }
  } else {
    for (int row = 0; row < vigenereSquare.length; row++) {
      vigenereSquare[row] = rowList;
      rowList = createRowList(rowList);
    }
  }

  return vigenereSquare;
}

List<int> createRowList(List<int> sourceList) {
  var rowList = List<int>();
  rowList.addAll(sourceList.getRange(1, sourceList.length));
  rowList.add(sourceList[0]);

  return rowList;
}

