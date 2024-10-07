// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import 'package:my_pfe/core/serices.dart';
// import 'package:my_pfe/data/datasource/remote/vendeurData/enregistrerCommandeData.dart';
// import 'package:my_pfe/data/model/categoriesModel.dart';
// import '../../core/class/statusrequest.dart';
// import '../../core/function/handilingdata.dart';
// import '../../data/model/clientModel.dart';

// class ConsulterCommandeController extends GetxController {
//   EnregistrerCommandeData enregistrerCommandeData =
//       EnregistrerCommandeData(Get.find());
//   MyServices myServices = Get.find();
//   String? idv;
//   late StatusRequest statusRequest;
//   List<ClientsModel> client = [];
//   List<CategoriesModel> produit = [];
//   String? selectedValue;
//   int quantite = 0;
//   dynamic factureId;

//   final GlobalKey<FormState> formKey = GlobalKey<FormState>();

//   initialData() {
//     idv = myServices.sharedPreferences.getString("id");
//   }

//   Future<void> getClients() async {
//     statusRequest = StatusRequest.loading;
//     var response = await enregistrerCommandeData.getClient(idv!);
//     print("***************Clients**** $response");
//     statusRequest = handlingData(response);

//     if (StatusRequest.success == statusRequest) {
//       if (response['status'] == "success") {
//         List datalist = response['data'];
//         client.addAll(datalist.map((e) => ClientsModel.fromJson(e)));
//       }
//     }
//     update();
//   }

//   getProduit() async {
//     statusRequest = StatusRequest.loading;
//     var response = await enregistrerCommandeData.getProduit();
//     print("***************Produit**** $response");
//     statusRequest = handlingData(response);

//     if (StatusRequest.success == statusRequest) {
//       if (response['status'] == "success") {
//         List datalist = response['data'];
//         produit.addAll(datalist.map((e) => CategoriesModel.fromJson(e)));
//       }
//     }
//     update();
//   }

//   setSelectedvalue(value) {
//     selectedValue = value.toString();
//     update();
//   }

//   bool isAscending = false;

//   // void incrementQuantity(int index) {
//   //   produit[index].quantite!++;//Illegal assignment to non-assignable expression. j'ai cette erreur ici que je doit faire
//   //   update();
//   // }

//   @override
//   void onInit() async {
//     statusRequest = StatusRequest.loading;
//     initialData();

//     super.onInit();
//   }
// }
