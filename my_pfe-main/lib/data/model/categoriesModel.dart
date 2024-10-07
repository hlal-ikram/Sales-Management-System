//import 'dart:ffi';

class CategoriesModel {
  int? ProduitID;
  String? Nomp;
  dynamic prixp;
  int? Typep;
  String? Imagep;
  String? categoriesDatetime;
  int? quantite = 0;

  CategoriesModel(
      {this.ProduitID,
      this.Nomp,
      this.prixp,
      this.Typep,
      this.Imagep,
      this.categoriesDatetime,
      this.quantite});

  //this.categoriesDatetime});

  CategoriesModel.fromJson(Map<String, dynamic> json) {
    ProduitID = json['ProduitID'];
    Nomp = json['Nomp'];
    prixp = json['Prixp'];
    Typep = json['Typep'];
    Imagep = json['Imagep'];
    categoriesDatetime = json['categories_datetime'];
    // quantite = json['Quantite'];

    Map<String, dynamic> toJson() {
      final Map<String, dynamic> data = <String, dynamic>{};
      data['ProduitID'] = ProduitID;
      data['Nomp'] = Nomp;
      data['Prixp'] = prixp;
      data['Typep'] = Typep;
      data['Imagep'] = Imagep;
      data['categories_datetime'] = categoriesDatetime;
      // data['Quantite'] = quantite;
      return data;
    }
  }
}
