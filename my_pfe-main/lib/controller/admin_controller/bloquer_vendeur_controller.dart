import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_pfe/core/class/statusrequest.dart';

import '../../core/function/handilingdata.dart';
import '../../data/datasource/remote/adminData/get_vendeurs_data.dart';

class BlocageController extends GetxController {
  GetVendeursData getVendeursData = GetVendeursData(Get.find());
  List vendeur = [];
  late StatusRequest statusRequest;

  getData() async {
    statusRequest = StatusRequest.loading;
    var response = await getVendeursData.getData();
    statusRequest = handlingData(response);
    //print("*****************Bloquerr***** $response");

    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        vendeur.addAll(response['data']);
      } else {
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }

  // bloquer(int index, String action) async {
  //   statusRequest = StatusRequest.loading;
  //   //print("Index: $index, Action: $action");
  //   var response =
  //       await getVendeursData.postdata(vendeur[index]["idV"], action);
  //   //print("Response bloquer Controller: $response");
  //   statusRequest = handlingData(response);

  //   //print("*****************BloquerController $response");
  //   if (StatusRequest.success == statusRequest) {
  //     if (response['status'] == "success") {
  //       vendeur[index]["service"] = action == '0' ? 0 : 1;
  //     } else {
  //       statusRequest = StatusRequest.failure;
  //     }
  //   }
  //   update();
  // }

  bloquer(int index, String action) async {
    if (index >= 0 && index < vendeur.length) {
      statusRequest = StatusRequest.loading;
      var response =
          await getVendeursData.postdata(vendeur[index]["idV"], action);
      statusRequest = handlingData(response);

      // Décommentez les lignes suivantes pour activer le débogage
      print("Index: $index, Action: $action");
      print("Response bloquer Controller: $response");
      print("*****************BloquerController $response");

      if (StatusRequest.success == statusRequest) {
        if (response['status'] == "success") {
          vendeur[index]["service"] = action == '0' ? 0 : 1;
        } else {
          statusRequest = StatusRequest.failure;
        }
      }
      update();
    } else {
      print("Invalid index: $index");
    }
  }

  // showDialogBox(BuildContext context, int index) {
  //   showDialog(
  //     context: context,
  //     builder: (context) {
  //       return AlertDialog(
  //         title: Text(
  //           vendeur[index]["service"] == 1
  //               ? "Bloquer Vendeur"
  //               : "Débloquer Vendeur",
  //         ),
  //         content: Text(
  //           vendeur[index]["service"] == 1
  //               ? "Le vendeur ${vendeur[index]["Nomv"]} ${vendeur[index]["Prenomv"]} a été bloqué avec succès."
  //               : "Le vendeur ${vendeur[index]["Nomv"]} ${vendeur[index]["Prenomv"]} a été débloqué avec succès.",
  //         ),
  //         actions: [
  //           TextButton(
  //             onPressed: () {
  //               //print('Index: $index, Action: ${vendeur[index]["service"]}');
  //               bloquer(index,
  //                   vendeur[index]["service"].toString() == '1' ? '0' : '1');
  //               Navigator.of(context).pop();
  //             },
  //             child: const Text("OK"),
  //           ),
  //           TextButton(
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //             },
  //             child: const Text("Cancel"),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  showDialogBox(BuildContext context, int index) {
    String title = vendeur[index]["service"] == 1
        ? "Bloquer Vendeur"
        : "Débloquer Vendeur";
    String content = vendeur[index]["service"] == 1
        ? "Êtes-vous sûr de vouloir bloquer le vendeur ${vendeur[index]["Nomv"]} ${vendeur[index]["Prenomv"]} ?"
        : "Êtes-vous sûr de vouloir débloquer le vendeur ${vendeur[index]["Nomv"]} ${vendeur[index]["Prenomv"]} ?";

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            TextButton(
              onPressed: () {
                //print('Index: $index, Action: ${vendeur[index]["service"]}');
                bloquer(
                  index,
                  vendeur[index]["service"].toString() == '1' ? '0' : '1',
                );
                Navigator.of(context).pop();
              },
              child: const Text("Confirmer"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Annuler"),
            ),
          ],
        );
      },
    );
  }

  @override
  void onInit() async {
    await getData();
    int index = 0;
    String action = "1";
    bloquer(index, action);

    super.onInit();
  }
}
