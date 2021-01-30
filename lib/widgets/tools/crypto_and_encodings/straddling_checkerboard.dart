import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/straddling_checkerboard.dart';
import 'package:gc_wizard/utils/constants.dart';
import 'package:gc_wizard/widgets/common/base/gcw_output_text.dart';
import 'package:gc_wizard/widgets/common/base/gcw_text.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/common/gcw_default_output.dart';
import 'package:gc_wizard/widgets/common/gcw_multiple_output.dart';
import 'package:gc_wizard/widgets/common/gcw_output.dart';
import 'package:gc_wizard/widgets/common/gcw_text_divider.dart';
import 'package:gc_wizard/widgets/common/gcw_twooptions_switch.dart';

class StraddlingCheckerboard extends StatefulWidget {
  @override
  StraddlingCheckerboardState createState() => StraddlingCheckerboardState();
}

class StraddlingCheckerboardState extends State<StraddlingCheckerboard> {
  var _plainTextController;
  var _chiffreTextController;
  var _KeyController;

  var _currentMode = GCWSwitchPosition.right;
  var _currentDigitMode = GCWSwitchPosition.right;

  String _currentPlainText = '';
  String _currentChiffreText = '';
  String _currentKey = '';
  String _output = '';

  @override
  void initState() {
    super.initState();
    _plainTextController = TextEditingController(text: _currentPlainText);
    _chiffreTextController = TextEditingController(text: _currentChiffreText);
    _KeyController = TextEditingController(text: _currentKey);
  }

  @override
  void dispose() {
    _plainTextController.dispose();
    _chiffreTextController.dispose();
    _KeyController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _currentMode == GCWSwitchPosition.left
        ? GCWTextField(
            controller: _plainTextController,
            hintText: i18n(context, 'straddlingcheckerboard_hint_text'),
            inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[A-Za-z ./]')),],
            onChanged: (text) {
              setState(() {
                _currentPlainText = text;
              });
            },
          )
        : GCWTextField(
            controller: _chiffreTextController,
            hintText: i18n(context, 'straddlingcheckerboard_hint_text'),
            inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),],
            onChanged: (text) {
              setState(() {
                _currentChiffreText = text;
              });
            },
          ),
        GCWTwoOptionsSwitch(
          value: _currentMode,
          onChanged: (value) {
            setState(() {
              _currentMode = value;
            });
          },
        ),
        GCWTwoOptionsSwitch(
          value: _currentDigitMode,
          leftValue: i18n(context, 'straddlingcheckerboard_digitmode_4x10'),
          rightValue: i18n(context, 'straddlingcheckerboard_digitmode_escape'),
          onChanged: (value) {
            setState(() {
              _currentDigitMode = value;
            });
          },
        ),
        GCWTextField(
          controller: _KeyController,
          hintText: i18n(context, 'straddlingcheckerboard_hint_key'),
          inputFormatters: [LengthLimitingTextInputFormatter(10),
                            FilteringTextInputFormatter.allow(RegExp(r'[A-Za-z ]')),],
          onChanged: (text) {
            setState(() {
              _currentKey = text;
            });
          },
        ),

        _buildOutput()
      ],
    );
  }

  _buildOutput() {

    if (_currentPlainText == null || _currentPlainText.length == 0 || _currentChiffreText == null || _currentChiffreText.length == 0)
      return GCWDefaultOutput(child: '');

    StraddlingCheckerboardOutput _currentOutput = StraddlingCheckerboardOutput('', '');
    if (_currentMode == GCWSwitchPosition.left) {
      _currentOutput = encryptStraddlingCheckerboard(_currentPlainText.toUpperCase().replaceAll(' ', '.'), _currentKey.toUpperCase());
    } else {
      _currentOutput = decryptStraddlingCheckerboard(_currentChiffreText.toUpperCase(), _currentKey.toUpperCase());
    }

    if (_currentOutput.output.contains('error'))
      _output = i18n(context, _currentOutput.output);
    else
      _output = _currentOutput.output;
          
    return GCWMultipleOutput(
      children: [
        _output,
        GCWOutput(
            title: i18n(context, 'straddlingcheckerboard_usedgrid'),
            child: GCWOutputText(
              text: _currentOutput.grid,
              isMonotype: true,
            )
        )
      ],
    );
  }
}