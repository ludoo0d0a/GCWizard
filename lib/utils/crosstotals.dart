List<int> validateAndSanitizeList(List<int> list) {
  if (list == null)
    return null;

  list.removeWhere((element) => element == null);

  if (list.isEmpty)
    return null;

  return list;
}

BigInt sum(List<int> list) {
  if (validateAndSanitizeList(list) == null)
    return BigInt.zero;

  return list.map((e) => BigInt.from(e)).reduce((a, b) => a + b);
}

BigInt product(List<int> list) {
  if (validateAndSanitizeList(list) == null)
    return BigInt.zero;

  return list
      .map((e) => BigInt.from(e))
      .reduce((a, b) => a * b);
}

List<BigInt> _intListToIntDigitList(List<BigInt> list) {
  return list
      .map((element) => element.toString())
      .toList()
      .join()
      .split('')
      .map((element) => BigInt.tryParse(element))
      .toList();
}

List<BigInt> _numberToIntDigitList(BigInt number) {
  return number
      .toString()
      .split('')
      .map((element) => BigInt.tryParse(element))
      .toList();
}

BigInt _crossSumNumber(BigInt number) {
  return _numberToIntDigitList(number).reduce((a, b) => a + b);
}

BigInt _crossProductNumber(BigInt number) {
  return _numberToIntDigitList(number).reduce((a, b) => a * b);
}

BigInt _crossSumNumberIterated(BigInt number) {
  while (number >= BigInt.from(10)) {
    number = _crossSumNumber(number);
  }
  return number;
}

BigInt _crossProductNumberIterated(BigInt number) {
  while (number >= BigInt.from(10)) {
    number = _crossProductNumber(number);
  }
  return number;
}

BigInt sumCrossSum(List<int> list) {
  BigInt s = sum(list);
  return _crossSumNumber(s);
}

BigInt productCrossSum(List<int> list) {
  BigInt p = product(list);
  return _crossSumNumber(p);
}

BigInt sumCrossSumIterated(List<int> list) {
  BigInt s = sum(list);
  return _crossSumNumberIterated(s);
}

BigInt sumCrossSumAlternatedBackward(List<int> list) {
  BigInt s = sum(list);
  return _crossSumAlternatedBackward([s]);
}

BigInt sumCrossSumAlternatedForward(List<int> list) {
  BigInt s = sum(list);
  return _crossSumAlternatedForward([s]);
}

BigInt productCrossSumIterated(List<int> list) {
  BigInt p = product(list);
  return _crossSumNumberIterated(p);
}

BigInt productCrossSumAlternatedBackward(List<int> list) {
  BigInt p = product(list);
  return _crossSumAlternatedBackward([p]);
}

BigInt productCrossSumAlternatedForward(List<int> list) {
  BigInt p = product(list);
  return _crossSumAlternatedForward([p]);
}

BigInt crossSumIterated(List<int> list) {
  BigInt c = crossSum(list);
  return _crossSumNumberIterated(c);
}

BigInt crossProductIterated(List<int> list) {
  BigInt c = crossProduct(list);
  return _crossProductNumberIterated(c);
}

BigInt sumAlternatedForward(List<int> list) {
  if (validateAndSanitizeList(list) == null)
    return BigInt.zero;

  BigInt i = BigInt.one;
  return list
      .map((e) => BigInt.from(e))
      .reduce((a, b) {
        i *= BigInt.from(-1);
        return a + i * b;
      });
}

BigInt sumAlternatedBackward(List<int> list) {
  if (validateAndSanitizeList(list) == null)
    return BigInt.zero;

  BigInt i = BigInt.one;
  return list
      .reversed
      .map((e) => BigInt.from(e))
      .reduce((a, b) {
        i *= BigInt.from(-1);
        return a + i * b;
      });
}

BigInt productAlternated(List<int> list) {
  if (validateAndSanitizeList(list) == null)
    return BigInt.zero;

  BigInt i = BigInt.one;
  return list
      .reversed
      .map((e) => BigInt.from(e))
      .reduce((a, b) {
        i *= BigInt.from(-1);
        return a * i * b;
      });
}

BigInt _crossSumAlternatedForward(List<BigInt> list) {
  BigInt i = BigInt.one;
  return _intListToIntDigitList(list)
      .reduce((a, b) {
        i *= BigInt.from(-1);
        return a + i * b;
      });
}

BigInt crossSumAlternatedForward(List<int> list) {
  if (validateAndSanitizeList(list) == null)
    return BigInt.zero;

  return _crossSumAlternatedForward(list.map((e) => BigInt.from(e)).toList());
}

BigInt _crossSumAlternatedBackward(List<BigInt> list) {
  BigInt i = BigInt.one;
  return _intListToIntDigitList(list)
      .reversed
      .reduce((a, b) {
        i *= BigInt.from(-1);
        return a + i * b;
      });
}

BigInt crossSumAlternatedBackward(List<int> list) {
  if (validateAndSanitizeList(list) == null)
    return BigInt.zero;

  return _crossSumAlternatedBackward(list.map((e) => BigInt.from(e)).toList());
}

BigInt crossProductAlternated(List<int> list) {
  if (validateAndSanitizeList(list) == null)
    return BigInt.zero;

  BigInt i = BigInt.one;
  return _intListToIntDigitList(list.map((e) => BigInt.from(e)).toList())
      .reversed
      .reduce((a, b) {
        i *= BigInt.from(-1);
        return a * i * b;
      });
}

BigInt crossSum(List<int> list) {
  if (validateAndSanitizeList(list) == null)
    return BigInt.zero;

  return list
      .map((element) {
        return _crossSumNumber(BigInt.from(element));
      })
      .reduce((a, b) => a + b);
}

BigInt crossProduct(List<int> list) {
  if (validateAndSanitizeList(list) == null)
    return BigInt.zero;

  return list
      .map((element) {
        return _crossProductNumber(BigInt.from(element));
      })
      .reduce((a, b) => a * b);
}

int countCharacters(String text) {
  if (text == null)
    return 0;

  return text.length;
}

int countLetters(String text) {
  if (text == null)
    return 0;

  return text.toUpperCase().replaceAll(RegExp(r'[^A-Z]'), '').length;
}

int countDigits(String text) {
  if (text == null)
    return 0;

  return text.replaceAll(RegExp(r'[^0-9]'), '').length;
}