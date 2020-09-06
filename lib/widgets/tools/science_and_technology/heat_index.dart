import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/science_and_technology/heat_index.dart';
import 'package:gc_wizard/logic/units/temperature.dart';
import 'package:gc_wizard/widgets/common/gcw_double_spinner.dart';
import 'package:gc_wizard/widgets/common/gcw_multiple_output.dart';
import 'package:gc_wizard/widgets/common/gcw_output.dart';
import 'package:gc_wizard/widgets/common/gcw_twooptions_switch.dart';

class HeatIndex extends StatefulWidget {
  @override
  HeatIndexState createState() => HeatIndexState();
}

class HeatIndexState extends State<HeatIndex> {

  double _currentTemperature = 0.0;
  double _currentHumidity = 0.0;

  var _isMetric = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GCWDoubleSpinner(
            title: i18n(context, 'heatindex_temperature'),
            value: _currentTemperature,
            onChanged: (value) {
              setState(() {
                _currentTemperature = value;
              });
            }
        ),

        GCWTwoOptionsSwitch(
          title: i18n(context, 'heatindex_unit'),
          leftValue: i18n(context, 'heatindex_unit_celsius'),
          rightValue: i18n(context, 'heatindex_unit_fahrenheit'),
          value: _isMetric ? GCWSwitchPosition.left : GCWSwitchPosition.right,
          onChanged: (value) {
            setState(() {
              _isMetric = value == GCWSwitchPosition.left;
            });
          },
        ),

        GCWDoubleSpinner(
            title: i18n(context, 'heatindex_humidity'),
            value: _currentHumidity,
            min: 0.0,
            max: 100.0,
            onChanged: (value) {
              setState(() {
                _currentHumidity = value;
              });
            }
        ),
        _buildOutput(context)
      ],
    );
  }

  Widget _buildOutput(BuildContext context) {
    String unit = '';

    double output;
    if (_isMetric) {
      output = calculateHeatIndex(_currentTemperature, _currentHumidity, TEMPERATURE_CELSIUS);
      unit = TEMPERATURE_CELSIUS.symbol;
    } else {
      output = calculateHeatIndex(_currentTemperature, _currentHumidity, TEMPERATURE_FAHRENHEIT);
      unit = TEMPERATURE_FAHRENHEIT.symbol;
    }

    String hintT;
    if (
    (_isMetric && _currentTemperature < 27)
        || (!_isMetric && _currentTemperature < 80)
    ) {
      hintT = i18n(context, 'heatindex_hint_temperature', parameters: ['${_isMetric ? 27 : 80} $unit']);
    }

    String hintH;
    if (_currentHumidity < 40)
      hintH = i18n(context, 'heatindex_hint_humidity');

    var hint = [hintT, hintH].where((element) => element != null && element.length > 0).join('\n');

    String hintM;
    if (output > 54)
      hintM = 'heatindex_index_54';
    else
    if (output > 40)
      hintM = 'heatindex_index_40';
    else
    if (output > 32)
      hintM = 'heatindex_index_32';
    else
    if (output > 27)
      hintM = 'heatindex_index_27';

    var outputs = [
      GCWOutput(
        title: i18n(context, 'heatindex_output'),
        child: output.toStringAsFixed(3) + ' ' + unit,
      )
    ];

    if (hint != null && hint.length > 0)
      outputs.add(
        GCWOutput(
          title: i18n(context, 'heatindex_hint'),
          child: hint
        )
      );

    if (hintM != null && hintM.length > 0)
      outputs.add(
        GCWOutput(
          title: i18n(context, 'heatindex_meaning'),
          child: i18n(context, hintM)
        )
      );

    return GCWMultipleOutput(
      children: outputs,
    );
  }
}