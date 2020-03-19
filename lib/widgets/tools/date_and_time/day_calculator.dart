import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/theme/colors.dart';
import 'package:gc_wizard/widgets/common/base/gcw_text.dart';
import 'package:gc_wizard/widgets/common/gcw_date_picker.dart';
import 'package:gc_wizard/widgets/common/gcw_onoff_switch.dart';
import 'package:gc_wizard/widgets/common/gcw_text_divider.dart';
import 'package:gc_wizard/widgets/utils/common_widget_utils.dart';
import 'package:intl/intl.dart';

class DayCalculator extends StatefulWidget {
  @override
  DayCalculatorState createState() => DayCalculatorState();
}

class DayCalculatorState extends State<DayCalculator> {

  DateTime _currentStartDate;
  DateTime _currentEndDate;

  var _currentCountStart = true;
  var _currentCountEnd = true;

  @override
  void initState() {
    DateTime now = DateTime.now();
    _currentStartDate = DateTime(now.year, now.month, now.day);
    _currentEndDate = DateTime(now.year, now.month, now.day);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GCWTextDivider(
          text: i18n(context, 'dates_daycalculator_startdate')
        ),
        GCWDatePicker(
          date: _currentStartDate,
          onChanged: (value) {
            setState(() {
              _currentStartDate = value;
            });
          },
        ),
        GCWTextDivider(
            text: i18n(context, 'dates_daycalculator_enddate')
        ),
        GCWDatePicker(
          date: _currentEndDate,
          onChanged: (value) {
            setState(() {
              _currentEndDate = value;
            });
          },
        ),
        GCWOnOffSwitch(
          title: i18n(context, 'dates_daycalculator_countstart'),
          value: _currentCountStart,
          onChanged: (value) {
            setState(() {
              _currentCountStart = value;
            });
          },
        ),
        GCWOnOffSwitch(
          title: i18n(context, 'dates_daycalculator_countend'),
          value: _currentCountEnd,
          onChanged: (value) {
            setState(() {
              _currentCountEnd = value;
            });
          },
        ),
        _buildOutput()
      ],
    );
  }

  Widget _buildOutput() {
    Duration difference = _currentEndDate.difference(_currentStartDate);

    if (!_currentCountStart)
      difference -= Duration(days: 1);
    if (_currentCountEnd)
      difference += Duration(days: 1);

    var outputData = {
      'dates_daycalculator_days' : difference.inDays,
      'dates_daycalculator_hours' : difference.inHours,
      'dates_daycalculator_minutes' : difference.inMinutes,
      'dates_daycalculator_seconds' : difference.inSeconds
    };

    var rows = twoColumnMultiLineOutput(context, outputData);

    rows.insert(0,
      GCWTextDivider(
        text: i18n(context, 'common_output')
      )
    );

    return Column(
      children: rows
    );
  }
}