import 'dart:io';

import 'package:get/get.dart';
import 'package:my_pfe/core/serices.dart';
import '../../core/class/statusrequest.dart';
import '../../core/function/handilingdata.dart';
import '../../core/function/uploadfile.dart';
import '../../data/datasource/remote/adminData/get_vendeurs_data.dart';

class HomeControllerA extends GetxController {
  GetVendeursData getVendeursData = GetVendeursData(Get.find());
  MyServices myServices = Get.find();
  String? idv;
  late StatusRequest statusRequest;
  Map<String, dynamic> admin = {};
  File? file;

  initialData() {
    idv = myServices.sharedPreferences.getString("id");
  }

  chooseImage() async {
    file = await fileUploadGallery();
    update();
  }

  getadmin() async {
    statusRequest = StatusRequest.loading;
    var response = await getVendeursData.getadminbyid(idv!);
    statusRequest = handlingData(response);
    print("********************** $response");
    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        List<dynamic> vendeursList = response['data'];
        if (vendeursList.isNotEmpty) {
          admin = vendeursList[0];
          update();
        }
        // vendeur = response['data'][0];
      } else {
        statusRequest = StatusRequest.failure;
      }
    }
    update();
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
          HomeControllerA pc = Get.find();
          pc.getadmin();
        } else {
          statusRequest = StatusRequest.failure;
        }
      }
    }

    update();
  }

  @override
  void onInit() async {
    initialData();
    await getadmin();
    super.onInit();
  }
}


 // editeImage(File value) {
  //   file = value;
  //   update();
  // }

  //  updateProfileImage(String imageUrl) {
  //   admin['imageU'] = imageUrl;
  //   update();
  // }
