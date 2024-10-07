import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/class/statusrequest.dart';
import '../../core/function/handilingdata.dart';
import '../../data/datasource/remote/adminData/ajouterVendeurdata.dart';

class AjouterSecteurController extends GetxController {
  late TextEditingController noms;

  GlobalKey<FormState> formstate = GlobalKey<FormState>();

  late StatusRequest statusRequest;
  AjouterVendeurData ajouterVendeurData = AjouterVendeurData(Get.find());

  enregister() async {
    if (formstate.currentState!.validate()) {
      statusRequest = StatusRequest.loading;
      update();
      var response = await ajouterVendeurData.ajouterSecteur(
        noms.text,
      );
      print("============================== $response");
      statusRequest = handlingData(response);
      if (StatusRequest.success == statusRequest) {
        if (response['status'] == "success") {
          print("============================== $response");
          Get.defaultDialog(
              title: "Success",
              middleText: "Le secteur a été enregistré avec succès");
          // annuler();
        }
      }
    }
  }

  annuler() {
    noms.clear();
  }

  @override
  void onInit() {
    noms = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    noms.dispose();
    super.dispose();
  }
}
