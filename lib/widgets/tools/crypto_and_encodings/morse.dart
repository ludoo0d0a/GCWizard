import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/morse.dart';
import 'package:gc_wizard/theme/theme.dart';
import 'package:gc_wizard/widgets/utils/common_widget_utils.dart';
import 'package:gc_wizard/widgets/common/base/gcw_button.dart';
import 'package:gc_wizard/widgets/common/base/gcw_iconbutton.dart';
import 'package:gc_wizard/widgets/common/base/gcw_output_text.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/common/gcw_toolbar.dart';
import 'package:gc_wizard/widgets/common/gcw_text_divider.dart';
import 'package:gc_wizard/widgets/common/gcw_twooptions_switch.dart';

class Morse extends StatefulWidget {
  @override
  MorseState createState() => MorseState();
}

class MorseState extends State<Morse> {
  TextEditingController _encodeController;
  TextEditingController _decodeController;

  var _currentEncodeInput = '';
  var _currentDecodeInput = '';
  GCWSwitchPosition _currentMode = GCWSwitchPosition.right;

  @override
  void initState() {
    super.initState();

    _encodeController = TextEditingController(text: _currentEncodeInput);
    _decodeController = TextEditingController(text: _currentDecodeInput);
  }

  @override
  void dispose() {
    _encodeController.dispose();
    _decodeController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GCWTwoOptionsSwitch(
          value: _currentMode,
          onChanged: (value) {
            setState(() {
              _currentMode = value;
            });
          },
        ),
        _buildMorseButtons(context),
        _currentMode == GCWSwitchPosition.left
            ? GCWTextField(
                controller: _encodeController,
                onChanged: (text) {
                  setState(() {
                    _currentEncodeInput = text;
                  });
                },
              )
            : GCWTextField(
                controller: _decodeController,
                onChanged: (text) {
                  setState(() {
                    _currentDecodeInput = text;
                  });
                },
              ),
        GCWTextDivider(text: i18n(context, 'common_output')),
        _buildOutput(context)
      ],
    );
  }

  Widget _buildMorseButtons(BuildContext context) {
    if (_currentMode == GCWSwitchPosition.left) return Container();

    return GCWToolBar(children: [
      GCWButton(
        text: i18n(context, 'morse_short'),
        onPressed: () {
          setState(() {
            _addCharacter('.');
          });
        },
      ),
      GCWButton(
        text: i18n(context, 'morse_long'),
        onPressed: () {
          setState(() {
            _addCharacter('-');
          });
        },
      ),
      GCWButton(
        text: i18n(context, 'morse_next_letter'),
        onPressed: () {
          setState(() {
            _addCharacter(' ');
          });
        },
      ),
      GCWButton(
        text: i18n(context, 'morse_next_word'),
        onPressed: () {
          setState(() {
            _addCharacter(' | ');
          });
        },
      ),
      GCWIconButton(
        iconData: Icons.backspace,
        onPressed: () {
          setState(() {
            _currentDecodeInput = textControllerDoBackSpace(_currentDecodeInput, _decodeController);
          });
        },
      ),
    ]);
  }

  _addCharacter(String input) {
    _currentDecodeInput = textControllerInsertText(input, _currentDecodeInput, _decodeController);
  }

  Widget _buildOutput(BuildContext context) {
    var output = '';

    var textStyle = gcwTextStyle();
    if (_currentMode == GCWSwitchPosition.left) {
      output = encodeMorse(_currentEncodeInput);
      textStyle =
          TextStyle(fontSize: textStyle.fontSize + 15, fontFamily: textStyle.fontFamily, fontWeight: FontWeight.bold);
    } else
      output = decodeMorse(_currentDecodeInput);

    return GCWOutputText(text: output, style: textStyle);
  }
}
