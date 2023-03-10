import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:smart_spender/config/constant.dart';
import 'package:smart_spender/config/palette.dart';
import 'package:smart_spender/config/string_constants.dart';
import 'package:smart_spender/config/style.dart';
import 'package:smart_spender/services/auth.dart';
import 'package:smart_spender/shared/loading.dart';

class SignIn extends StatefulWidget {

  final Function? toggleView;
  SignIn({ this.toggleView });

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _authService = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  // text field state
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: Palette.babyPowder,
      body: Center(
        child: SingleChildScrollView(
          child: Container(
              padding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 50.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFormField (
                      decoration: textInputDecoration.copyWith(labelText: emailLabel),
                      validator: (val) => val!.isEmpty ? emailHint : null,
                      onChanged: (val) {
                        setState(() => email = val);
                      },
                    ),
                    SizedBox(height: 20.0,),
                    TextFormField(
                      decoration: textInputDecoration.copyWith(labelText: passwordLabel),
                      obscureText: true,
                      validator: (val) => val!.length < 6 ? passwordHint :  null,
                      onChanged: (val) {
                        setState(() => password = val);
                      },
                    ),
                    Container(
                      alignment: Alignment(1.0, 0.0),
                      padding: EdgeInsets.only(top: 15.0, left: 20.0),
                      child: InkWell(
                        child: Text(
                          forgotPasswordText,
                          style: TextStyle(
                              color: Palette.redPigment,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Montserrat',
                              decoration: TextDecoration.underline),
                        ),
                      ),
                    ),
                    SizedBox(height: 40.0,),
                    ElevatedButton(
                      onPressed: () async {
                        if(_formKey.currentState!.validate()) {
                          setState(() => loading = true);
                          dynamic result = await _authService.signInWithEmailAndPassword(email, password);
                          if (result == null) {
                            setState(() {
                              error = signInErrorText;
                              loading = false;
                            });
                          }
                        }
                      },
                      child: Text(loginButtonText, style: TextStyle(
                          color: Colors.white
                      ),),
                      style: fillButtonStyle,
                    ),
                    SizedBox(height: 15.0,),
                    ElevatedButton(
                        onPressed: () async {
                          dynamic result = await _authService.signInWithGoogle();
                          if (result == null) {
                            print('error signing in');
                          } else {
                            print('sign in');
                            print(result.uid);
                          }
                        },
                        child: Text("Login with Google", style: TextStyle(
                            color: Palette.bdazzledBlue
                        ),),
                        style: emptyButtonStyle
                    ),
                    SizedBox(height: 25.0,),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Text(registerLabel),
                      SizedBox(width: 5.0),
                      InkWell(
                          onTap: () {
                            print("Register");
                            widget.toggleView!();
                          },
                          child: Text(registerText,
                              style: TextStyle(
                                  color: Palette.redPigment,
                                  fontFamily: 'Trueno',
                                  decoration: TextDecoration.underline)))
                    ]),
                    SizedBox(height: 20.0,),
                    Text(
                      error,
                      style: TextStyle(color: Colors.red, fontSize: 14.0),
                    ),
                  ],
                ),
              )
          ),
        ),
      ),
    );

  }
}

