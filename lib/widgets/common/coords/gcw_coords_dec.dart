import 'package:flutter/material.dart';
import 'package:gc_wizard/logic/tools/coords/converter/latlon.dart';
import 'package:gc_wizard/widgets/common/base/gcw_text.dart';
import 'package:gc_wizard/widgets/common/coords/gcw_coords_sign_dropdownbutton.dart';
import 'package:gc_wizard/widgets/common/coords/utils.dart';
import 'package:gc_wizard/widgets/common/gcw_integer_textfield.dart';
import 'package:gc_wizard/widgets/utils/textinputformatter/coords_integer_degrees_lat_textinputformatter.dart';
import 'package:gc_wizard/widgets/utils/textinputformatter/coords_integer_degrees_lon_textinputformatter.dart';
import 'package:latlong/latlong.dart';

class GCWCoordsDEC extends StatefulWidget {
  final Function onChanged;

  const GCWCoordsDEC({Key key, this.onChanged}) : super(key: key);

  @override
  GCWCoordsDECState createState() => GCWCoordsDECState();
}

class GCWCoordsDECState extends State<GCWCoordsDEC> {
  var _LatDegreesController;
  var _LatMilliDegreesController;
  var _LonDegreesController;
  var _LonMilliDegreesController;

  FocusNode _latMilliDegreesFocusNode;
  FocusNode _lonMilliDegreesFocusNode;

  int _currentLatSign = defaultHemiphereLatitude();
  int _currentLonSign = defaultHemiphereLongitude();

  String _currentLatDegrees = '';
  String _currentLatMilliDegrees = '';
  String _currentLonDegrees = '';
  String _currentLonMilliDegrees = '';

  @override
  void initState() {
    super.initState();
    _LatDegreesController = TextEditingController(text: _currentLatDegrees);
    _LatMilliDegreesController = TextEditingController(text: _currentLatMilliDegrees);

    _LonDegreesController = TextEditingController(text: _currentLonDegrees);
    _LonMilliDegreesController = TextEditingController(text: _currentLonMilliDegrees);

    _latMilliDegreesFocusNode = FocusNode();
    _lonMilliDegreesFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _LatDegreesController.dispose();
    _LatMilliDegreesController.dispose();
    _LonDegreesController.dispose();
    _LonMilliDegreesController.dispose();

    _latMilliDegreesFocusNode.dispose();
    _lonMilliDegreesFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column (
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                flex: 6,
                child: GCWCoordsSignDropDownButton(
                    itemList: ['+','-'],
                    value: _currentLatSign,
                    onChanged: (value) {
                      setState(() {
                        _currentLatSign = value;
                        _setCurrentValueAndEmitOnChange();
                      });
                    }
                ),
              ),
              Expanded(
                flex: 6,
                child: GCWIntegerTextField(
                    hintText: 'DD',
                    textInputFormatter: CoordsIntegerDegreesLatTextInputFormatter(allowNegativeValues: false),
                    controller: _LatDegreesController,
                    onChanged: (ret) {
                      setState(() {
                        _currentLatDegrees = ret['text'];
                        _setCurrentValueAndEmitOnChange();

                        if (_currentLatDegrees.length == 2)
                          FocusScope.of(context).requestFocus(_latMilliDegreesFocusNode);
                      });
                    }
                ),
              ),
              Expanded(
                flex: 1,
                child: GCWText(
                    align: Alignment.center,
                    text: '.'
                ),
              ),
              Expanded (
                flex: 20,
                child: GCWIntegerTextField(
                    hintText: 'DDD',
                    min: 0,
                    controller: _LatMilliDegreesController,
                    focusNode: _latMilliDegreesFocusNode,
                    onChanged: (ret) {
                      setState(() {
                        _currentLatMilliDegrees = ret['text'];
                        _setCurrentValueAndEmitOnChange();
                      });
                    }
                ),
              ),
              Expanded(
                flex: 1,
                child: GCWText(
                    align: Alignment.center,
                    text: '°'
                ),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Expanded(
                flex: 6,
                child: GCWCoordsSignDropDownButton(
                    itemList: ['+','-'],
                    value: _currentLonSign,
                    onChanged: (value) {
                      setState(() {
                        _currentLonSign = value;
                        _setCurrentValueAndEmitOnChange();
                      });
                    }
                ),
              ),
              Expanded(
                flex: 6,
                child: GCWIntegerTextField(
                    hintText: 'DD',
                    textInputFormatter: CoordsIntegerDegreesLonTextInputFormatter(allowNegativeValues: false),
                    controller: _LonDegreesController,
                    onChanged: (ret) {
                      setState(() {
                        _currentLonDegrees = ret['text'];
                        _setCurrentValueAndEmitOnChange();

                        if (_currentLonDegrees.length == 3)
                          FocusScope.of(context).requestFocus(_lonMilliDegreesFocusNode);
                      });
                    }
                ),
              ),
              Expanded(
                flex: 1,
                child: GCWText(
                    align: Alignment.center,
                    text: '.'
                ),
              ),
              Expanded (
                flex: 20,
                child: GCWIntegerTextField(
                    hintText: 'DDD',
                    min: 0,
                    controller: _LonMilliDegreesController,
                    focusNode: _lonMilliDegreesFocusNode,
                    onChanged: (ret) {
                      setState(() {
                        _currentLonMilliDegrees = ret['text'];
                        _setCurrentValueAndEmitOnChange();
                      });
                    }
                ),
              ),
              Expanded(
                flex: 1,
                child: GCWText(
                    align: Alignment.center,
                    text: '°'
                ),
              ),
            ],
          )
        ]
    );
  }

  _setCurrentValueAndEmitOnChange() {
    int _degrees = ['', '-'].contains(_currentLatDegrees) ? 0 : int.parse(_currentLatDegrees);
    double _degreesD = double.parse('$_degrees.$_currentLatMilliDegrees');
    double _currentLat = _currentLatSign * _degreesD;

    _degrees = ['', '-'].contains(_currentLonDegrees) ? 0 : int.parse(_currentLonDegrees);
    _degreesD = double.parse('$_degrees.$_currentLonMilliDegrees');
    double _currentLon = _currentLonSign * _degreesD;

    widget.onChanged(LatLng(normalizeLat(_currentLat), normalizeLon(_currentLon)));
  }
}