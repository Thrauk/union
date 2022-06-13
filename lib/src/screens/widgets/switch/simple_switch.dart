import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:union_app/src/theme.dart';

class SimpleSwitch extends StatelessWidget {
  const SimpleSwitch({Key? key, required bool value, required Function(bool) onChange})
      : _onChanged = onChange,
        _value = value,
        super(key: key);

  final bool _value;
  final Function(bool) _onChanged;

  @override
  Widget build(BuildContext context) {
    return Switch(
      inactiveTrackColor: AppColors.white02,
      activeColor: AppColors.primaryColor,
      value: _value,
      onChanged: (bool value) => _onChanged(value),
    );
  }
}
