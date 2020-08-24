import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/science_and_technology/projectiles.dart';
import 'package:gc_wizard/logic/units/velocity.dart';
import 'package:gc_wizard/logic/units/unit.dart';
import 'package:gc_wizard/logic/units/mass.dart';
import 'package:gc_wizard/logic/units/energy.dart';
import 'package:gc_wizard/theme/theme.dart';
import 'package:gc_wizard/widgets/common/base/gcw_dropdownbutton.dart';
import 'package:gc_wizard/widgets/common/base/gcw_output_text.dart';
import 'package:gc_wizard/widgets/common/gcw_double_spinner.dart';
import 'package:gc_wizard/widgets/common/gcw_energy_dropdownbutton.dart';
import 'package:gc_wizard/widgets/common/gcw_mass_dropdownbutton.dart';
import 'package:gc_wizard/widgets/common/gcw_output.dart';
import 'package:gc_wizard/widgets/common/gcw_text_divider.dart';
import 'package:gc_wizard/widgets/common/gcw_velocity_dropdownbutton.dart';

class Projectiles extends StatefulWidget {
  @override
  ProjectilesState createState() => ProjectilesState();
}

class ProjectilesState extends State<Projectiles> {
  CalculateProjectilesMode _currentCalculateMode = CalculateProjectilesMode.ENERGY;

  var _currentVelocityUnit = VELOCITY_MS;
  var _currentMassUnit = MASS_KGRAM;
  var _currentEnergyUnit = ENERGY_JOULE;

  var _currentOutputVelocityUnit = VELOCITY_MS;
  var _currentOutputMassUnit = MASS_KGRAM;
  var _currentOutputEnergyUnit = ENERGY_JOULE;

  var unit1;
  var unit2;

  double _currentInput1 = 0.0;
  double _currentInput2 = 0.0;

  String titleInput1 = 'projectiles_mass';
  String titleInput2 = 'projectiles_velocity';

  @override
  Widget build(BuildContext context) {
    var calculateProjectilesModeItems = {
      CalculateProjectilesMode.ENERGY : i18n(context, 'projectiles_energy'),
      CalculateProjectilesMode.MASS : i18n(context, 'projectiles_mass'),
      CalculateProjectilesMode.VELOCITY : i18n(context, 'projectiles_velocity'),
    };

    return Column(
      children: <Widget>[
        Row(
          children: [
            Expanded (
              child: Container(
                child: GCWDropDownButton(
                  value: _currentCalculateMode,
                  onChanged: (value) {
                    setState(() {
                      _currentCalculateMode = value;
                    });
                    switch (_currentCalculateMode){
                      case CalculateProjectilesMode.ENERGY:
                        titleInput1 = 'projectiles_mass';
                        titleInput2 = 'projectiles_velocity';
                        unit1 = masses;
                        unit2 = velocities;
                        break;
                      case CalculateProjectilesMode.MASS:
                        titleInput1 = 'projectiles_energy';
                        titleInput2 = 'projectiles_velocity';
                        unit1 = energies;
                        unit2 = velocities;
                        break;
                      case CalculateProjectilesMode.VELOCITY:
                        titleInput1 = 'projectiles_energy';
                        titleInput2 = 'projectiles_mass';
                        unit1 = energies;
                        unit2 = masses;
                        break;
                    }
                  },
                  items: calculateProjectilesModeItems.entries.map((mode) {
                    return DropdownMenuItem(
                      value: mode.key,
                      child: Text(mode.value),
                    );
                  }).toList(),
                ),
                  padding: EdgeInsets.only(right: 2 * DEFAULT_MARGIN),
              ),
              flex: 3
            ),

            _currentCalculateMode == CalculateProjectilesMode.ENERGY
            ? Expanded(
                child: GCWEnergyDropDownButton(
                  value: _currentOutputEnergyUnit,
                    onChanged: (value) {
                      setState(() {
                        _currentOutputEnergyUnit = value;
                      });
                    },
                ),
                flex: 1
              )
            : _currentCalculateMode == CalculateProjectilesMode.MASS
              ? Expanded(
                child: GCWMassDropDownButton(
                  value: _currentOutputMassUnit,
                  onChanged: (value) {
                    setState(() {
                      _currentOutputMassUnit = value;
                    });
                  },
                ),
                flex: 1
                )
              : _currentCalculateMode == CalculateProjectilesMode.VELOCITY
                ? Expanded(
                child: GCWVelocityDropDownButton(
                  value: _currentOutputVelocityUnit,
                  onChanged: (value) {
                    setState(() {
                      _currentOutputVelocityUnit = value;
                    });
                  },
                ),
                flex: 1
                  )
                : null,
          ]
        ),

        /*
        GCWUnitInput(
          title: i18n(context, titleInput1),
          min: 0.0,
          numberDecimalDigits: 3,
          value: _currentInput1,
          unit, _currentUnit1,
          items: unit1,
          onChanged: (value) {
            setState(() {
              _currentInput1 = value;
              _currentUnit1 = unit;
            }
          }

         */
        _currentCalculateMode == CalculateProjectilesMode.ENERGY
          ? Column(
            children: <Widget>[
              Row(
                children: [
                  Expanded(
                    child: Container(
                      child: GCWDoubleSpinner(
                        title: i18n(context, titleInput1),
                        min: 0.0,
                        numberDecimalDigits: 3,
                        value: _currentInput1,
                        onChanged: (value) {
                          setState(() {
                            _currentInput1 = value;
                          });
                        },
                      ),
                      padding: EdgeInsets.only(right: 2 * DEFAULT_MARGIN),
                    ),
                    flex: 3
                  ),
                  Expanded(
                    child: GCWMassDropDownButton(
                      value: _currentMassUnit,
                      onChanged: (value) {
                        setState(() {
                          _currentMassUnit = value;
                        });
                      },
                    ),
                    flex: 1
                  )
                ], // children
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      child: GCWDoubleSpinner(
                        title: i18n(context, titleInput2),
                        min: 0.0,
                        numberDecimalDigits: 3,
                        value: _currentInput2,
                        onChanged: (value) {
                          setState(() {
                            _currentInput2 = value;
                          });
                        },
                      ),
                      padding: EdgeInsets.only(right: 2 * DEFAULT_MARGIN),
                    ),
                    flex: 3
                  ),
                  Expanded(
                  child: GCWVelocityDropDownButton(
                    value: _currentVelocityUnit,
                    onChanged: (value) {
                      setState(() {
                        _currentVelocityUnit = value;
                      });
                      },
                  ),
                  flex: 1
                  )
                ], //children
              ),
            ]
          )
          : _currentCalculateMode == CalculateProjectilesMode.MASS
          ? Column(
            children: <Widget>[
              Row(
                children: [
                  Expanded(
                      child: Container(
                        child: GCWDoubleSpinner(
                          title: i18n(context, titleInput1),
                          min: 0.0,
                          numberDecimalDigits: 3,
                          value: _currentInput1,
                          onChanged: (value) {
                            setState(() {
                              _currentInput1 = value;
                            });
                          },
                        ),
                        padding: EdgeInsets.only(right: 2 * DEFAULT_MARGIN),
                      ),
                      flex: 3
                  ),
                  Expanded(
                      child: GCWEnergyDropDownButton(
                        value: _currentEnergyUnit,
                        onChanged: (value) {
                          setState(() {
                            _currentEnergyUnit = value;
                          });
                        },
                      ),
                      flex: 1
                  )
                ],
              ),
              Row(
                children: [
                  Expanded(
                      child: Container(
                        child: GCWDoubleSpinner(
                          title: i18n(context, titleInput2),
                          min: 0.0,
                          numberDecimalDigits: 3,
                          value: _currentInput2,
                          onChanged: (value) {
                            setState(() {
                              _currentInput2 = value;
                            });
                          },
                        ),
                        padding: EdgeInsets.only(right: 2 * DEFAULT_MARGIN),
                      ),
                      flex: 3
                  ),
                  Expanded(
                      child: GCWVelocityDropDownButton(
                        value: _currentVelocityUnit,
                        onChanged: (value) {
                          setState(() {
                            _currentVelocityUnit = value;
                          });
                        },
                      ),
                      flex: 1
                  )
                ],
              ),
            ]
        )
          : _currentCalculateMode == CalculateProjectilesMode.VELOCITY
          ? Column(
            children: <Widget>[
              Row(
                children: [
                  Expanded(
                      child: Container(
                        child: GCWDoubleSpinner(
                          title: i18n(context, titleInput1),
                          min: 0.0,
                          numberDecimalDigits: 3,
                          value: _currentInput1,
                          onChanged: (value) {
                            setState(() {
                              _currentInput1 = value;
                            });
                          },
                        ),
                        padding: EdgeInsets.only(right: 2 * DEFAULT_MARGIN),
                      ),
                      flex: 3
                  ),
                  Expanded(
                      child: GCWEnergyDropDownButton(
                        value: _currentEnergyUnit,
                        onChanged: (value) {
                          setState(() {
                            _currentEnergyUnit = value;
                          });
                        },
                      ),
                      flex: 1
                  )
                ],
              ),
              Row(
                children: [
                  Expanded(
                      child: Container(
                        child: GCWDoubleSpinner(
                          title: i18n(context, titleInput2),
                          min: 0.0,
                          numberDecimalDigits: 3,
                          value: _currentInput2,
                          onChanged: (value) {
                            setState(() {
                              _currentInput2 = value;
                            });
                          },
                        ),
                        padding: EdgeInsets.only(right: 2 * DEFAULT_MARGIN),
                      ),
                      flex: 3
                  ),
                  Expanded(
                      child: GCWMassDropDownButton(
                        value: _currentMassUnit,
                        onChanged: (value) {
                          setState(() {
                            _currentMassUnit = value;
                          });
                        },
                      ),
                      flex: 1
                  )
                ],
              ),
            ]
        )
          : null,
        _buildOutput(context)
      ],
    );
  }

  Widget _buildOutput(BuildContext context) {
    String calculate = '';
    String result = '';

    switch (_currentCalculateMode){
      case CalculateProjectilesMode.ENERGY:
        calculate = 'projectiles_energy';
        result = convert(calculateEnergy(convert(_currentInput1 , _currentMassUnit, MASS_KGRAM),
                                         convert(_currentInput2 , _currentVelocityUnit, VELOCITY_MS)),
                         ENERGY_JOULE, _currentOutputEnergyUnit)
                        .toStringAsFixed(3) + ' ' + _currentOutputEnergyUnit.symbol;
        break;
      case CalculateProjectilesMode.MASS:
        calculate = 'projectiles_mass';
        result = convert(calculateMass(convert(_currentInput1, _currentEnergyUnit, ENERGY_JOULE),
                                       convert(_currentInput2, _currentVelocityUnit, VELOCITY_MS)),
                         MASS_KGRAM, _currentOutputMassUnit)
                        .toStringAsFixed(3) + ' ' + _currentOutputMassUnit.symbol;
        break;
      case CalculateProjectilesMode.VELOCITY:
        calculate = 'projectiles_velocity';
        result = convert(calculateVelocity(convert(_currentInput1, _currentEnergyUnit, ENERGY_JOULE),
                                        convert(_currentInput2, _currentMassUnit, MASS_KGRAM)),
                         VELOCITY_MS, _currentOutputVelocityUnit)
                        .toStringAsFixed(3) + ' ' + _currentOutputVelocityUnit.symbol;
        break;
    }

    return GCWOutput(
      child: Column(
        children: <Widget>[
          GCWTextDivider(
              text: i18n(context, calculate)
          ),

          GCWOutputText(
              text: result
          ),
        ],
      ),
    );
  }
}