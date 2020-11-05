import 'package:gc_wizard/logic/tools/crypto_and_encodings/vigenere_breaker/bigrams/bigrams.dart';

class FrenchBigrams extends Bigrams {

  FrenchBigrams() {

    alphabet = 'abcdefghijklmnopqrstuvwxyz';
    replacementList = {'æ': 'ae','à': 'a','â': 'a','ç': 'c','è': 'e','é': 'e','ë': 'e','ê': 'e','î': 'i','ï': 'i','ô': 'o','œ': 'oe','ü': 'ue','û': 'u','ù': 'u','ÿ': 'ye'};
    bigrams = [
  //       A       B       C       D       E       F       G       H       I       J       K       L       M       N       O       P       Q       R       S       T       U       V       W       X       Y       Z
    [ 664311, 767923, 839909, 782933, 711456, 734131, 794332, 604047, 890823, 623071, 586375, 882164, 803206, 924842, 592230, 828595, 659549, 894482, 832852, 872063, 865490, 808090, 523630, 551172, 668427, 578978 ], //A
    [ 752450, 508024, 404457, 486557, 733446, 327585, 267570, 345241, 725793, 533641, 289462, 767888, 369356, 392322, 720220, 366465, 270798, 749392, 591655, 535910, 686690, 340484, 262014, 131812, 487578, 197605 ], //B
    [ 813151, 439555, 695025, 600635, 884100, 471935, 412096, 833737, 800941, 384691, 602200, 745576, 508120, 459204, 883951, 528363, 539139, 738495, 606735, 789274, 747619, 407426, 325472, 213973, 538143, 319012 ], //C
    [ 837711, 470771, 531667, 622526, 972862, 465275, 486894, 610265, 820717, 489354, 353696, 571066, 572350, 496918, 773582, 549852, 456971, 718954, 639515, 486383, 839955, 498036, 429868, 212857, 521048, 317090 ], //D
    [ 867795, 756242, 898837, 913691, 886203, 802707, 790327, 671900, 772983, 702916, 597135, 924567, 896809, 962840, 729616, 879133, 761168, 942700,1000000, 926831, 878476, 800594, 585269, 741165, 592653, 620840 ], //E
    [ 764444, 357093, 460863, 541035, 752623, 724835, 352598, 325613, 777549, 304173, 277338, 642668, 422610, 376173, 767371, 447330, 359158, 728378, 583362, 474761, 688334, 310404, 271687, 195371, 311035, 193431 ], //F
    [ 746246, 431738, 428883, 518220, 820952, 392722, 487105, 529690, 735777, 301436, 341901, 661601, 531504, 724025, 665855, 445790, 350202, 762903, 524587, 533768, 714518, 348211, 349213, 219722, 466827, 271278 ], //G
    [ 786608, 391315, 425506, 467599, 802677, 374329, 330538, 349500, 745222, 309469, 358343, 503093, 499800, 580394, 730520, 428529, 339664, 583926, 503030, 501170, 646641, 342244, 384572, 111573, 574654, 310572 ], //H
    [ 768242, 701305, 804437, 766571, 900404, 737257, 749370, 457951, 606310, 491329, 538752, 875292, 769250, 893848, 865556, 728173, 790537, 835893, 898897, 894002, 582120, 770718, 377496, 638314, 426795, 531446 ], //I
    [ 659625, 244832, 392153, 298457, 701591, 210143, 200436, 205358, 472286, 228520, 266343, 263156, 286738, 287133, 717778, 289407, 113982, 325121, 309255, 228982, 670125, 188275, 137337,  50256, 197435, 119043 ], //J
    [ 608273, 365335, 387664, 425496, 617827, 358085, 397699, 487129, 600482, 295314, 389310, 474967, 505908, 409509, 557261, 410586, 320031, 475262, 503477, 398044, 492910, 331097, 346144, 162279, 457020, 176862 ], //K
    [ 923248, 589489, 624991, 698818, 971079, 616606, 586020, 627037, 858905, 463935, 465987, 848374, 629393, 603628, 819296, 643736, 602412, 587129, 734723, 681153, 806889, 549646, 388475, 274035, 616601, 369131 ], //L
    [ 845003, 740671, 501543, 603230, 902108, 416238, 396025, 424445, 807974, 344301, 345871, 496667, 773998, 522101, 794661, 790638, 395700, 451186, 584922, 514303, 703567, 383566, 379702, 232144, 513140, 238018 ], //M
    [ 843473, 630863, 846507, 869807, 916310, 732536, 762978, 607070, 818706, 603686, 539164, 706063, 686785, 809681, 811819, 748439, 662045, 690895, 887512, 946635, 716892, 697325, 448232, 371095, 582259, 519442 ], //N
    [ 572605, 693002, 744142, 715788, 689553, 657118, 704440, 538500, 829996, 537713, 522098, 788697, 834837, 947216, 596916, 746459, 598732, 859282, 765617, 754200, 901174, 642231, 536596, 532123, 657805, 447595 ], //O
    [ 864440, 349134, 464967, 540135, 846933, 401816, 352094, 706531, 731325, 279777, 285082, 803961, 414028, 399057, 849954, 730550, 304989, 847597, 656652, 692237, 726424, 345653, 251207, 245774, 438193, 235294 ], //P
    [ 405968, 214525, 316700, 288417, 335120, 256790, 213834, 197774, 366950, 221761, 122962, 258649, 308869, 207935, 230578, 309169, 200436, 240653, 321996, 243784, 890043, 213834,  98895,   5601,  28956,      0 ], //Q
    [ 888288, 645251, 762853, 805587, 964974, 644395, 709395, 546068, 868218, 536793, 562535, 812127, 767212, 737792, 855741, 699218, 643710, 760363, 839404, 831839, 756290, 685598, 453835, 346035, 586766, 430198 ], //R
    [ 875163, 682031, 815635, 864042, 926342, 722802, 664888, 683795, 860423, 629326, 563674, 822866, 757102, 689406, 860932, 835166, 741113, 729148, 871014, 891558, 823640, 681325, 491393, 422536, 649518, 464627 ], //S
    [ 885274, 632485, 751456, 838784, 943732, 656703, 596590, 725572, 907265, 589054, 467128, 816624, 684681, 643340, 818061, 777039, 675636, 878340, 823886, 787370, 811999, 617780, 462559, 360741, 613089, 485347 ], //T
    [ 741289, 703022, 764217, 749836, 886291, 644183, 665613, 519850, 845510, 635430, 509120, 787362, 745497, 871741, 574452, 763710, 545389, 904732, 846091, 837309, 582646, 770277, 392752, 784629, 489559, 488657 ], //U
    [ 779247, 262091, 337937, 412494, 854614, 297769, 261167, 250680, 805763, 345571, 246613, 392844, 298506, 328536, 748500, 341441, 249882, 684620, 403309, 295973, 570371, 259996, 137337, 129099, 363247, 113506 ], //V
    [ 590208, 321959, 333452, 338297, 552754, 293566, 230916, 414416, 558417, 253962, 301436, 362272, 302560, 422938, 495906, 299575, 207935, 380329, 434870, 325927, 338894, 199116, 360514,  59121, 433824, 145139 ], //W
    [ 626861, 474934, 619523, 632474, 686419, 520332, 456225, 469418, 656786, 444059, 280696, 524460, 554304, 474112, 528170, 667140, 504767, 504214, 573242, 634951, 477201, 516300, 272567, 391812, 431129, 225572 ], //X
    [ 664549, 455923, 576474, 545141, 664793, 445934, 445327, 375721, 446993, 360011, 356855, 577784, 590586, 576346, 574838, 601931, 388313, 547804, 665917, 533665, 448510, 441646, 379702, 264951, 293514, 357022 ], //Y
    [ 567388, 358085, 392920, 437118, 584646, 346415, 308177, 389166, 535103, 247991, 292678, 498048, 373285, 353174, 564063, 405170, 306820, 364839, 409146, 346821, 448833, 377329, 270384,  96575, 381517, 434413 ], //Z
    ];
  }
}
