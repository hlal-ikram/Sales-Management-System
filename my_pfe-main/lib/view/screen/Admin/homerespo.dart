import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_pfe/view/widget/nav_bar.dart';

import '../../../controller/admin_controller/home_controller.dart';
import '../../../core/class/handlingdataview.dart';

class HomeAdmin extends StatelessWidget {
  const HomeAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(HomeControllerA());
//  HomeControllerA controller =
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[700],
        title: const Center(child: Text("Minoterie Othman ")),
      ),

      drawer: const NavBar(),
      // backgroundColor: Colors.compexDrawerCanvasColor,
      drawerScrimColor: Colors.transparent,
      body: GetBuilder<HomeControllerA>(builder: (controller) {
        return HandlingDataView(
          statusRequest: controller.statusRequest,
          widget: Center(
            child: Text("${controller.idv}"),
          ),
        );
      }),
    );
  }
}
