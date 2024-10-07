import 'dart:io';

import 'package:get/get.dart';
import 'package:my_pfe/core/serices.dart';
import '../../core/class/statusrequest.dart';
import '../../core/function/handilingdata.dart';
import '../../core/function/uploadfile.dart';
import '../../data/datasource/remote/adminData/get_vendeurs_data.dart';

class HomeControllerV extends GetxController {
  GetVendeursData getVendeursData = GetVendeursData(Get.find());
  MyServices myServices = Get.find();
  String? idv;
  File? file;
  late StatusRequest statusRequest;
  // late List vendeur;s
  Map<String, dynamic> vendeur = {};

  initialData() {
    idv = myServices.sharedPreferences.getString("id");
  }

  editProfile() async {
    statusRequest = StatusRequest.loading;
    update();
    if (file != null) {
      var response = await getVendeursData.editProfile(idv!, file);
      print("***********ProduitEdit $response");
      statusRequest = handlingData(response);
      if (StatusRequest.success == statusRequest) {
        if (response['status'] == "success") {
          HomeControllerV pc = Get.find();
          pc.getVendeur();
        } else {
          statusRequest = StatusRequest.failure;
        }
      }
    }

    update();
  }

  chooseImage() async {
    file = await fileUploadGallery();
    update();
  }

  getVendeur() async {
    statusRequest = StatusRequest.loading;
    var response = await getVendeursData.getvedeurbyid(idv!);
    statusRequest = handlingData(response);
    print("********************** $response");
    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        List<dynamic> vendeursList = response['data'];
        if (vendeursList.isNotEmpty) {
          vendeur = vendeursList[0];
          update();
        }
        // vendeur = response['data'][0];
      } else {
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }

  @override
  void onInit() async {
    initialData();
    await getVendeur();
    super.onInit();
  }
}
