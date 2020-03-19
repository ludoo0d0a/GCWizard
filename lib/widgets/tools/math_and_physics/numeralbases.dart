import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/math_and_physics/numeral_bases.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/common/gcw_numeralbase_spinner.dart';
import 'package:gc_wizard/widgets/common/gcw_default_output.dart';
import 'package:gc_wizard/widgets/common/gcw_text_divider.dart';

class NumeralBases extends StatefulWidget {
  @override
  NumeralBasesState createState() => NumeralBasesState();
}

class NumeralBasesState extends State<NumeralBases> {
  var _controller;

  String _currentInput = '';
  int _currentFromKey = 10;
  int _currentToKey = 2;
  String _output = '';

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(
        text: _currentInput
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GCWTextField(
          controller: _controller,
          onChanged: (text) {
            setState(() {
              _currentInput = text;
              _calculateOutput();
            });
          },
        ),
        GCWTextDivider(
          text: i18n(context, 'numeralbases_from')
        ),
        GCWNumeralBaseSpinner(
          onChanged: (value) {
            setState(() {
              _currentFromKey = value;
              _calculateOutput();
            });
          },
        ),GCWTextDivider(
            text: i18n(context, 'numeralbases_to')
        ),
        GCWNumeralBaseSpinner(
          value: _currentToKey,
          onChanged: (value) {
            setState(() {
              _currentToKey = value;
              _calculateOutput();
            });
          },
        ),
        GCWDefaultOutput(
            text: _output
        )
      ],
    );
  }

  _calculateOutput() {
    _output = convertBase(_currentInput, _currentFromKey, _currentToKey);
  }
}