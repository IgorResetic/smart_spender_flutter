import 'package:flutter/material.dart';
import 'package:smart_spender/config/palette.dart';

ButtonStyle fillButtonStyle = setButtonStyle(Palette.bdazzledBlue);

ButtonStyle emptyButtonStyle = setButtonStyle(Colors.white);

ButtonStyle setButtonStyle(Color color) {
  return ButtonStyle(
    shadowColor: MaterialStateProperty.all(Colors.white),
    minimumSize: MaterialStateProperty.all(Size(double.infinity, 50)),
    backgroundColor: MaterialStateProperty.all(color),
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
      RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0),
          side: BorderSide(color: Palette.bdazzledBlue, width: 1.0)
      ),
    ),
  );
}
