//import 'dart:js_util';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_pfe/core/constant/linkapi.dart';
import 'package:my_pfe/core/constant/routes.dart';

import '../../../controller/vendeur_controller/home_controllerV.dart';
import '../../../core/class/handlingdataview.dart';
//import 'package:my_pfe/view/screen/auth/logoauth.dart';

class NavBarVendeur extends StatelessWidget {
  const NavBarVendeur({super.key});

  @override
  Widget build(BuildContext context) {
    // HomeControllerV controller =
    Get.put(HomeControllerV());
    return GetBuilder<HomeControllerV>(builder: (controller) {
      return HandlingDataView(
          statusRequest: controller.statusRequest,
          widget: Drawer(
            child: ListView(padding: EdgeInsets.zero, children: [
              Center(
                child: UserAccountsDrawerHeader(
                  accountName: const Text('Vendeur'),
                  accountEmail: Text("${controller.vendeur['Nomv']}"),
                  decoration: const BoxDecoration(
                    color: Colors.green,
                  ),
                  currentAccountPicture: Stack(
                    children: [
                      ClipOval(
                        child: CachedNetworkImage(
                          imageUrl:
                              '${AppLink.imageUsers}/${controller.vendeur['imageU']}',
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        bottom: 2,
                        right: 0,
                        child: GestureDetector(
                          onTap: () {
                            controller.chooseImage();
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              if (controller.file != null) {
                                Get.defaultDialog(
                                  //   title: "succès",
                                  content: Image.file(
                                    controller.file!,
                                    width: 200,
                                    height: 200,
                                  ),
                                  confirm: ElevatedButton(
                                    onPressed: () {
                                      controller.editProfile();

                                      Get.back();
                                    },
                                    child: const Text("Confirmer"),
                                  ),
                                );
                              }
                            });
                          },
                          child: Container(
                            width: 24,
                            height: 25,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                            child: const Icon(
                              Icons.edit,
                              color: Color.fromARGB(255, 6, 128, 57),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  // currentAccountPicture: ClipOval(
                  //   child: Image.network(
                  //     '${AppLink.imageUsers}/${controller.vendeur['imageU']}',
                  //     fit: BoxFit.cover,
                  //   ),
                  // ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.calendar_today, color: Colors.green[800]),
                title: const Text("consulter planing"),
                onTap: () {
                  Get.toNamed(AppRoute.consulterPlaning);
                },
              ),
              ListTile(
                leading: Icon(Icons.shopping_cart, color: Colors.green[800]),
                title: const Text("Enregistrer vente"),
                onTap: () {
                  Get.toNamed(AppRoute.enregistrerCommande);
                },
              ),
              ListTile(
                leading: Icon(Icons.person_add, color: Colors.green[800]),
                title: const Text("Ajouter Client"),
                onTap: () {
                  Get.toNamed(AppRoute.clientRegistrationPage);
                },
              ),
              ListTile(
                leading: Icon(Icons.add_box, color: Colors.green[800]),
                title: const Text("Saisi commande"),
                onTap: () {
                  Get.toNamed(AppRoute.saisiecommande);
                },
              ),
              const Divider(thickness: 2),
              ListTile(
                leading: Icon(Icons.exit_to_app, color: Colors.green[800]),
                title: const Text("Log out"),
                onTap: () {
                  Navigator.pushNamedAndRemoveUntil(
                      context, AppRoute.login, (route) => false);
                },
              ),
            ]),
          ));
    });
  }
}
