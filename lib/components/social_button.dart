import 'package:doctor_flutter_laravel/utils/config.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SocialButton extends StatelessWidget {
  SocialButton({Key? key, required this.social}) : super(key: key);

  final String social;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  @override
  Widget build(BuildContext context) {
    Config().init(context);
    return OutlinedButton(
        style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 0),
            side: const BorderSide(width: 1, color: Colors.black)),
        onPressed: () {
          // _googleSignIn.signIn().then((value) {
          //   String userName = value!.displayName!,
          //   String profilePicture = value!.photoUrl!,
          // });
        },
        child: SizedBox(
          width: Config.widthSize * 0.4,
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Image.asset(
                  'assets/$social.png',
                  width: 40,
                  height: 40,
                ),
                Text(
                  social.toUpperCase(),
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                )
              ]),
        ));
  }
}
