import 'package:gc_wizard/logic/tools/crypto_and_encodings/substitution_breaker/quadgrams/quadgrams.dart';

class GreekQuadgrams extends Quadgrams {

  GreekQuadgrams() {

    alphabet = 'αβγδεζηθικλμνξοπρστυφχψω';
    nbr_quadgrams = 87436142;
    most_frequent_quadgram = 'εναι';
    max_fitness = 1335;
    average_fitness = 275.8675944010417;
    assetLocation = "assets/quadgrams/gr.json";
  }
}
