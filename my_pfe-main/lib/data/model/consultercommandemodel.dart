class ConsulterCommandeModel {
  String? client;
  String? adressec;
  String? produits;
  dynamic prixCommande;
  String? secteur;
  String? vehiculeID;
  double? prixtotal = 0;

  ConsulterCommandeModel(
      {this.client,
      this.adressec,
      this.produits,
      this.prixCommande,
      this.secteur,
      this.vehiculeID,
      this.prixtotal});

  ConsulterCommandeModel.fromJson(Map<String, dynamic> json) {
    client = json['client'];
    adressec = json['Adressec'];
    produits = json['produits'];
    prixCommande = json['prix_commande'];
    secteur = json['secteur'];
    vehiculeID = json['VehiculeID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['client'] = client;
    data['Adressec'] = adressec;
    data['produits'] = produits;
    data['prix_commande'] = prixCommande;
    data['secteur'] = secteur;
    data['VehiculeID'] = vehiculeID;

    return data;
  }
}
