import 'package:flutter/material.dart';
import 'package:smart_spender/config/palette.dart';

const textInputDecoration = InputDecoration(
  hintText: '',
  labelStyle: TextStyle(color: Palette.bdazzledBlue),
  fillColor: Palette.babyPowder,
  filled: true,
  enabledBorder: UnderlineInputBorder(
    borderSide: BorderSide(color: Palette.bdazzledBlue, width: 1.0),
  ),
  focusedBorder: UnderlineInputBorder(
    borderSide: BorderSide(color: Palette.bdazzledBlue, width: 1.0),
  ),
);