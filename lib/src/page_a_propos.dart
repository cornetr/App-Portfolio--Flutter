import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PageAPropos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column (
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Version : 1.0.0 \n"
              "Auteur : Romann CORNET \n"
              "Date de création : 22 Novembre 2021 \n",
              textAlign: TextAlign.center,
            ),
          RichText(
            text: TextSpan(
                text: "www.github.com",
                style: const TextStyle(
                  color: Colors.blue,
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () async {
                    const url = "https://github.com/cornetr/App-Portfolio--Flutter";
                    if (await canLaunch(url)) {
                      await launch(
                        url,
                        forceSafariVC: false,
                      );
                    }
                  },
              )
            )
          ],
        )
      ),
    );
  }
}
