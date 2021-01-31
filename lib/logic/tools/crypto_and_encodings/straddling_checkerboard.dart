import 'package:gc_wizard/utils/common_utils.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/polybios.dart';

class StraddlingCheckerboardOutput {
  final String output;
  final String grid;

  StraddlingCheckerboardOutput(this.output, this.grid);
}

StraddlingCheckerboardOutput encryptStraddlingCheckerboard(String input, key, alphabetWord, columnOrder, bool matrix4x10, {PolybiosMode mode: PolybiosMode.AZ09, String alphabet}) {
  if (input == null || input == '')
    return StraddlingCheckerboardOutput('', '');
  if (_invalidKey(key, matrix4x10))
    return StraddlingCheckerboardOutput('straddlingcheckerboard_wrong_key_error', '');
  if (_invalidColumnOrder(columnOrder))
    return StraddlingCheckerboardOutput('straddlingcheckerboard_wrong_order_error', '');

  try{
    Map <String, String> EncodeMatrix = new Map <String, String>();
    Map <String, String> DecodeMatrix = new Map <String, String>();
    List<String> result = new List<String>();

    DecodeMatrix = _buildDecodeMatrix(key, columnOrder, matrix4x10, alphabetWord, mode: mode, alphabet: alphabet);
    if (DecodeMatrix['ERROR'] != null)
      return StraddlingCheckerboardOutput('straddlingcheckerboard__wrong_key_error', '');

    EncodeMatrix =  switchMapKeyValue(DecodeMatrix);

    for (int i = 0; i < input.length; i++)
      if (matrix4x10) {
        if (EncodeMatrix[input[i]] == null)
          result.add('');
        else
          result.add(EncodeMatrix[input[i]]);
      }
      else {
        if (int.tryParse(input[i]) != null)
          result.addAll([EncodeMatrix['/'], input[i]]);
        else
        if (EncodeMatrix[input[i]] == null)
          result.add('');
        else
          result.add(EncodeMatrix[input[i]]);
      }
    return StraddlingCheckerboardOutput(result.join(''), _buildGrid(DecodeMatrix, columnOrder, matrix4x10));
  }catch (e){
    return StraddlingCheckerboardOutput('straddlingcheckerboard_runtime_error' + '#' + e.toString(), '');
  }

}

StraddlingCheckerboardOutput decryptStraddlingCheckerboard(String input, key, alphabetWord, columnOrder, bool matrix4x10, {PolybiosMode mode: PolybiosMode.AZ09, String alphabet}) {
  if (input == null || input == '')
    return StraddlingCheckerboardOutput('', '');
  if (_invalidKey(key, matrix4x10))
    return StraddlingCheckerboardOutput('straddlingcheckerboard_wrong_key_error', '');
  if (_invalidColumnOrder(columnOrder))
    return StraddlingCheckerboardOutput('straddlingcheckerboard_wrong_order_error', '');

  try{
    Map <String, String> DecodeMatrix = new Map <String, String>();
    List<String> result = new List<String>();

    DecodeMatrix = _buildDecodeMatrix(key, columnOrder, matrix4x10, alphabetWord, mode: mode, alphabet: alphabet);
    if (DecodeMatrix['ERROR'] != null)
      return StraddlingCheckerboardOutput('straddlingcheckerboard_wrong_key_error', '');

    for (int i = 0; i < input.length; i++) {
      if (matrix4x10) {
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
      else {
        if (DecodeMatrix[input[i]] == null)
          result.add('');
        else
        if (DecodeMatrix[input[i]] == ' ') {
          if (DecodeMatrix[input[i] + input[i + 1]] == '/') {
            result.add(input[i + 2]);
            i++;
          }
          else
            result.add(DecodeMatrix[input[i] + input[i + 1]]);
          i++;
        }
        else
          result.add(DecodeMatrix[input[i]]);
      }
    }
    return StraddlingCheckerboardOutput(result.join('').replaceAll('.', ' '), _buildGrid(DecodeMatrix, columnOrder, matrix4x10));
  }catch (e){
    return StraddlingCheckerboardOutput('straddlingcheckerboard_runtime_error' + '#' + e.toString(), '');
  }

}

bool _invalidKey(String key, bool matrix4x10){
  int space = 0;

  for (int i = 1; i < key.length; i++)
    if (key[i] != ' ')
      if (key.substring(0,i - 1).contains(key[i]))
       return true;

  for (int i = 0; i < key.length; i++)
    if (key[i] == ' ')
      space++;

  if (matrix4x10) {
    return !(space == 3 && key.length == 10);}
  else{
    return !(space == 2 && key.length == 10);}
}

bool _invalidColumnOrder(String columnOrder){
  if (columnOrder == '')
    return false;

  if (columnOrder.length != 10)
    return true;

  for (int i = 1; i < columnOrder.length; i++)
    if (columnOrder.substring(0,i - 1).contains(columnOrder[i]))
      return true;

  return false;
}

Map <String, String> _buildDecodeMatrix(String key, String columnOrder, bool matrix4x10, String alphabetWord, {PolybiosMode mode: PolybiosMode.AZ09, String alphabet}){
  Map <String, String> result = new Map <String, String>();
  List<String> usedAlphabet = new List<String>();
  String line1 = '';
  String line2 = '';
  String line3 = '';
  String wholeAlphabet = '';

  if (columnOrder == '')
    columnOrder = '0123456789';

  wholeAlphabet = key + alphabetWord;
  switch (mode) {
    case PolybiosMode.AZ09:
      if (matrix4x10)
        if (wholeAlphabet.contains('.'))
          wholeAlphabet = wholeAlphabet + 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
        else
          wholeAlphabet = wholeAlphabet + 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789.';
      else
        if (wholeAlphabet.contains('.'))
          if (wholeAlphabet.contains('/'))
            wholeAlphabet = wholeAlphabet + 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
          else
            wholeAlphabet = wholeAlphabet + 'ABCDEFGHIJKLMNOPQRSTUVWXYZ/';
        else
          if (wholeAlphabet.contains('/'))
            wholeAlphabet = wholeAlphabet + 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
          else
            wholeAlphabet = wholeAlphabet + 'ABCDEFGHIJKLMNOPQRSTUVWXYZ./';
      break;
    case PolybiosMode.ZA90:
      if (matrix4x10)
        if (wholeAlphabet.contains('.'))
          wholeAlphabet = wholeAlphabet + 'ZYXWVUTSRQPOnMLKJIHGFEDCBA9876543210';
        else
          wholeAlphabet = wholeAlphabet + 'ZYXWVUTSRQPOnMLKJIHGFEDCBA9876543210.';
      else
      if (wholeAlphabet.contains('.'))
        if (wholeAlphabet.contains('/'))
          wholeAlphabet = wholeAlphabet + 'ZYXWVUTSRQPOnMLKJIHGFEDCBA9876543210';
        else
          wholeAlphabet = wholeAlphabet + 'ZYXWVUTSRQPOnMLKJIHGFEDCBA9876543210/';
      else
      if (wholeAlphabet.contains('/'))
        wholeAlphabet = wholeAlphabet + 'ZYXWVUTSRQPOnMLKJIHGFEDCBA9876543210';
      else
        wholeAlphabet = wholeAlphabet + 'ZYXWVUTSRQPOnMLKJIHGFEDCBA9876543210./';
      break;
    case PolybiosMode.CUSTOM:
      wholeAlphabet = wholeAlphabet + alphabet;
      if (matrix4x10)
        if (!wholeAlphabet.contains('.')) {
          result['ERROR'] = 'invalidLength';
          return result;
        }
      else
        if (!wholeAlphabet.contains('.') || !wholeAlphabet.contains('/')) {
        result['ERROR'] = 'invalidLength';
        return result;
        }
      break;
  }

  // Build matrix - first row with single numbers
  for (int i = 0; i < 10; i++) {
    if (wholeAlphabet[i] == ' ' && line1 == '')
      line1 = columnOrder[i];
    else
    if (wholeAlphabet[i] == ' ' && line2 == '')
      line2 = columnOrder[i];
    else
    if (wholeAlphabet[i] == ' ' && line3 == '')
      line3 = columnOrder[i];

    result[columnOrder[i]] = wholeAlphabet[i];
    usedAlphabet.add(wholeAlphabet[i]);
  }

  int col = 10;
  for (int i = 10; i < wholeAlphabet.length; i++) {
    if (!usedAlphabet.contains(wholeAlphabet[i])){
      switch (col ~/ 10){
        case 1: result[line1 + columnOrder[col % 10]] = wholeAlphabet[i]; break;
        case 2: result[line2 + columnOrder[col % 10]] = wholeAlphabet[i]; break;
        case 3: result[line3 + columnOrder[col % 10]] = wholeAlphabet[i]; break;
      }
      usedAlphabet.add(wholeAlphabet[i]);
      col++;
    }
  }
  return result;
}

String _buildGrid(Map <String, String> grid, String columnOrder, bool matrix4x10){
  String result = '';
  String line1 = '';
  String line2 = '';
  String line3 = '';

  if (columnOrder == '')
    columnOrder = '0123456789';

  result = result + '  | ' + columnOrder.split('').join(' ') + '\n';
  result = result + '-----------------------' + '\n';

  result = result + '  |';
  for (int i = 0; i < 10; i++){
    result = result + ' ' + grid[columnOrder[i]];
    if (grid[columnOrder[i]] == ' ' && line1 == '')
      line1 = columnOrder[i];
    else
    if (grid[columnOrder[i]] == ' ' && line2 == '')
      line2 = columnOrder[i];
    else
    if (grid[columnOrder[i]] == ' ' && line3 == '')
      line3 = columnOrder[i];
  }
  result = result +'\n';

  result = result + line1 + ' |';
  for (int i = 0; i < 10; i++) {
    result = result + ' ' + grid[line1 + columnOrder[i]];
  }
  result = result +'\n';

  result = result + line2 + ' |';
  for (int i = 0; i < 10; i++) {
    result = result + ' ' + grid[line2 + columnOrder[i]];
  }

  if (matrix4x10) {
    result = result +'\n';
    result = result + line3 + ' |';
    for (int i = 0; i < 10; i++) {
      result = result + ' ' + grid[line3 + columnOrder[i]];
    }
  }
  return result;
}


