import 'package:my_pfe/core/constant/linkapi.dart';

import '../../../../core/class/crud.dart';

class EnregistrerCommandeData {
  Crud crud;
  EnregistrerCommandeData(this.crud);

  getClient(String idv) async {
    // var data = {"idv": idv};
    var response = await crud.postData(AppLink.getAllC, {"idv": idv});
    return response.fold((l) => l, (r) => r);
  }

  getProduit() async {
    var response = await crud.postData(AppLink.getAllProuduit, {});
    return response.fold((l) => l, (r) => r);
  }

  inserData({
    int? clientId,
    String? idv,
    List<int>? produitId,
    List<int>? quantite,
    double? prix,
    double? prixReduction,
  }) async {
    // Construire le corps de la requête avec les données envoyées depuis Flutter
    Map<String, dynamic> requestBody = {
      "clientID": clientId.toString(),
      "idv": idv,
      "produitID": produitId.toString(),
      "quantite": quantite.toString(),
      "prixTotal": prix.toString(),
      "prixAvecReduction": prixReduction.toString(),
    };

    var response =
        await crud.postData(AppLink.enregistrerCommabde, requestBody);
    return response.fold((l) => l, (r) => r);
  }
}
