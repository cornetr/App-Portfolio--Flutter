import 'package:flutter/material.dart';
import 'package:portfolio/src/page_a_propos.dart';
import 'package:portfolio/src/page_favoris.dart';
import 'package:portfolio/src/page_parametres.dart';

class DrawerOptions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          AppBar(
            actions: [IconButton(
              onPressed: () { Navigator.pop(context);},
              icon: const Icon(
                Icons.close,
              ),
            )
            ],
            backgroundColor: Colors.black,
            centerTitle: true,
            title: const Text("Options",style: TextStyle(color: Colors.white),),
          ),
          const ExpansionTileOption("Filtre :",Icons.tune,"Tous"),
          const ExpansionTileOption("Thème :",Icons.format_paint,"Black"),
          LigneOption("Favoris",Icons.star, PageFavoris()),
          LigneOption("Paramètres",Icons.settings, PageParametres()),
          LigneOption("À propos",Icons.info, PageAPropos()),

          //const Divider(indent: 50,endIndent: 50),
        ],
      ),
    );
  }

}

class LigneOption extends StatelessWidget{

  final String libelle;
  final IconData ico;
  final Widget page;


  const LigneOption(this.libelle,this.ico, this.page);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 0, 10, 0),
      child: InkWell(
        splashColor: Colors.grey,
        onTap: () => {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => page
            )
          ),
        },
        child: Container(
          height: 55,
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(
                      color: Colors.grey.shade300)
              )
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(ico),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      libelle,
                      style: const TextStyle(
                        fontSize: 16,

                      ),
                    ),
                  ),

                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ExpansionTileOption extends StatelessWidget{

  final String libelle;
  final IconData ico;
  final String valeur;

  const ExpansionTileOption(this.libelle,this.ico, this.valeur);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 0, 10, 0),
      child:  Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Colors.grey.shade300
              )
            )
          ),
          child: ExpansionTile(
            tilePadding: EdgeInsets.zero,
            childrenPadding: EdgeInsets.zero,
            title: Row(
              children: [
                Row(
                  children: [
                    Icon(ico),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        libelle,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.normal
                        ),
                      ),
                    ),
                    Text(
                      valeur,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.normal
                      ),
                    ),
                  ],
                )
              ],
            ),
            children: [
              ListTile(title: Text("first"),onTap: () => print("test"),),
              ListTile(title: Text("first")),
              ListTile(title: Text("first")),
            ],
          )
        ),
      
    );
  }
}