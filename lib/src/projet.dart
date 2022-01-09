class Projet{
  String path;
  String name;
  String categorie;
  String date;
  String color;
  String description;
  String liens;

  Projet(this.path, this.name, this.categorie, this.date, this.color, this.description, this.liens);

  Map<String,dynamic> toMap(){
    return{
    "path":path,
    "name":name,
    "categorie":categorie,
    "date":date,
    "color":color,
    "description":description,
    "liens":liens
    };
  }


  factory Projet.fromMap(Map<String, dynamic> map) => Projet(
    map["path"],
    map["name"],
    map["categorie"],
    map["date"],
    map["color"],
    map["description"],
    map["liens"]
  );

  static String listToOneString(List l){
    String listToString=l[0].toString();

    for(int i = 1; i < l.length; i++) {
      listToString += "," + l[i].ToString();
    }

    return listToString;
  }
}