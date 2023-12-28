import 'package:flutter/cupertino.dart';

class HubSegmentedControl extends StatelessWidget {
  final List<String> options;
  final ValueChanged<String?> onValueChanged;
  final String groupValue;

  const HubSegmentedControl({
    super.key,
    required this.options,
    required this.onValueChanged,
    required this.groupValue,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoSlidingSegmentedControl(
      groupValue: groupValue,
      children: {
        for (final String val in options)
          val: _HubSegmentedControlChild(
            text: val,
          ),
      },
      onValueChanged: onValueChanged,
    );
  }
}

class _HubSegmentedControlChild extends StatelessWidget {
  final String text;

  const _HubSegmentedControlChild({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Text(text),
    );
  }
}
