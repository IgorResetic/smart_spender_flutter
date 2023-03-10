import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:smart_spender/config/palette.dart';

class Loading extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Palette.bdazzledBlue,
      child: Center(
        child: SpinKitChasingDots(
          color: Palette.bdazzledBlue,
          size: 50.0,
        ),
      ),
    );
  }
}
