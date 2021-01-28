import 'package:gc_wizard/logic/tools/crypto_and_encodings/polybios.dart';
import 'package:gc_wizard/utils/alphabets.dart';
import 'package:gc_wizard/utils/common_utils.dart';

class TrifidOutput {
  final String output;
  final String grid;

  TrifidOutput(this.output, this.grid);
}


TrifidOutput TrifidChiffre(String input, int blockSize, {PolybiosMode mode: PolybiosMode.AZ09, String alphabet}) {
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
    print(EncodeMatrix[input[i]]);
    line1.add(EncodeMatrix[input[i]][0].toString());
    line2.add(EncodeMatrix[input[i]][1].toString());
    line3.add(EncodeMatrix[input[i]][2].toString());
  }

  for (int i = 0; i < input.length; i++) {
      
  }
  input = line1.join('') + line2.join('') + line3.join('');
print('decode '+line1.join('') +' '+ line2.join('') +' '+ line3.join(''));
  //return decryptTrifid(line1.join(' ') + ' ' + line2.join(' ') + ' ' + line3.join(' '), mode: mode, alphabet: alphabet);
  for (int i = 0; i < input.length; i = i + 3) {
    result.add(DecodeMatrix[input[i] + input[i + 1] + input[i + 2]]);
  }
  return TrifidOutput(result.join(' '), _MatrixToString(alphabet));

}


TrifidOutput decryptTrifid (String input, int blockSize, {PolybiosMode mode: PolybiosMode.AZ09, String alphabet}) {
  if (input == null)
    return TrifidOutput('', '');

  Map<String, String> DecodeMatrix = new Map<String, String>();
  List<String> result = new List<String>();

  switch (mode){
    case PolybiosMode.AZ09 : alphabet = alphabet_AZ.keys.join() + '+'; break;
    case PolybiosMode.ZA90 : alphabet = alphabet_AZ.keys.toList().reversed.join() + '+'; break;
    case PolybiosMode.CUSTOM: if (alphabet.length != 27)
      return TrifidOutput('trifid_error_alphabet', '');
  }
  //DecodeMatrix = _buildDecodeMatrix(alphabet);
  List<String>inputs = input.replaceAll('  ', ' ').split(' ');

  if (inputs.length % 3 != 0){
    return TrifidOutput('trifid_error_invalid_chiffretext', _MatrixToString(alphabet));
  }

  for (int i = 0; i < input.length; i = i + 3) {
  result.add(DecodeMatrix[i][i + 1][i + 2]);
  }
  return TrifidOutput(result.join(' '), _MatrixToString(alphabet));
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
  print('encodematrix '+result.toString());
  return result;
}




