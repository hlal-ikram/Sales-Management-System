import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_pfe/controller/admin_controller/produits/produitV_controller.dart';
import 'package:my_pfe/core/class/statusrequest.dart';
import 'package:my_pfe/core/constant/routes.dart';
//import 'package:my_pfe/core/constant/routes.dart';
import 'package:my_pfe/core/function/uploadfile.dart';
import 'package:my_pfe/data/model/categoriesModel.dart';
import '../../../core/function/handilingdata.dart';
import '../../../data/datasource/remote/adminData/produitData.dart';

class ProduitEditController extends GetxController {
  ProduitData produitData = ProduitData(Get.find());
  late TextEditingController nomp;
  late TextEditingController prixp;
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  //late TextEditingController typep;
  CategoriesModel? categoriesModel;
  File? file;
  StatusRequest? statusRequest = StatusRequest.none;
  int selectedType = 5;
  chooseImage() async {
    file = await fileUploadGallery();
    update();
  }

  editData() async {
    if (formstate.currentState!.validate()) {
      statusRequest = StatusRequest.loading;
      update();
      Map data = {
        "ProduitID": categoriesModel!.ProduitID.toString(),
        "Nomp": nomp.text,
        "Prixp": prixp.text,
        "Typep": selectedType.toString(),
        "imageold": categoriesModel!.Imagep!,
      };
      var response = await produitData.edit(data, file);
      print("***********ProduitEdit $response");
      statusRequest = handlingData(response);
      if (StatusRequest.success == statusRequest) {
        if (response['status'] == "success") {
          Get.defaultDialog(
            title: "succès",
            content: const Text("Le produit a été modifié avec succès."),
            confirm: ElevatedButton(
              onPressed: () {
                Get.back();
              },
              child: const Text("OK"),
            ),
          );
          // Get.offNamed(AppRoute.produitAView);
          ProduitController pc = Get.find();
          pc.getData();
        } else {
          statusRequest = StatusRequest.failure;
        }
      }
      update();
    }
  }

  @override
  void onInit() {
    categoriesModel = Get.arguments['categoriesModel'];
    nomp = TextEditingController();
    prixp = TextEditingController();
    //typep = TextEditingController();

    nomp.text = categoriesModel!.Nomp!;
    prixp.text = categoriesModel!.prixp.toString();
    //typep.text = categoriesModel!.Typep.toString();
    selectedType = categoriesModel!.Typep!;

    super.onInit();
  }

  setSelectedType(int value) {
    selectedType = value;
    update();
  }

  myback() {
    Get.offAllNamed(AppRoute.homaAdmin);
    return Future.value(false);
  }
}
