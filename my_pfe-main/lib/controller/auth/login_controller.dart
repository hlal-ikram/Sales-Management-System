import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:my_pfe/core/class/statusrequest.dart';
import 'package:my_pfe/core/constant/routes.dart';
import 'package:my_pfe/core/function/handilingdata.dart';
import 'package:my_pfe/data/datasource/remote/login.dart';
import '../../core/serices.dart';

class LoginController extends GetxController {
  bool isshowpassord = true;
  StatusRequest? statusRequest;
  LoginData loginData = LoginData(Get.find());
  late TextEditingController id;
  late TextEditingController cin;
  GlobalKey<FormState> formstate = GlobalKey<FormState>();

  MyServices myServices = Get.find();

  showPassword() {
    isshowpassord = isshowpassord == true ? false : true;
    update();
  }

  login() async {
    if (formstate.currentState!.validate()) {
      statusRequest = StatusRequest.loading;
      update();

      var response = await loginData.postdata(id.text, cin.text);
      print("==========================Controller $response");
      statusRequest = handlingData(response);

      if (StatusRequest.success == statusRequest) {
        if (response['status'] == "success" &&
            response['message'] == "vendeur" &&
            response['etat'] == 1) {
          Get.offNamed(AppRoute.homaVendeur);
          myServices.sharedPreferences.setString("id", response['data']['id']);
          myServices.sharedPreferences.setString("type", response['message']);
          myServices.sharedPreferences.setString("step", "2");
        } else if (response['status'] == "success" &&
            response['message'] == "admin") {
          Get.offNamed(AppRoute.homaAdmin);
          myServices.sharedPreferences.setString("id", response['data']['id']);
          myServices.sharedPreferences.setString("type", response['message']);
          myServices.sharedPreferences.setString("step", "2");
        } else if (response['status'] == "failure") {
          Get.defaultDialog(
            title: "Erreur d'identification",
            middleText: "Identifiant ou mot de passe incorrect",
          );

          statusRequest = StatusRequest.failure;
        } else if (response['status'] == "success" &&
            response['message'] == "vendeur" &&
            response['etat'] == 0) {
          Get.defaultDialog(
            title: "Accès bloqué",
            middleText:
                "Votre accès est bloqué. Veuillez contacter le responsable pour plus d'informations.",
          );
        }
      }
      //if ()

      update();
    }
  }

  @override
  void onInit() {
    id = TextEditingController();
    cin = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    id.dispose();
    cin.dispose();
    super.dispose();
  }
}
