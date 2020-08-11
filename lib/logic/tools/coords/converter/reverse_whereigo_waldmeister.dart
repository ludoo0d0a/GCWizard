import 'package:latlong/latlong.dart';

LatLng waldmeisterToLatLon(int a, int b, int c){
  int _latSign = 1;
  int _lonSign = 1;
  double _lon, _lat;

  if ((a % 1000 - a % 100) / 100 == 1) {
    _latSign = 1;
    _lonSign = 1;
  } else if ((a % 1000 - a % 100) / 100 == 2) {
    _latSign = -1;
    _lonSign = 1;
  } else if ((a % 1000 - a % 100) / 100 == 3) {
    _latSign = 1;
    _lonSign = -1;
  } else if ((a % 1000 - a % 100) / 100 == 4) {
    _latSign = -1;
    _lonSign = -1;
  }

  if (((c % 100000 - c % 10000) / 10000 + (c % 100 - c % 10) / 10) % 2 == 0) {
    _lat = (_latSign * ((a % 10000 - a % 1000) / 1000 * 10 + (b % 100 - b % 10) / 10 + (b % 100000 - b % 10000) / 10000 * 0.1 + (c % 1000 - c % 100) / 100 * 0.01 + (a % 1000000 - a % 100000) / 100000 * 0.001 + (c % 100 - c % 10) / 10 * 1.0E-4 + a % 10 * 1.0E-5));
    _lon = (_lonSign * ((a % 100000 - a % 10000) / 10000 * 100 + (c % 1000000 - c % 100000) / 100000 * 10 + c % 10 + (b % 1000 - b % 100) / 100 * 0.1 + (b % 1000000 - b % 100000) / 100000 * 0.01 + (a % 100 - a % 10) / 10 * 0.001 + (c % 100000 - c % 10000) / 10000 * 1.0E-4 + b % 10 * 1.0E-5));
  } else {
    _lat = (_latSign * ((b % 1000000 - b % 100000) / 100000 * 10 + a % 10 + (a % 10000 - a % 1000) / 1000 * 0.1 + (c % 1000000 - c % 100000) / 100000 * 0.01 + (c % 1000 - c % 100) / 100 * 0.001 + (c % 100 - c % 10) / 10 * 1.0E-4 + (a % 1000000 - a % 100000) / 100000 * 1.0E-5));
    _lon = (_lonSign * ((b % 100 - b % 10) / 10 * 100 + c % 10 * 10 + (a % 100 - a % 10) / 10 + (a % 100000 - a % 10000) / 10000 * 0.1 + (b % 1000 - b % 100) / 100 * 0.01 + b % 10 * 0.001 + (c % 100000 - c % 10000) / 10000 * 1.0E-4 + (b % 100000 - b % 10000) / 10000 * 1.0E-5));
  }

  return LatLng(_lat, _lon);
}

List<String> latLonToWaldmeister(LatLng coord) {
  var _lat = coord.latitude;
  var _lon = coord.longitude;

  double _a4, _b3, _c3, _tempb3, _tempc3;
  String a, b, c;

  if (_lat < 0 && _lon < 0) {
    _a4 = 4;
    _lat *= -1;
    _lon *= -1;
  } else if (_lat < 0 && _lon > 0) {
    _a4 = 2;
    _lat *= -1;
  } else if (_lat > 0 && _lon < 0) {
    _a4 = 3;
    _lon *= -1;
  } else if (_lat >= 0 && _lon >= 0) {
    _a4 = 1;
  }

  _lon = _lon + 1.0E-12;
  _lat = _lat + 1.0E-12;
  _lat = _lat * 100000 - _lat * 100000 % 1;
  _lon = _lon * 100000 - _lon * 100000 % 1;

  if ((((_lon % 100 - _lon % 10) / 10 + (_lat % 100 - _lat % 10) / 10) % 2)==0) {
    _tempb3 = (11 - ((_lat % 1000 - _lat % 100) / 100 * 8 + (_lon % 100000000 - _lon % 10000000) / 10000000 * 6 + (_lat % 10000000 - _lat % 1000000) / 1000000 * 4 + _a4 * 2 + (_lon % 1000 - _lon % 100) / 100 * 3 + _lat % 10 * 5 + (_lon % 10000 - _lon % 1000) / 1000 * 9 + (_lat % 100000 - _lat % 10000) / 10000 * 7) % 11);
    if (_tempb3 == 10) {
      _b3 = 0;
    } else if (_tempb3 == 11) {
      _b3 = 5;
    } else {
      _b3 = _tempb3;
    }

    _tempc3 = (11 - ((_lon % 100000 - _lon % 10000) / 10000 * 8 + (_lat % 1000000 - _lat % 100000) / 100000 * 6 + _lon % 10 * 4 + (_lon % 10000000 - _lon % 1000000) / 1000000 * 2 + (_lon % 100 - _lon % 10) / 10 * 3 + (_lat % 10000 - _lat % 1000) / 1000 * 5 + (_lat % 100 - _lat % 10) / 10 * 9 + (_lon % 1000000 - _lon % 100000) / 100000 * 7) % 11);

    if (_tempc3 == 10) {
      _c3 = 0;
    } else if (_tempc3 == 11) {
      _c3 = 5;
    } else {
      _c3 = _tempc3;
    }
    a = ((_lat % 1000 - _lat % 100) ~/ 100).toString() + ((_lon % 100000000 - _lon % 10000000) ~/ 10000000).toString()+ ((_lat % 10000000 - _lat % 1000000) ~/ 1000000).toString()+ _a4.toInt().toString()+ ((_lon % 1000 - _lon % 100) ~/ 100 ).toString()+  (_lat % 10).toInt().toString();
    b = ((_lon % 10000 - _lon % 1000) ~/ 1000).toString() +  ((_lat % 100000 - _lat % 10000) ~/ 10000).toString()+ _b3.toInt().toString()+ ((_lon % 100000 - _lon % 10000) ~/ 10000).toString()+ ((_lat % 1000000 - _lat % 100000) ~/ 100000).toString()+ (_lon % 10).toInt().toString();
    c = ((_lon % 10000000 - _lon % 1000000) ~/ 1000000 ).toString()+ ((_lon % 100 - _lon % 10) ~/ 10).toString()+ _c3.toInt().toString()+ ((_lat % 10000 - _lat % 1000) ~/ 1000 ).toString()+  ((_lat % 100 - _lat % 10) ~/ 10 ).toString()+  ((_lon % 1000000 - _lon % 100000) ~/ 100000).toString();
  } else {
    _tempb3 = (11 - (_lat % 10 * 8 + (_lon % 100000 - _lon % 10000) / 10000 * 6 + (_lat % 100000 - _lat % 10000) / 10000 * 4 + _a4 * 2 + (_lon % 1000000 - _lon % 100000) / 100000 * 3 + (_lat % 1000000 - _lat % 100000) / 100000 * 5 + (_lat % 10000000 - _lat % 1000000) / 1000000 * 9 + _lon % 10 * 7) % 11);

    if (_tempb3 == 10) {
      _b3 = 0;
    } else if (_tempb3 == 11) {
      _b3 = 5;
    } else {
      _b3 = _tempb3;
    }
    _tempc3 = (11 - ((_lon % 10000 - _lon % 1000) / 1000 * 8 + (_lon % 100000000 - _lon % 10000000) / 10000000 * 6 + (_lon % 1000 - _lon % 100) / 100 * 4 + (_lat % 10000 - _lat % 1000) / 1000 * 2 + (_lon % 100 - _lon % 10) / 10 * 3 + (_lat % 1000 - _lat % 100) / 100 * 5 + (_lat % 100 - _lat % 10) / 10 * 9 + (_lon % 10000000 - _lon % 1000000) / 1000000 * 7) % 11);

    if (_tempc3 == 10) {
      _c3 = 0;
    } else if (_tempc3 == 11) {
      _c3 = 5;
    } else {
      _c3 = _tempc3;
    }

    a = (_lat % 10).toInt().toString() + ((_lon % 100000 - _lon % 10000) ~/ 10000).toString() +  ((_lat % 100000 - _lat % 10000) ~/ 10000 ).toString() +  _a4.toInt().toString() +  ((_lon % 1000000 - _lon % 100000) ~/ 100000).toString() +  ((_lat % 1000000 - _lat % 100000) ~/ 100000).toString();
    b = ((_lat % 10000000 - _lat % 1000000) ~/ 1000000).toString() +  (_lon % 10).toInt().toString() +  _b3.toInt().toString() +((_lon % 10000 - _lon % 1000) ~/ 1000).toString() +  ((_lon % 100000000 - _lon % 10000000) ~/ 10000000).toString() +  ((_lon % 1000 - _lon % 100) ~/ 100).toString();
    c = ((_lat % 10000 - _lat % 1000) ~/ 1000 ).toString() +  ((_lon % 100 - _lon % 10) ~/ 10 ).toString() +  _c3.toInt().toString() + ((_lat % 1000 - _lat % 100) ~/ 100 ).toString() +  ((_lat % 100 - _lat % 10) ~/ 10 ).toString() +  ((_lon % 10000000 - _lon % 1000000) ~/ 1000000).toString();
  }

  return [a, b, c];
}

String latLonToWaldmeisterString(LatLng coord) {
  var waldmeister = latLonToWaldmeister(coord);
  return waldmeister.join('\n');
}