import 'package:flutter/material.dart';
import 'package:gc_wizard/logic/tools/crypto/enigma.dart';
import 'package:gc_wizard/widgets/common/base/gcw_dropdownbutton.dart';
import 'package:gc_wizard/widgets/common/gcw_abc_dropdownbutton.dart';

class GCWEnigmaRotor extends StatefulWidget {
  final Function onChanged;
  final EnigmaRotorType type;
  final position;

  const GCWEnigmaRotor({
    Key key,
    this.position,
    this.type: EnigmaRotorType.STANDARD,
    this.onChanged
  }) : super(key: key);

  @override
  GCWEnigmaRotorState createState() => GCWEnigmaRotorState();
}

class GCWEnigmaRotorState extends State<GCWEnigmaRotor> {
  var _currentRotor;
  var _currentOffset = 1;
  var _currentSetting = 1;

  @override
  void initState() {
    super.initState();

    switch (widget.type) {
      case EnigmaRotorType.STANDARD:
        _currentRotor = defaultRotorStandard;
        break;
      case EnigmaRotorType.ENTRY_ROTOR:
        _currentRotor = defaultRotorEntryRotor;
        break;
      case EnigmaRotorType.REFLECTOR:
        _currentRotor = defaultRotorReflector;
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: GCWDropDownButton(
            value: _currentRotor,
            items: allEnigmaRotors
              .where((rotor) => rotor.type == widget.type)
              .map((rotor) {
                return DropdownMenuItem(
                  value: rotor.name,
                  child: Text('${rotor.name}'),
                );
              })
              .toList(),
            onChanged: (value) {
              setState(() {
                _currentRotor = value;
                _setCurrentValueAndEmitOnChange();
              });
            },
          ),
          flex: 2
        ),
        widget.type == EnigmaRotorType.STANDARD
          ? Expanded(
              child: GCWABCDropDownButton(
                value: _currentOffset,
                onChanged: (value) {
                  setState(() {
                    _currentOffset = value;
                    _setCurrentValueAndEmitOnChange();
                  });
                },
              ),
              flex: 1
            )
          : Container(),
        widget.type == EnigmaRotorType.STANDARD
          ? Expanded(
              child: GCWABCDropDownButton(
                value: _currentSetting,
                onChanged: (value) {
                  setState(() {
                    _currentSetting = value;
                    _setCurrentValueAndEmitOnChange();
                  });
                },
              ),
              flex: 1
            )
          : Container(),
      ],
    );
  }

  _setCurrentValueAndEmitOnChange() {
    widget.onChanged({
      'position': widget.position,
      'rotorConfiguration': EnigmaRotorConfiguration(
          getEnigmaRotorByName(_currentRotor),
          offset: _currentOffset,
          setting: _currentSetting
      )
    });
  }
}