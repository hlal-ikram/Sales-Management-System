import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_pfe/controller/vendeur_controller/home_controllerV.dart';
import '../../../core/class/handlingdataview.dart';
import '../../widget/auth/nav_bar_vendeur.dart';

class HomeVendeur extends StatelessWidget {
  const HomeVendeur({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(HomeControllerV());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[700],
        title: const Center(child: Text("Minoterie Othman ")),
      ),
      // backgroundColor: Colors.compexDrawerCanvasColor,
      drawerScrimColor: Colors.transparent,
      body: GetBuilder<HomeControllerV>(
        builder: (controller) => HandlingDataView(
          statusRequest: controller.statusRequest,
          widget: Center(
            child: Text("${controller.vendeur['Prenomv']}"),
          ),
        ),
      ),
      drawer: const NavBarVendeur(),
    );
  }
}
