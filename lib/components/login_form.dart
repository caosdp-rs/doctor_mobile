import 'dart:convert';

import 'package:doctor_flutter_laravel/components/button.dart';
import 'package:doctor_flutter_laravel/main.dart';
import 'package:doctor_flutter_laravel/models/auth_model.dart';
import 'package:doctor_flutter_laravel/providers/dio_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:doctor_flutter_laravel/utils/config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController(text: "caosdp@gmail.com");
  final _passController = TextEditingController(text: "password");
  //final GoogleSignIn _googleSignIn = GoogleSignIn();

  bool obsecurePass = true;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child:
          Column(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
        TextFormField(
          controller: _emailController,
          keyboardType: TextInputType.emailAddress,
          cursorColor: Config.primaryColor,
          decoration: const InputDecoration(
              hintText: 'Email Address',
              labelText: 'Email',
              alignLabelWithHint: true,
              prefixIcon: Icon(Icons.email_outlined),
              prefixIconColor: Config.primaryColor),
        ),
        Config.spaceSmall,
        TextFormField(
          controller: _passController,
          keyboardType: TextInputType.visiblePassword,
          cursorColor: Config.primaryColor,
          obscureText: obsecurePass,
          decoration: InputDecoration(
            hintText: 'Password',
            labelText: 'Password',
            alignLabelWithHint: true,
            prefixIcon: Icon(Icons.lock_outlined),
            prefixIconColor: Config.primaryColor,
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  obsecurePass = !obsecurePass;
                });
              },
              icon: !obsecurePass
                  ? const Icon(
                      Icons.visibility_off_outlined,
                      color: Colors.black38,
                    )
                  : const Icon(
                      Icons.visibility_outlined,
                      color: Colors.black38,
                    ),
            ),
          ),
        ),
        Config.spaceSmall,
        Consumer<AuthModel>(
          builder: (context, auth, child) {
            return Button(
                width: double.infinity,
                title: 'Entrar',
                onPressed: () async {
                  //login here
                  //print('ckk');
                  final token = await DioProvider()
                      .getToken(_emailController.text, _passController.text);

                  if (token) {
                    auth.loginSuccess();
                    //print('pagina home');
                    MyApp.navigatorKey.currentState!.pushNamed('main');
                  }
                },
                disable: false);
          },
        ),
      ]),
    );
    //suffixIcon: IconButton(onPressed: (){}), icon: obsecurePass ? const Icon(Icons.visibility_off_outlined,color: Colors.black38,):const Icon(Icons.visibility_off_outlined,color: Colors.black38,))),
  }
}
