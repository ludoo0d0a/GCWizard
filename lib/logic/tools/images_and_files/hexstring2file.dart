import 'dart:math';
import 'dart:typed_data';
import 'package:collection/collection.dart';
import 'package:gc_wizard/logic/tools/science_and_technology/numeral_bases.dart';

Map<List<int>, String> _fileTypes = {
  [0x50, 0x4B, 0x03, 0x04] : ".zip",
  [0x52, 0x61, 0x72, 0x21] : ".rar",
  [0x1F, 0x8B, 0x08, 0x00] : ".tar",
  [0x37, 0x7A, 0xBC, 0xAF, 0x27, 0x1C] : ".7z",
  [0xFF, 0xD8, 0xFF, 0xE0] : ".jpg",
  [0xFF, 0xD8, 0xFF, 0xE1] : ".jpg",
  [0xFF, 0xD8, 0xFF, 0xFE] : ".jpg",
  [0x89, 0x50, 0x4E, 0x47] : ".png",
  [0x42, 0x4D] : ".bmp",
  [0x47, 0x49, 0x46, 0x38, 0x39, 0x61] : ".gif",
  [0x47, 0x49, 0x46, 0x38, 0x37, 0x61] : ".gif",
  [0x30, 0x26, 0xB2, 0x75] : ".wmv",
  [0x49, 0x44, 0x33, 0x2E] : ".mp3",
  [0x49, 0x44, 0x33, 0x03] : ".mp3",
  [0x25, 0x50, 0x44, 0x46] : ".pdf",
  [0x4D, 0x5A, 0x50, 0x00] : ".exe",
  [0x4D, 0x5A, 0x90, 0x00] : ".exe",
};

enum MIMETYPE {IMAGE, ARCHIV, DATA, TEXT}

Uint8List hexstring2file(String input) {
  if (_isBinary(input))
    return _binaryString2bytes(input);
  else
    return _hexString2bytes(input);
}

MIMETYPE getMimeType(String fileName) {
  if (fileName.endsWith('.jpg') ||
      fileName.endsWith('.gif') ||
      fileName.endsWith('.png') ||
      fileName.endsWith('.bmp'))
    return MIMETYPE.IMAGE;
  else if (fileName.endsWith('.zip') ||
      fileName.endsWith('.rar') ||
      fileName.endsWith('.7z') ||
      fileName.endsWith('.tar'))
    return MIMETYPE.ARCHIV;
  else if (fileName.endsWith('.txt'))
    return MIMETYPE.TEXT;
  else
    return MIMETYPE.DATA;
}

String file2hexstring(Uint8List input) {
  if (input == null)
    return null;

  var output =input.map((byte){
    return byte.toRadixString(16).padLeft(2,'0');
  })
  .join(' ');

  return output.toUpperCase();
}

Uint8List _hexString2bytes(String input) {
  if (input == null || input == "")
    return null;

  var data = <int>[];

  input = input.replaceAll("0x", "");
  String hex = input.toUpperCase().replaceAll(RegExp("[^0-9A-F]"), "");
  if (hex == "")
    return null;

  for (var i=0; i<hex.length; i=i+2) {
    var valueString = hex.substring(i, min(i+2, hex.length-1));
    if (valueString.length  > 0) {
      int value = int.tryParse(convertBase(valueString, 16, 10));
      data.add(value);
    }
  }

  return Uint8List.fromList(data);
}

bool _isBinary(String input) {
  if (input == null)
    return false;
  String binary = input.replaceAll(RegExp("[01\\s]"), "");
  return binary.length == 0;
}

Uint8List _binaryString2bytes(String input) {
  if (input == null || input == "")
    return null;

  var data = <int>[];

  String binary = input.replaceAll(RegExp("[^01]"), "");
  if (binary == "")
    return null;

  for (var i=0; i<binary.length; i=i+8) {
    var valueString = binary.substring(i, min(i+8, binary.length-1));
    if (valueString.length  > 0) {
      int value = int.tryParse(convertBase(valueString, 2, 10));
      data.add(value);
    }
  }

  return Uint8List.fromList(data);
}