import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:union_app/src/screens/widgets/switch/simple_switch.dart';
import 'package:union_app/src/theme.dart';

class OpenForCollaborationSwitch extends StatelessWidget {
  const OpenForCollaborationSwitch({Key? key, required bool value, required Function(bool) onChange})
      : _value = value,
        _onChange = onChange,
        super(key: key);

  final bool _value;
  final Function(bool) _onChange;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        const Text(
          'Open for collaborations?',
          style: AppStyles.textStyleBody,
        ),
        const SizedBox(
          width: 4,
        ),
        SimpleSwitch(value: _value, onChange: _onChange),
      ],
    );
  }
}
