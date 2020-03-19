import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/theme/theme.dart';
import 'package:gc_wizard/widgets/common/base/gcw_button.dart';
import 'package:gc_wizard/widgets/common/base/gcw_text.dart';
import 'package:gc_wizard/widgets/common/coords/gcw_map_geometries.dart';
import 'package:gc_wizard/widgets/common/gcw_double_textfield.dart';
import 'package:gc_wizard/widgets/common/gcw_default_output.dart';
import 'package:gc_wizard/widgets/common/gcw_tool.dart';
import 'package:gc_wizard/widgets/common/coords/gcw_mapview.dart';
import 'package:gc_wizard/widgets/utils/textinputformatter/double_bearing_textinputformatter.dart';
import 'package:latlong/latlong.dart';

class GCWBearing extends StatefulWidget {
  final Function onChanged;
  final String hintText;

  const GCWBearing({Key key, this.onChanged, this.hintText}) : super(key: key);

  @override
  _GCWBearingState createState() => _GCWBearingState();
}

class _GCWBearingState extends State<GCWBearing> {
  var _bearingController;
  var _currentBearing = {'text': '','value': 0.0};

  @override
  void initState() {
    super.initState();
    _bearingController = TextEditingController(text: _currentBearing['text']);
  }

  @override
  void dispose() {
    _bearingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          flex: 3,
          child: GCWDoubleTextField(
            hintText: widget.hintText ?? i18n(context, 'common_bearing_hint'),
            controller: _bearingController,
            textInputFormatter: DoubleBearingTextInputFormatter(),
            onChanged: (ret) {
              setState(() {
                _currentBearing = ret;
                widget.onChanged(_currentBearing);
              });
            },
          ),
        ),
        Expanded(
          flex: 1,
          child: GCWText(
              text: '°'
          ),
        ),
      ]
    );
  }
}
