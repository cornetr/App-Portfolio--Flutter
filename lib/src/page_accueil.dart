import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'bdd_projets.dart';
import 'projet.dart';
import 'page_ajout_projet.dart';
import 'box_projet.dart';
import 'drawer_options.dart';

class PageAccueil extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: DrawerOptions(),
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          systemNavigationBarColor: Colors.black, // Navigation bar
          statusBarColor: Colors.black, // Status bar
        ),
        title: const Text("Galerie Projets"),
        centerTitle: true,
        backgroundColor: Colors.black,
        actions: [
          Builder(builder: (context) {
            return IconButton(
              onPressed: () { Scaffold.of(context).openEndDrawer();},
              icon: const Icon(
              Icons.settings,
            ),
            );
          }),
        ],
      ),
      body: SingleChildScrollView(
        child: ListeProjets(),
      ),
      floatingActionButton: FloatingActionButton(
        foregroundColor: Colors.white,
        backgroundColor: Colors.black,
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => PageAjoutProjet()
                )
            );
          },
          child: const Icon (
             Icons.add,
          )
      ),
    );
  }

}

class ListeProjets extends StatelessWidget {
static int i=0;
  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10, right: 15, left: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: const [
                    Icon(
                      Icons.arrow_right,
                    ),
                    Text(
                      "Tous",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
                    ),
                  ],
                ),
                FutureBuilder(
                  future: BDD.instance.countProjects,
                  builder: (context, snapshot) {
                    if(snapshot.hasData){
                      i=snapshot.data as int;
                    }else {
                      i=-1;
                    }

                    return Text(
                      snapshot.data.toString()+" projet(s)",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
                    );
                  },
                ),

              ],
            ),
          ),
         // const BoxProjet("minion.jpg", Colors.amber, "Minion de test", "22/11/2021","dash"),
          //appli
        //  BoxProjet(Projet("BroderieGolf.jpg", "Broderie Golf", "14/11/2021", "bleu","d")),
        //  BoxProjet(Projet("PaperCover.jpg", "PaperCover TheHxliday","01/11/2021", "rose","a")),
        //  BoxProjet(Projet("NapsBot.jpg", "NapsBot Twitter","10/05/2021", "gris", "s")),
          FutureBuilder(
            future: BDD.instance.getAllProjects(),
            builder: (BuildContext context, AsyncSnapshot<List<Projet>> snapshot){
              if(snapshot.hasData) {
                List<Projet>? lp = snapshot.data;
                return ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,

                    itemCount: lp!.length,
                    itemBuilder: (context, index) {
                      final projet = lp[index];
                      return BoxProjet(projet);
                    }
                );
              }
              return Text("pas ok");
            }
          ),
          ElevatedButton(
              onPressed: () {
                BDD.instance.insertProject(Projet("BroderieGolf.jpg", "Brode "+i.toString(), "Broderie", "14/11/2021", "bleu","broderie main","https://www.cdiscount.com/"));
                i++;
                (context as Element).reassemble();
              },
              child: const Text("insert Broderie")),
          ElevatedButton(
              onPressed: () {
                if(i>0)i--;
                BDD.instance.deleteProject("Brode "+i.toString());
                (context as Element).reassemble();
              },
              child: const Text("delete Broderie")),
          ElevatedButton(
              onPressed: () {
                i=0;
                BDD.instance.deleteAllProjects();
                (context as Element).reassemble();
              },
              child: const Text("delete all")),
          Text("i = "+i.toString()),
          const SizedBox(height: 60,)
        ]
    );
  }
}