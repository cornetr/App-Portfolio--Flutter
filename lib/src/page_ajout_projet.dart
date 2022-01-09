import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:portfolio/src/page_accueil.dart';
import 'bdd_projets.dart';
import 'projet.dart';
import 'dart:io';

class PageAjoutProjet extends StatelessWidget {

  String path="";
  String name="";
  String categorie="";
  String date="";
  String color="";
  String description="";
  String liens="";

  var _image;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ajouter un projet"),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10,20,10,20),
            child: Wrap(
              alignment: WrapAlignment.center,
              runSpacing: 20,

              children : [
                TextFormField(
                  onChanged: (value) {
                    name=value;
                  },
                  decoration: const InputDecoration(
                    labelText: "Titre",
                    hintText: "Application 1",
                    border: OutlineInputBorder(),
                  ),
                ),
                TextFormField(
                  onChanged: (value) {
                    categorie=value;
                  },
                  decoration: const InputDecoration(
                    labelText: "Catégorie",
                    hintText: "Développement Mobile",
                    border: OutlineInputBorder(),
                  ),
                ),
                TextFormField(
                  onChanged: (value) {
                    date=value;
                  },
                  decoration: const InputDecoration(
                    labelText: "Date",
                    hintText: "22/11/2021",
                    border: OutlineInputBorder(),
                  ),
                ),
                TextFormField(
                  onChanged: (value) {
                    description=value;
                  },
                  decoration: const InputDecoration(
                    labelText: "Description",
                    hintText: "Portfolio Flutter",
                    border: OutlineInputBorder(),
                  ),
                ),
                TextFormField(
                  onChanged: (value) {
                    color=value;
                  },
                  decoration: const InputDecoration(
                    labelText: "Couleur",
                    hintText: "bleu",
                    border: OutlineInputBorder(),
                  ),
                ),
                TextFormField(
                  onChanged: (value) {
                    liens=value;
                  },
                  decoration: const InputDecoration(
                    labelText: "liens",
                    hintText: "ytb.com,google.com",
                    border: OutlineInputBorder(),
                  ),
                ),
                TextButton.icon(
                  onPressed: () {
                    BDD.instance.insertProject(Projet(path, name, categorie, date, color, description, liens));
                    Navigator.pop(context);
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PageAccueil()
                        )
                    );
                    //(context.findAncestorWidgetOfExactType<PageAccueil>() as Element).reassemble();
                  },
                  icon: const Icon(Icons.add_circle),
                  label: const Text("Ajouter"),
                ),
                TextButton.icon(
                  onPressed: () async {
                    final ImagePicker _picker = ImagePicker();
                    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
                    _image = image;
                    path=_image.path;
                    (context as Element).reassemble();
                  },
                  icon: const Icon(Icons.add_circle),
                  label: const Text("Importer image"),
                ),
                Container(
                  width: 200,
                  height: 200,
                  child: _image != null ? Image.file(
                    File( _image.path ),
                    width: 200.0,
                    height: 200.0,
                    fit: BoxFit.cover,
                  ) : Container(
                    width: 200,
                    height: 200,
                    child: Icon(
                      Icons.camera_alt,
                      color: Colors.grey[800],
                      ),
                  ),
                ),
                TextButton.icon(
                  onPressed: ()  {
                    print("chemin : "+path);
                  },
                  icon: const Icon(Icons.add_circle),
                  label: const Text("path ?"),
                ),
              ],
            ),
          )
        ),
      )
    );
  }
}

class ChampAjout extends StatelessWidget {
  final String titre;
  final String hint;
  const ChampAjout(this.titre, this.hint);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: TextFormField(
        decoration: InputDecoration(
          hintText: hint,
          labelText: titre,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}
