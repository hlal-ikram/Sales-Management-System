class VendeurModel {
  String? nom_complet;
  String? id;
  int? vendeurID;

  VendeurModel({this.nom_complet, this.id, this.vendeurID});

  VendeurModel.fromJson(Map<String, dynamic> json) {
    nom_complet = json['nom_complet'];
    id = json['id'];
    vendeurID = json['VendeurID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nom_complet'] = this.nom_complet;
    data['id'] = this.id;
    data['VendeurID'] = this.vendeurID;
    return data;
  }
}
