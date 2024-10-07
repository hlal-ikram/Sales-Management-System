import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_pfe/controller/admin_controller/produits/produitV_controller.dart';
import 'package:my_pfe/core/class/statusrequest.dart';
import 'package:my_pfe/core/constant/routes.dart';
import 'package:my_pfe/core/function/uploadfile.dart';
import '../../../core/function/handilingdata.dart';
import '../../../data/datasource/remote/adminData/produitData.dart';

class ProduitAddController extends GetxController {
  ProduitData produitData = ProduitData(Get.find());
  late TextEditingController nomp;
  late TextEditingController prixp;
  late int selectedType = 5; // Valeur par défaut pour le bouton radio
  File? file;
  StatusRequest? statusRequest = StatusRequest.none;
  GlobalKey<FormState> formstate = GlobalKey<FormState>();

  chooseImage() async {
    file = await fileUploadGallery();
    update();
  }

  addData() async {
    if (formstate.currentState!.validate()) {
      if (file == null) {
        Get.defaultDialog(
            title: "Avertissement",
            content: const Text("Veuillez choisir une image ."));
        return;
      }

      // if (nomp.text.isEmpty || prixp.text.isEmpty) {
      //   Get.defaultDialog(
      //       title: "Avertissement",
      //       content: const Text("Veuillez remplir tous les champs."));
      //   return;
      // }

      statusRequest = StatusRequest.loading;
      update();

      Map data = {
        "Nomp": nomp.text,
        "Prixp": prixp.text,
        "Typep": selectedType.toString(),
      };

      var response = await produitData.add(data, file!);
      try {
        statusRequest = handlingData(response);
        print("********************** $response");

        if (StatusRequest.success == statusRequest) {
          if (response['status'] == "success") {
            nomp.clear();
            prixp.clear();
            selectedType = 5;
            Get.defaultDialog(
              title: "succès",
              content: Text("Le produit a été ajouté avec succès."),
              confirm: ElevatedButton(
                onPressed: () {
                  Get.back(); // Fermer la boîte de dialogue
                },
                child: Text("OK"),
              ),
            );

            if (file != null) {
              try {
                await file!.delete();
                print('Fichier supprimé avec succès');
              } catch (e) {
                print('Erreur lors de la suppression du fichier : $e');
              }
            }

            update();
            ProduitController pc = Get.find();
            pc.getData();
          } else {
            statusRequest = StatusRequest.failure;
          }
        }
      } catch (e) {
        statusRequest = StatusRequest.failure;
        print("Erreur lors de la mise à jour du contrôleur : $e");
      }

      update();
    }
  }

  void setSelectedType(int value) {
    selectedType = value;
    update();
  }

  @override
  void onInit() {
    nomp = TextEditingController();
    prixp = TextEditingController();
    super.onInit();
  }

  myback() {
    Get.offAllNamed(AppRoute.homaAdmin);
    return Future.value(false);
  }
}
