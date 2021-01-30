import 'package:gc_wizard/logic/tools/crypto_and_encodings/polybios.dart';
import 'package:gc_wizard/utils/common_utils.dart';
import 'package:gc_wizard/utils/constants.dart';

class StraddlingCheckerboardOutput {
  final String output;
  final String grid;

  StraddlingCheckerboardOutput(this.output, this.grid);
}

Map <String, String> EncodeMatrix = new Map <String, String>();
Map <String, String> DecodeMatrix = new Map <String, String>();

StraddlingCheckerboardOutput encryptStraddlingCheckerboard(String input, String key) {
  if (_invalidKey(key))
    StraddlingCheckerboardOutput('straddlingcheckerboard_error_wrong_key', '');
  if (input == null || input == '')
    return StraddlingCheckerboardOutput('', '');

  DecodeMatrix = _buildDecodeMatrix(key);
  EncodeMatrix =  switchMapKeyValue(DecodeMatrix);
  List<String> result = new List<String>();

  for (int i = 0; i < input.length; i++)
    if (EncodeMatrix[input[i]] == null)
      result.add('');
    else
      result.add(EncodeMatrix[input[i]]);

  return StraddlingCheckerboardOutput(result.join(''), _buildGrid(DecodeMatrix));
}


StraddlingCheckerboardOutput decryptStraddlingCheckerboard(String input, String key) {
  if (_invalidKey(key))
    StraddlingCheckerboardOutput('straddlingcheckerboard_error_wrong_key', '');
  if (input == null || input == '')
    return StraddlingCheckerboardOutput('', '');

  DecodeMatrix = _buildDecodeMatrix(key);
  EncodeMatrix =  switchMapKeyValue(DecodeMatrix);
  List<String> result = new List<String>();

  for (int i = 0; i < input.length; i++) {
    if (DecodeMatrix[input[i]] == null)
      result.add('');
    else
    if (DecodeMatrix[input[i]] == ' ') {
      result.add(DecodeMatrix[input[i] + input[i + 1]]);
      i++;
    }
    else
      result.add(DecodeMatrix[input[i]]);
  }

  return StraddlingCheckerboardOutput(result.join('').replaceAll('.', ' '), _buildGrid(DecodeMatrix));
}

bool _invalidKey(String key){
  int space = 0;

  for (int i = 0; i < key.length; i++)
    if (key[i] == ' ')
      space++;

  return (space != 0);
}

Map <String, String> _buildDecodeMatrix(String key){
  Map <String, String> result = new Map <String, String>();
  List<String> usedAlphabet = new List<String>();
  String line1 = '';
  String line2 = '';
  int col = 0;
  for (int i = 0; i < key.length; i++){
    result[i.toString()] = key[i];
    usedAlphabet.add(key[i]);
    if (key[i] == ' ' && line1 == '')
      line1 = i.toString();
    else
    if (key[i] == ' ' && line2 == '')
      line2 = i.toString();
  }

  for (int i = 65; i <= 90; i++){
    if (!usedAlphabet.contains(String.fromCharCode(i))){
      usedAlphabet.add(String.fromCharCode(i));
      if (col < 10)
        result[line1 + col.toString()] = String.fromCharCode(i);
      else
        result[line2 + (col - 10).toString()] = String.fromCharCode(i);
      col++;
    }
  }

  result[line2 + '8'] = '.';
  result[line2 + '9'] = '/';

  return result;
}

String _buildGrid(Map <String, String> grid){
  String result = '';
  String line1 = '';
  String line2 = '';

  result = result + '  | 0 1 2 3 4 5 6 7 8 9' + '\n';
  result = result + '-----------------------' + '\n';

  result = result + '  |';
  for (int i = 0; i < 10; i++){
    result = result + ' ' + grid[i.toString()];
    if (grid[i.toString()] == ' ' && line1 == '')
      line1 = i.toString();
    else
    if (grid[i.toString()] == ' ' && line2 == '')
      line2 = i.toString();
  }
  result = result +'\n';

  result = result + line1 + ' |';
  for (int i = 0; i < 10; i++) {
    result = result + ' ' + grid[line1+i.toString()];
  }
  result = result +'\n';

  result = result + line2 + ' |';
  for (int i = 0; i < 10; i++) {
    result = result + ' ' + grid[line2+i.toString()];
  }
  return result;
}


