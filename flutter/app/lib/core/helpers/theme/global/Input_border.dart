import 'package:app/core/helpers/constants.dart';
import 'package:flutter/material.dart';

class InputBorderConstant {
  static OutlineInputBorder borderTheme({required Color color}) =>
      OutlineInputBorder(
        borderSide: BorderSide(color: color, width: 2.0),
        borderRadius: const BorderRadius.all(
          Radius.circular(Constants.radiusSM),
        ),
      );
}
