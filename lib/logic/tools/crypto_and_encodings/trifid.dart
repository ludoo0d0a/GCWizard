import 'package:gc_wizard/logic/tools/crypto_and_encodings/polybios.dart';
import 'package:gc_wizard/utils/alphabets.dart';
import 'package:gc_wizard/utils/common_utils.dart';

class TrifidOutput {
  final String output;
  final String grid;

  TrifidOutput(this.output, this.grid);
}


TrifidOutput encryptTrifid(String input, int blockSize, {PolybiosMode mode: PolybiosMode.AZ09, String alphabet}) {
  if (input == null)
    return TrifidOutput('', '');

  Map<String, String> EncodeMatrix = new Map<String, String>();
  Map<String, String> DecodeMatrix = new Map<String, String>();

  List<String> line1 = new List<String>();
  List<String> line2 = new List<String>();
  List<String> line3 = new List<String>();
  List<String> result = new List<String>();

  switch (mode){
    case PolybiosMode.AZ09 : alphabet = alphabet_AZ.keys.join() + '+'; break;
    case PolybiosMode.ZA90 : alphabet = alphabet_AZ.keys.toList().reversed.join() + '+'; break;
    case PolybiosMode.CUSTOM: if (alphabet.length != 27)
      return TrifidOutput('trifid_error_alphabet', '');
  }

  EncodeMatrix = _buildEncodeMatrix(alphabet);
  DecodeMatrix = switchMapKeyValue(EncodeMatrix);

  for (int i = 0; i < input.length; i++) {
    line1.add(EncodeMatrix[input[i]][0]);
    line2.add(EncodeMatrix[input[i]][1]);
    line3.add(EncodeMatrix[input[i]][2]);
  }

  input = '';
  for (int i = 0; i < line1.length ~/ blockSize; i++){
    input = input + line1.join('').substring(i * blockSize, i * blockSize + blockSize)
                  + line2.join('').substring(i * blockSize, i * blockSize + blockSize)
                  + line3.join('').substring(i * blockSize, i * blockSize + blockSize);
  }
  input = input + line1.join('').substring(line1.length ~/ blockSize * blockSize)
                + line2.join('').substring(line1.length ~/ blockSize * blockSize)
                + line3.join('').substring(line1.length ~/ blockSize * blockSize);

  for (int i = 0; i < input.length ~/ 3; i++) {
    result.add(DecodeMatrix[input.substring(i * 3, i * 3 + 3)]);
  }

  return TrifidOutput(result.join(''), _MatrixToString(alphabet));
}


TrifidOutput decryptTrifid(String input, int blockSize, {PolybiosMode mode: PolybiosMode.AZ09, String alphabet}) {
  if (input == null)
    return TrifidOutput('', '');

  Map<String, String> EncodeMatrix = new Map<String, String>();
  Map<String, String> DecodeMatrix = new Map<String, String>();
  List<String> result = new List<String>();
  String line1 = '';
  String line2 = '';
  String line3 = '';
  String tupel = '';
  String blockLine = '';

  switch (mode){
    case PolybiosMode.AZ09 : alphabet = alphabet_AZ.keys.join() + '+'; break;
    case PolybiosMode.ZA90 : alphabet = alphabet_AZ.keys.toList().reversed.join() + '+'; break;
    case PolybiosMode.CUSTOM: if (alphabet.length != 27)
      return TrifidOutput('trifid_error_alphabet', '');
  }
  EncodeMatrix = _buildEncodeMatrix(alphabet);
  DecodeMatrix = switchMapKeyValue(EncodeMatrix);

  for (int i = 0; i < input.length; i++) {
    tupel = tupel + EncodeMatrix[input[i]];
  }
  for (int i = 0; i < tupel.length ~/ blockSize ~/ 3; i++){
    blockLine = tupel.substring(i * blockSize * 3, i * blockSize * 3 + blockSize * 3);
    line1 = line1 + blockLine.substring(0,blockLine.length ~/3);
    line2 = line2 + blockLine.substring(blockLine.length ~/3, 2 * blockLine.length ~/3);
    line3 = line3 + blockLine.substring(2 * blockLine.length ~/3);
  }
  blockLine = tupel.substring(line1.length ~/ blockSize * blockSize);
  line1 = line1 + blockLine.substring(0,blockLine.length ~/3);
  line2 = line2 + blockLine.substring(blockLine.length ~/3, 2 * blockLine.length ~/3);
  line3 = line3 + blockLine.substring(2 * blockLine.length ~/3);

  for (int i = 0; i < input.length; i++) {
    result.add(DecodeMatrix[line1[i] + line2[i] + line3[i]]);
  }

  return TrifidOutput(result.join(''), _MatrixToString(alphabet));
}


String _MatrixToString(String alphabet){
  String result = '';
  result = result + '  |   1       |   2       |   3  \n';
  result = result + '  | 1 2 3     | 1 2 3     | 1 2 3\n';
  result = result + '--+------   --+------   --+------\n';
  result = result + '1 | ' + alphabet[0] + ' ' + alphabet[1] + ' ' + alphabet[2] + '   1 | ' + alphabet[9] + ' '  + alphabet[10] + ' ' + alphabet[11] + '   1 | ' + alphabet[18] + ' ' + alphabet[19] + ' ' + alphabet[20] + '\n';
  result = result + '2 | ' + alphabet[3] + ' ' + alphabet[4] + ' ' + alphabet[5] + '   2 | ' + alphabet[12] + ' ' + alphabet[13] + ' ' + alphabet[14] + '   2 | ' + alphabet[21] + ' ' + alphabet[22] + ' ' + alphabet[23] + '\n';
  result = result + '3 | ' + alphabet[6] + ' ' + alphabet[7] + ' ' + alphabet[8] + '   3 | ' + alphabet[15] + ' ' + alphabet[16] + ' ' + alphabet[17] + '   3 | ' + alphabet[24] + ' ' + alphabet[25] + ' ' + alphabet[26] + '\n';
  return result;
}

Map<String, String> _buildEncodeMatrix(String alphabet){
  int j = 0;
  int x = 0;
  int y = 0;
  int z = 0;
  Map<String, String> result = new Map<String, String>();
  for (int i = 0; i < alphabet.length; i++){
    j = i % 9;
    z = (i ~/ 9) + 1;
    x = j % 3 + 1;
    y = j ~/ 3 + 1;
    result[alphabet[i]] = z.toString() + y.toString() + x.toString();
  }
  return result;
}




