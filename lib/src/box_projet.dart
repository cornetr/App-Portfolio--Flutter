
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:portfolio/src/projet.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io';

class BoxProjet extends StatelessWidget {
  final Projet projet;
  const BoxProjet(this.projet);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          print("chemin : "+projet.path);
          Navigator.push(
              context,
              HeroDialogRoute(
                builder: (BuildContext context) {
                  return Center(
                    child: BoxProjetDetailee(projet),
                  );
                },
            )
          );
        },
        child: Container(
          margin: const EdgeInsets.all(15),
          height: 230,
          width: double.infinity,
          alignment: Alignment.bottomCenter,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
          ),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30)
                ),
                child: Image.file(
                  File( projet.path ),
                  height: 160,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  )
              ),
              Container(
                height: 70,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30)
                  ),
                  color: Colors.red.withOpacity(0.75),
                ),
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text( // --> Title
                          projet.name,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        Text( // --> Date
                          projet.date,
                          style: const TextStyle(
                            color: Colors.white,
                            fontStyle: FontStyle.italic,
                            fontSize: 18,
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ],
          )
        )
    );
  }

}

class BoxProjetDetailee extends StatelessWidget{

  final Projet projet;
  const BoxProjetDetailee(this.projet);

  @override
  Widget build(BuildContext context) {
    return Material(
      //avec material !!!!
      type: MaterialType.transparency,
      //type: MaterialType.canvas,
      //color: Colors.black54.withOpacity(0.80),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
            child: Container(
              constraints: const BoxConstraints(
                maxHeight: double.infinity,
              ),
            margin: const EdgeInsets.only(top: 45, left: 15, right: 15, bottom: 15),
            alignment: Alignment.bottomCenter,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(30)),
              color: Colors.red.withOpacity(0.80),
            ),
            padding: const EdgeInsets.all(10),
              child: Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          height: 230,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Image.file(
                            File( projet.path ),
                            height: 230.0,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              alignment: Alignment.topLeft,
                              onPressed: () {} ,
                              color: Colors.black,
                              splashRadius: double.minPositive,
                              iconSize: 30,
                              icon: const Icon(Icons.star_border)
                            ),
                            IconButton(
                                alignment: Alignment.topRight,
                                onPressed: () {} ,
                                color: Colors.black,
                                splashRadius: double.minPositive,
                                iconSize: 30,
                                icon: const Icon(Icons.create)
                            )
                          ]
                        ),
                      ]
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text( // --> Title
                            projet.name,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          Text( // --> Date
                            projet.date,
                            style: const TextStyle(
                              color: Colors.white,
                              fontStyle: FontStyle.italic,
                              fontSize: 18,
                            ),
                          )
                        ],
                      ),
                    ),
                    Text(
                      projet.description,
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.white
                      ),
                    ),
                    RichText(
                        text: TextSpan(
                          text: "www.github.com",
                          style: const TextStyle(
                            color: Colors.blue,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () async {
                               String url = projet.liens;
                              if (await canLaunch(url)) {
                                await launch(
                                  url,
                                  forceSafariVC: false,
                                );
                              }
                            },
                        )
                    )
                  ]
              ),
          )

        )
      ),
    );
  }
}

class HeroDialogRoute<T> extends PageRoute<T> {
  HeroDialogRoute({ required this.builder }) : super();

  final WidgetBuilder builder;

  @override
  bool get opaque => false;

  @override
  bool get barrierDismissible => true;

  @override
  Duration get transitionDuration => const Duration(milliseconds: 400);

  @override
  bool get maintainState => true;

  @override
  Color get barrierColor => Colors.black54;

  @override
  String get barrierLabel => "";

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
    return FadeTransition(
        opacity: CurvedAnimation(
            parent: animation,
            curve: Curves.linear
        ),
        child: child
    );
  }

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return builder(context);
  }

}