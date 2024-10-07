import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:my_pfe/core/serices.dart';
import 'package:my_pfe/data/datasource/remote/vendeurData/enregistrerCommandeData.dart';
import 'package:my_pfe/data/model/categoriesModel.dart';
import '../../core/class/statusrequest.dart';
import '../../core/function/handilingdata.dart';
import '../../data/model/clientModel.dart';
import '../../view/screen/Vendeur/imprimerCommande.dart';

class EnregistrerCommandeController extends GetxController {
  EnregistrerCommandeData enregistrerCommandeData =
      EnregistrerCommandeData(Get.find());
  MyServices myServices = Get.find();
  String? idv;
  late StatusRequest statusRequest;
  List<ClientsModel> client = [];
  List<CategoriesModel> produit = [];
  String? selectedValue;
  int quantite = 0;
  dynamic factureId;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  initialData() {
    idv = myServices.sharedPreferences.getString("id");
  }

  valider(
    BuildContext context,
  ) {
    if (formKey.currentState!.validate()) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Confirmation du prix'),
            content: Text(
              "Veuillez confirmer le prix  ${calculateTotalPriceWithDiscount()} DH avec le client.",
            ),
            actions: [
              TextButton(
                  child: const Text(
                    'Confirmer',
                    style: TextStyle(color: Colors.green),
                  ),
                  onPressed: () async {
                    int? clientId = client
                        .firstWhere((c) => c.nomc == selectedValue)
                        .clientID;

                    // List<int> produitIds = produit
                    //     .map((p) => p.ProduitID)
                    //     .whereType<int>()
                    //     .toList();

                    // List<int> quantites = produit
                    //     .map((p) => p.quantite)
                    //     .whereType<int>()
                    //     .toList();
                    List<int> produitIds = produit
                        .where((p) => p.quantite! > 0)
                        .map((p) => p.ProduitID!)
                        .toList();

                    List<int> quantites = produit
                        .where((p) => p.quantite! > 0)
                        .map((p) => p.quantite!)
                        .toList();

                    // Envoyer les données vers le serveur
                    var response = await enregistrerCommandeData.inserData(
                      clientId: clientId!,
                      idv: idv!,
                      produitId: produitIds,
                      quantite: quantites,
                      prix: calculateTotalPrice(),
                      prixReduction: calculateTotalPriceWithDiscount(),
                    );

                    if (response['status'] == 'success') {
                      DateTime now = DateTime.now();
                      String dateCommande =
                          '${now.day}-${now.month}-${now.year}';
                      String heureCommande =
                          '${now.hour}:${now.minute}:${now.second}';

                      List<String> produitsSelectionnes = produit
                          .where((p) => p.quantite! > 0)
                          .map((p) => p.Nomp!)
                          .toList();

                      List<int> produitsTypeSelectionnes = produit
                          .where((p) => p.quantite! > 0)
                          .map((p) => p.Typep!)
                          .toList();

                      List<int> quantitesSelectionnees = produit
                          .where((p) => p.quantite! > 0)
                          .map((p) => p.quantite!)
                          .toList();
                      List<dynamic> produitsproduit = produit
                          .where((p) => p.quantite! > 0)
                          .map((p) => p
                              .prixp!) // A value of type 'List<dynamic>' can't be
                          //assigned to a variable of type 'List<double>'.
                          .toList();

                      ImpressionScreen impressionScreen = ImpressionScreen(
                        dateCommande: dateCommande,
                        heureCommande: heureCommande,
                        nomClient: selectedValue,
                        produits: produitsSelectionnes,
                        produitsType: produitsTypeSelectionnes,
                        quantites: quantitesSelectionnees,
                        produitsPrix: produitsproduit,
                        prixTotal: calculateTotalPrice(),
                        prixTotalReduction: calculateTotalPriceWithDiscount(),
                      );

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => impressionScreen),
                      );
                    } else {
                      // Échec de l'insertion des données
                      // Faites ici les actions nécessaires en cas d'échec
                    }
                  }),
              TextButton(
                child: const Text(
                  'Annuler',
                  style: TextStyle(color: Colors.redAccent),
                ),
                onPressed: () {
                  Get.back();
                },
              ),
            ],
          );
        },
      );
    }
  }

  Future<void> getClients() async {
    statusRequest = StatusRequest.loading;
    var response = await enregistrerCommandeData.getClient(idv!);
    print("***************Clients**** $response");
    statusRequest = handlingData(response);

    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        List datalist = response['data'];
        client.addAll(datalist.map((e) => ClientsModel.fromJson(e)));
      }
    }
    update();
  }

  getProduit() async {
    statusRequest = StatusRequest.loading;
    var response = await enregistrerCommandeData.getProduit();
    print("***************Produit**** $response");
    statusRequest = handlingData(response);

    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        List datalist = response['data'];
        produit.addAll(datalist.map((e) => CategoriesModel.fromJson(e)));
      }
    }
    update();
  }

  setSelectedvalue(value) {
    selectedValue = value.toString();
    update();
  }

  bool isAscending = false;

  // void incrementQuantity(int index) {
  //   produit[index].quantite!++;//Illegal assignment to non-assignable expression. j'ai cette erreur ici que je doit faire
  //   update();
  // }
  void incrementQuantity(int index) {
    int tempQuantite = produit[index].quantite ?? 0;
    tempQuantite++;
    produit[index].quantite = tempQuantite;
    update();
  }

  void decrementQuantity(int index) {
    if (produit[index].quantite! > 0) {
      int tempQuantite = produit[index].quantite ?? 0;
      tempQuantite--;
      produit[index].quantite = tempQuantite;
    }
    update();
  }

  void sortProductsByQuantity() {
    // Inverser l'ordre de tri
    isAscending = !isAscending;
    // Trier les produits en fonction de la quantité
    produit.sort((a, b) => isAscending
        ? a.quantite!.compareTo(b.quantite!)
        : b.quantite!.compareTo(a.quantite!));
    update();
  }

  // void sortProductsByQuantity() {
  //   // Trier les produits en fonction de la quantité (ordre décroissant)
  //   produit.sort((a, b) => b.quantite!.compareTo(a.quantite!));
  //   update();
  // }

  // Calculer le prix total sans réduction
  double calculateTotalPrice() {
    double totalPrice = 0.0;

    for (CategoriesModel product in produit) {
      double productPrice = product.prixp! *
          product.quantite!.toDouble() *
          product.Typep!.toDouble();
      totalPrice += productPrice;
    }

    String formattedTotalPrice = totalPrice.toStringAsFixed(2);
    totalPrice = double.parse(formattedTotalPrice);

    return totalPrice;
  }

  double calculateTotalPriceWithDiscount() {
    double totalPrice = 0.0;

    for (CategoriesModel product in produit) {
      double productPrice =
          product.prixp!.toDouble() * product.quantite! * product.Typep!;
      // Vérifier si le produit est éligible à la réduction
      if (product.Nomp != "Farine Normale" &&
          product.Nomp != "Son Diététique") {
        // Vérifier si la réduction doit être appliquée
        if (product.Typep! * product.quantite! > 800) {
          if (product.Typep! * product.quantite! > 1500) {
            // Réduction de 0.1/kg
            double reduction = product.prixp!.toDouble() *
                product.quantite! *
                product.Typep! *
                0.1;
            productPrice -= reduction;
          } else {
            // Réduction de 0.05/kg
            double reduction = product.prixp!.toDouble() *
                product.quantite! *
                product.Typep! *
                0.05;
            productPrice -= reduction;
          }
        }
      }

      totalPrice += productPrice;
    }
    String formattedTotalPrice = totalPrice.toStringAsFixed(2);
    totalPrice = double.parse(formattedTotalPrice);

    return totalPrice;
  }

  @override
  void onInit() async {
    statusRequest = StatusRequest.loading;
    initialData();
    await getClients();
    getProduit();
    calculateTotalPrice();

    super.onInit();
  }
}
