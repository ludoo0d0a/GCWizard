import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/coords/data/coordinates.dart';
import 'package:gc_wizard/logic/tools/coords/intersect_three_circles.dart';
import 'package:gc_wizard/logic/tools/coords/utils.dart';
import 'package:gc_wizard/theme/colors.dart';
import 'package:gc_wizard/utils/constants.dart';
import 'package:gc_wizard/utils/units/lengths.dart';
import 'package:gc_wizard/widgets/common/coords/gcw_coords.dart';
import 'package:gc_wizard/widgets/common/coords/gcw_coords_output.dart';
import 'package:gc_wizard/widgets/common/coords/gcw_coords_outputformat_distance.dart';
import 'package:gc_wizard/widgets/common/coords/gcw_map_geometries.dart';
import 'package:gc_wizard/widgets/common/coords/utils.dart';
import 'package:gc_wizard/widgets/common/gcw_distance.dart';
import 'package:gc_wizard/widgets/common/gcw_submit_button.dart';

class IntersectThreeCircles extends StatefulWidget {
  @override
  IntersectThreeCirclesState createState() => IntersectThreeCirclesState();
}

class IntersectThreeCirclesState extends State<IntersectThreeCircles> {
  List<Intersect> _currentIntersections = [];

  var _currentCoordsFormat1 = defaultCoordFormat();
  var _currentCoords1 = defaultCoordinate;
  var _currentRadius1 = 0.0;

  var _currentCoordsFormat2 = defaultCoordFormat();
  var _currentCoords2 = defaultCoordinate;
  var _currentRadius2 = 0.0;

  var _currentCoordsFormat3 = defaultCoordFormat();
  var _currentCoords3 = defaultCoordinate;
  var _currentRadius3 = 0.0;

  var _currentOutputFormat = defaultCoordFormat();
  var _currentOutputUnit = defaultLength;
  var _currentOutput = '';
  var _currentMapPoints;

  @override
  void initState() {
    super.initState();
    _currentMapPoints = [
      MapPoint(point: _currentCoords1),
      MapPoint(point: _currentCoords2),
      MapPoint(point: _currentCoords3),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GCWCoords(
          text: i18n(context, "coords_intersectcircles_centerpoint1"),
          coordsFormat: _currentCoordsFormat1,
          onChanged: (ret) {
            setState(() {
              _currentCoordsFormat1 = ret['coordsFormat'];
              _currentCoords1 = ret['value'];
            });
          },
        ),
        GCWDistance(
          hintText: i18n(context, "common_radius"),
          onChanged: (value) {
            setState(() {
              _currentRadius1 = value;
            });
          },
        ),
        GCWCoords(
          text: i18n(context, "coords_intersectcircles_centerpoint2"),
          coordsFormat: _currentCoordsFormat2,
          onChanged: (ret) {
            setState(() {
              _currentCoordsFormat2 = ret['coordsFormat'];
              _currentCoords2 = ret['value'];
            });
          },
        ),
        GCWDistance(
          hintText: i18n(context, "common_radius"),
          onChanged: (value) {
            setState(() {
              _currentRadius2 = value;
            });
          },
        ),
        GCWCoords(
          text: i18n(context, "coords_intersectcircles_centerpoint3"),
          coordsFormat: _currentCoordsFormat3,
          onChanged: (ret) {
            setState(() {
              _currentCoordsFormat3 = ret['coordsFormat'];
              _currentCoords3 = ret['value'];
            });
          },
        ),
        new GCWDistance(
          hintText: i18n(context, "common_radius"),
          onChanged: (value) {
            setState(() {
              _currentRadius3 = value;
            });
          },
        ),
        GCWCoordsOutputFormatDistance(
          coordFormat: _currentOutputFormat,
          onChanged: (value) {
            setState(() {
              _currentOutputFormat = value['coordFormat'];
              _currentOutputUnit = value['unit'];
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
          circles: [
            MapCircle(
              centerPoint: _currentCoords1,
              radius: _currentRadius1,
              color:
                HSLColor
                    .fromColor(ThemeColors.mapCircle)
                    .withLightness(HSLColor.fromColor(ThemeColors.mapCircle).lightness - 0.3)
                    .toColor()
            ),
            MapCircle(
              centerPoint: _currentCoords2,
              radius: _currentRadius2
            ),
            MapCircle(
              centerPoint: _currentCoords3,
              radius: _currentRadius3,
              color:
              HSLColor
                  .fromColor(ThemeColors.mapCircle)
                  .withLightness(HSLColor.fromColor(ThemeColors.mapCircle).lightness + 0.2)
                  .toColor()
            ),
          ],
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
    _currentIntersections = intersectThreeCircles(
        _currentCoords1, _currentRadius1,
        _currentCoords2, _currentRadius2,
        _currentCoords3, _currentRadius3,
        10, //accuracy
        defaultEllipsoid()
    );

    _currentMapPoints = [
      MapPoint(
          point: _currentCoords1,
          markerText: i18n(context, 'coords_intersectcircles_marker_centerpoint1')
      ),
      MapPoint(
          point: _currentCoords2,
          markerText: i18n(context, 'coords_intersectcircles_marker_centerpoint2')
      ),
      MapPoint(
          point: _currentCoords3,
          markerText: i18n(context, 'coords_intersectcircles_marker_centerpoint3')
      )
    ];

    if (_currentIntersections.isEmpty) {
      _currentOutput = i18n(context, "coords_intersect_nointersection");
      return;
    }

    _currentMapPoints.addAll(
      _currentIntersections
        .map((intersection) => MapPoint(
          point: intersection.coords,
          color: ThemeColors.mapCalculatedPoint
        ))
        .toList()
    );

    _currentOutput = _currentIntersections
        .map((intersection) {
          return '${formatCoordOutput(intersection.coords, _currentOutputFormat, defaultEllipsoid())} '
              '(${i18n(context, "coords_intersectthreecircles_marker_accuracy")}: '
                  '${doubleFormat.format(intersection.accuracy / _currentOutputUnit.inMeters)} ${_currentOutputUnit.unit})';
        })
        .toList()
        .join('\n\n');
  }
}