import 'package:flutter/material.dart';

class RangePickerWidget extends StatefulWidget {
  final double initialValueStart;
  final double initialValueEnd;
  final ValueChanged<double>? onRangeStartChanged;
  final ValueChanged<double>? onRangeEndChanged;

  const RangePickerWidget({
    Key? key,
    this.initialValueStart = 0.0,
    this.initialValueEnd = 500000.0,
    this.onRangeStartChanged,
    this.onRangeEndChanged,
  }) : super(key: key);

  @override
  _RangePickerWidgetState createState() => _RangePickerWidgetState();
}

class _RangePickerWidgetState extends State<RangePickerWidget> {
  late double _startValue;
  late double _endValue;

  @override
  void initState() {
    super.initState();
    _startValue = widget.initialValueStart;
    _endValue = widget.initialValueEnd;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Start: ${_startValue.toStringAsFixed(2)}'),
            Text('End: ${_endValue.toStringAsFixed(2)}'),
          ],
        ),
        RangeSlider(
          values: RangeValues(_startValue, _endValue),
          min: 0.0,
          max: 500000.0,
          divisions: 1000,
          labels: RangeLabels(
            _startValue.toStringAsFixed(2),
            _endValue.toStringAsFixed(2),
          ),
          onChanged: (RangeValues newValues) {
            setState(() {
              _startValue = newValues.start;
              _endValue = newValues.end;
            });
            widget.onRangeStartChanged?.call(_startValue);
            widget.onRangeEndChanged?.call(_endValue);
          },
        ),
      ],
    );
  }
}
