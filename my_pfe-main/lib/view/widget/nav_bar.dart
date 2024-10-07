import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_pfe/controller/admin_controller/home_controller.dart';
import 'package:my_pfe/core/class/handlingdataview.dart';

import 'package:my_pfe/core/constant/routes.dart';

//import '../../core/class/statusrequest.dart';
import '../../core/constant/linkapi.dart';

class NavBar extends StatelessWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context) {
    //  HomeControllerA controller =
    Get.put(HomeControllerA());
    return GetBuilder<HomeControllerA>(builder: (controller) {
      return HandlingDataView(
        statusRequest: controller.statusRequest,
        widget: Drawer(
          child: ListView(padding: EdgeInsets.zero, children: [
            Center(
              child: UserAccountsDrawerHeader(
                accountName: const Text('Responsable'),
                accountEmail: Text("${controller.admin['id']}"),
                decoration: const BoxDecoration(
                  color: Colors.green,
                ),
                currentAccountPicture: Stack(
                  children: [
                    ClipOval(
                      child: CachedNetworkImage(
                        imageUrl:
                            '${AppLink.imageUsers}/${controller.admin['imageU']}',
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
              ),
            ),
            ExpansionTile(
              leading: Icon(
                Icons.person,
                color: Colors.green[800],
              ),
              iconColor: Colors.green[800],
              title: Text(
                'Ajouter Employer',
                style: TextStyle(color: Colors.green[800]),
              ),
              children: <Widget>[
                ListTile(
                  leading: Icon(
                    Icons.person_add,
                    color: Colors.green[800],
                  ),
                  title: const Text('Ajouter Vendeur'),
                  onTap: () {
                    Get.toNamed(AppRoute.ajoutervendeur);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.person_add, color: Colors.green[800]),
                  title: const Text('Ajouter Responsable'),
                  onTap: () {
                    Get.toNamed(AppRoute.ajouterrespo);
                  },
                ),
              ],
            ),
            ListTile(
              leading: Icon(Icons.block, color: Colors.green[800]),
              title: const Text('Gestion de Blocage '),
              onTap: () {
                Get.toNamed(AppRoute.bloquervendeur);
              },
            ),
            ListTile(
              leading: Icon(Icons.business, color: Colors.green[800]),
              title: const Text("Affectation des Secteurs"),
              onTap: () {
                Get.toNamed(AppRoute.affectationView);
              },
            ),
            ListTile(
              leading: Icon(Icons.shopping_cart, color: Colors.green[800]),
              title: const Text("consulter commande"),
              onTap: () {
                Get.toNamed(AppRoute.consulterCommandeView);
              },
            ),
            ListTile(
              leading: Icon(Icons.calendar_today, color: Colors.green[800]),
              title: const Text("consulter planing"),
              onTap: () {
                Get.toNamed(AppRoute.planningView);
              },
            ),
            ListTile(
              leading: Icon(Icons.production_quantity_limits_sharp,
                  color: Colors.green[800]),
              title: const Text("Gestion des Produits"),
              onTap: () {
                Get.toNamed(AppRoute.produitAView);
              },
            ),
            ListTile(
              leading: Icon(Icons.add_box, color: Colors.green[800]),
              title: const Text("Ajouter Secteur"),
              onTap: () {
                Get.toNamed(AppRoute.ajouterSecteur);
              },
            ),
            const Divider(),
            ListTile(
              leading: Icon(Icons.exit_to_app, color: Colors.green[800]),
              title: const Text("Log out"),
              onTap: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, AppRoute.login, (route) => false);
              },
            ),
          ]),
        ),
      );
    });
  }
}
