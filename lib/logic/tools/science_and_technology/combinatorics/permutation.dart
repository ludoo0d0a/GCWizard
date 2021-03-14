final int PERMUTATION_MAX_LENGTH = 7;

_swap(characters, a, b) {
  var help = characters[a];
  characters[a] = characters[b];
  characters[b] = help;
}

_permutation(List<String> characters, endIndex, List<String> out) {
  if (endIndex == 0) {
    out.add(characters.join());
    return;
  }

  _permutation(characters, endIndex - 1, out);
  for (int i = 0; i <= endIndex - 1; i++) {
    _swap(characters, i, endIndex);
    _permutation(characters, endIndex - 1, out);
    _swap(characters, i, endIndex);
  }
}

List<String> generatePermutations(String input, {bool avoidDuplicates}) {
  if (input == null || input == '') return [];

  var characters = input.split('');
  var out = <String>[];

  _permutation(characters, characters.length - 1, out);

  out.sort((a, b) {
    return a.toLowerCase().compareTo(b.toLowerCase());
  });

  if (avoidDuplicates) {
    return out.toSet().toList();
  }

  return out;
}
