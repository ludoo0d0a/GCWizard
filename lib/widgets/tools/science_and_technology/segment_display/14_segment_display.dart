import 'package:flutter/material.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/segment_display/painters.dart';
import 'package:touchable/touchable.dart';

const _INITIAL_SEGMENTS = <String, bool>{
  'a': false, 'b': false, 'c': false, 'd': false,
  'e': false, 'f': false, 'g1': false, 'g2': false, 'h': false, 'i': false,
  'j': false, 'k': false, 'l': false, 'm': false, 'dp': false
};

class FourteenSegmentDisplay extends StatefulWidget {

  Map<String, bool> segments;
  final bool readOnly;
  final bool showPoint;
  final Function onChanged;

  FourteenSegmentDisplay({Key key, this.segments, this.showPoint: true, this.readOnly: false, this.onChanged}) : super(key: key);

  @override
  FourteenSegmentDisplayState createState() => FourteenSegmentDisplayState();
}

class FourteenSegmentDisplayState extends State<FourteenSegmentDisplay> {
  Map<String, bool> _segments;

  @override
  void initState() {
    super.initState();

    if (widget.segments != null) {
      _segments = Map.from(widget.segments);
      _INITIAL_SEGMENTS.keys.forEach((segmentID) {
        if (_segments.containsKey(segmentID))
          return;

        _segments.putIfAbsent(segmentID, () => _INITIAL_SEGMENTS[segmentID]);
      });
    } else {
      _segments = Map.from(_INITIAL_SEGMENTS);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row (
      children: <Widget>[
        Expanded(
          child: AspectRatio(
            aspectRatio: RELATIVE_DISPLAY_WIDTH / RELATIVE_DISPLAY_HEIGHT,
            child: CanvasTouchDetector(
              builder: (context) {
                return CustomPaint(
                  painter: FourteenSegmentPainter(context, _segments, (key, value) {
                    if (widget.readOnly)
                      return;

                    setState(() {
                      _segments[key] = value;
                      widget.onChanged(_segments);
                    });
                  })
                );
              },
            )
          )
        )
      ],
    );
  }
}


