import 'package:flutter/material.dart';
import 'package:smart_spender/config/constant.dart';
import 'package:smart_spender/config/palette.dart';
import 'package:smart_spender/services/auth.dart';
import 'package:smart_spender/shared/loading.dart';

class Register extends StatefulWidget {

  final Function? toggleView;
  Register({ this.toggleView });

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

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
      appBar: AppBar(
        backgroundColor: Palette.bdazzledBlue,
        elevation: 0.0,
        title: Text('Register'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            widget.toggleView!();
          },
        ),
      ),
      body: Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
          child: Form(
            key: _formKey,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField (
                    decoration: textInputDecoration.copyWith(labelText: 'Email'),
                    validator: (val) => val!.isEmpty ? 'Enter an email' : null,
                    onChanged: (val) {
                      setState(() => email = val);
                    },
                  ),
                  SizedBox(height: 20.0,),
                  TextFormField(
                    decoration: textInputDecoration.copyWith(labelText: 'Password'),
                    obscureText: true,
                    validator: (val) => val!.length < 6 ? 'Enter a password 6+ char long' :  null,
                    onChanged: (val) {
                      setState(() => password = val);
                    },
                  ),
                  SizedBox(height: 40.0,),
                  ElevatedButton(
                    onPressed: () async {
                      if(_formKey.currentState!.validate()) {
                        setState(() => loading = true);
                        dynamic result = await _authService.registerWithEmailAndPassword(email, password);

                        if(result == null) {
                          setState(() => error = 'please supply a valid email');
                          loading = false;
                        }
                      }
                    },
                    child: Text("Register", style: TextStyle(
                        color: Colors.white
                    ),),
                    style: ButtonStyle(
                      shadowColor: MaterialStateProperty.all(Colors.white),
                      minimumSize: MaterialStateProperty.all(Size(double.infinity, 50)),
                      backgroundColor: MaterialStateProperty.all(Palette.bdazzledBlue),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            side: BorderSide(color: Palette.bdazzledBlue, width: 1.0)
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 15.0,),
                  ElevatedButton(
                    onPressed: () async {
                      dynamic result = await _authService.signInWithGoogle();
                      if (result == null) {
                        print('error signing up');
                      } else {
                        print('sign up');
                        print(result.uid);
                      }
                    },
                    child: Text("Sign up with Google", style: TextStyle(
                        color: Palette.bdazzledBlue
                    ),),
                    style: ButtonStyle(
                      shadowColor: MaterialStateProperty.all(Colors.white),
                      minimumSize: MaterialStateProperty.all(Size(double.infinity, 50)),
                      backgroundColor: MaterialStateProperty.all(Colors.white),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            side: BorderSide(color: Palette.bdazzledBlue, width: 1.0)
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 25.0,),
                  Text(
                    error,
                    style: TextStyle(color: Palette.redPigment, fontSize: 14.0),
                  ),
                ],
              ),
            ),
          )
      ),
    );
  }
}
