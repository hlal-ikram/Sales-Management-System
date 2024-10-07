import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/class/statusrequest.dart';
import '../../core/function/handilingdata.dart';
import '../../data/datasource/remote/adminData/ajouterVendeurdata.dart';

class AjouterAdminController extends GetxController {
  late TextEditingController cin;
  late TextEditingController id;
  GlobalKey<FormState> formstate = GlobalKey<FormState>();

  late StatusRequest statusRequest;
  AjouterVendeurData ajouterVendeurData = AjouterVendeurData(Get.find());

  enregister() async {
    if (formstate.currentState!.validate()) {
      statusRequest = StatusRequest.loading;
      update();
      var response = await ajouterVendeurData.ajouterAdmin(id.text, cin.text);
      print("============================== $response");
      statusRequest = handlingData(response);
      if (StatusRequest.success == statusRequest) {
        if (response['status'] == "success") {
          print("============================== $response");
          Get.defaultDialog(
              title: "Success",
              middleText: "Le responsable a été enregistré avec succès");
          //  annuler();
        } else {
          Get.dialog(
            const AlertDialog(
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.error,
                    size: 60,
                    color: Colors.red,
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Le responsable avec cet identifiant existe déjà",
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
            ),
          );
          statusRequest = StatusRequest.failure;
        }
      }
    }
  }

  annuler() {
    id.clear();
    cin.clear();
  }

  @override
  void onInit() {
    cin = TextEditingController();
    id = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    cin.dispose();
    id.dispose();
    super.dispose();
  }
}
