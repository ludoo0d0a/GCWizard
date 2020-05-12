import 'package:flutter/material.dart';
import 'package:gc_wizard/theme/theme.dart';
import 'package:gc_wizard/widgets/common/base/gcw_divider.dart';
import 'package:gc_wizard/widgets/common/base/gcw_iconbutton.dart';

class GCWTextDivider extends StatefulWidget {
  final String text;
  final GCWIconButton trailingButton;
  final bottom;

  const GCWTextDivider({Key key, this.text: '', this.trailingButton, this.bottom}) : super(key: key);

  @override
  _GCWTextDividerState createState() => _GCWTextDividerState();
}

class _GCWTextDividerState extends State<GCWTextDivider> {
  @override
  Widget build(BuildContext context) {

    return Container(
      margin: EdgeInsets.only(
        top: 25.0,
        bottom: widget.bottom ?? 10.0
      ),
      child: Row(children: <Widget>[
        Text(
          widget.text != '' ? '${widget.text}:' : '',
          style: gcwTextStyle()
        ),
        Expanded(
          child: GCWDivider()
        ),
        widget.trailingButton ?? Container()
      ])
    );
  }
}
