import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smart_spender/models/user.dart';
import 'package:smart_spender/pages/authentication/authentication.dart';
import 'package:smart_spender/pages/authentication/sign_in.dart';
import 'package:smart_spender/pages/home/home.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    final user = Provider.of<UIUser?>(context);
    print(user);

    if (user == null) {
      return Authentication();
    } else {
      return Home();
    }
  }
}
