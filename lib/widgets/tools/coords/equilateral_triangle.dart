import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/coords/data/coordinates.dart';
import 'package:gc_wizard/logic/tools/coords/equilateral_triangle.dart';
import 'package:gc_wizard/logic/tools/coords/utils.dart';
import 'package:gc_wizard/theme/colors.dart';
import 'package:gc_wizard/widgets/common/coords/gcw_coords.dart';
import 'package:gc_wizard/widgets/common/coords/gcw_coords_output.dart';
import 'package:gc_wizard/widgets/common/coords/gcw_coords_outputformat.dart';
import 'package:gc_wizard/widgets/common/coords/gcw_map_geometries.dart';
import 'package:gc_wizard/widgets/common/coords/utils.dart';
import 'package:gc_wizard/widgets/common/gcw_submit_button.dart';

class EquilateralTriangle extends StatefulWidget {
  @override
  EquilateralTriangleState createState() => EquilateralTriangleState();
}

class EquilateralTriangleState extends State<EquilateralTriangle> {
  var _currentIntersections = [];

  var _currentCoordsFormat1 = defaultCoordFormat();
  var _currentCoords1 = defaultCoordinate;

  var _currentCoordsFormat2 = defaultCoordFormat();
  var _currentCoords2 = defaultCoordinate;

  var _currentOutputFormat = defaultCoordFormat();
  var _currentOutput = '';
  var _currentMapPoints;
  List<MapGeodetic> _currentMapGeodetics;

  @override
  void initState() {
    super.initState();
    _currentMapPoints = [
      MapPoint(point: _currentCoords1),
      MapPoint(point: _currentCoords2)
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GCWCoords(
          text: i18n(context, "coords_equilateraltriangle_coorda"),
          coordsFormat: _currentCoordsFormat1,
          onChanged: (ret) {
            setState(() {
              _currentCoordsFormat1 = ret['coordsFormat'];
              _currentCoords1 = ret['value'];
            });
          },
        ),
        GCWCoords(
          text: i18n(context, "coords_equilateraltriangle_coordb"),
          coordsFormat: _currentCoordsFormat2,
          onChanged: (ret) {
            setState(() {
              _currentCoordsFormat2 = ret['coordsFormat'];
              _currentCoords2 = ret['value'];
            });
          },
        ),
        GCWCoordsOutputFormat(
          coordFormat: _currentOutputFormat,
          onChanged: (value) {
            setState(() {
              _currentOutputFormat = value;
            });
          },
        ),
        GCWSubmitFlatButton(
          onPressed: () {
            setState(() {
              _calculateOutput();
            });
          },
        ),
        GCWCoordsOutput(
          text: _currentOutput,
          points: _currentMapPoints,
          geodetics: _currentMapGeodetics,
        ),
      ],
    );
  }

  _getCircleColorVariant() {
    var _hsl = HSLColor.fromColor(ThemeColors.mapCircle);
    _hsl.withLightness(_hsl.lightness - 0.1);
    return _hsl.toColor();
  }

  _calculateOutput() {
    _currentIntersections = equilateralTriangle(_currentCoords1, _currentCoords2, defaultEllipsoid());

    _currentMapPoints = [
      MapPoint(
          point: _currentCoords1,
          markerText: i18n(context, 'coords_intersectcircles_marker_centerpoint1')
      ),
      MapPoint(
          point: _currentCoords2,
          markerText: i18n(context, 'coords_intersectcircles_marker_centerpoint2')
      )
    ];

    if (_currentIntersections.isEmpty) {
      _currentOutput = i18n(context, "coords_intersect_nointersection");
      return;
    }

    _currentMapPoints.addAll(
      _currentIntersections
        .map((intersection) => MapPoint(
          point: intersection,
          color: ThemeColors.mapCalculatedPoint
        ))
        .toList()
    );

    _currentMapGeodetics = [
      MapGeodetic(
        start: _currentCoords1,
        end: _currentCoords2
      ),
    ];
    
    _currentIntersections.forEach((intersection) {
      _currentMapGeodetics.addAll([
        MapGeodetic(
            start: _currentCoords1,
            end: intersection,
            color: HSLColor
                .fromColor(ThemeColors.mapPolyline)
                .withLightness(HSLColor.fromColor(ThemeColors.mapPolyline).lightness + 0.2)
                .toColor()
        ),
        MapGeodetic(
            start: _currentCoords2,
            end: intersection,
            color: HSLColor
                .fromColor(ThemeColors.mapPolyline)
                .withLightness(HSLColor.fromColor(ThemeColors.mapPolyline).lightness -0.3)
                .toColor()
        ),
      ]);
    });


    _currentOutput = _currentIntersections
        .map((intersection) => formatCoordOutput(intersection, _currentOutputFormat, defaultEllipsoid()))
        .toList()
        .join('\n\n');
  }
}