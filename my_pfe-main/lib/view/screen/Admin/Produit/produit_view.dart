import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_pfe/controller/admin_controller/produits/produitV_controller.dart';
import 'package:my_pfe/core/class/handlingdataview.dart';
import 'package:my_pfe/core/constant/linkapi.dart';
import 'package:my_pfe/core/constant/routes.dart';

class ProduitAView extends StatelessWidget {
  const ProduitAView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(ProduitController());
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Center(child: Text('Minoterie Othman')),
        shadowColor: const Color.fromARGB(255, 2, 249, 15),
        backgroundColor: Colors.green[600],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(AppRoute.produitAAdd);
        },
        child: const Icon(Icons.add),
      ),
      body: GetBuilder<ProduitController>(
        builder: (controller) {
          return HandlingDataView(
            statusRequest: controller.statusRequest,
            widget: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.all(30),
                  child: Text(
                    "Gérer les produits",
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: ListView.builder(
                      itemCount: controller.data.length,
                      itemBuilder: (context, index) {
                        return Card(
                          shadowColor: Colors.green,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: const BorderSide(
                              color: Color.fromARGB(40, 0, 65, 35),
                              width: 0.7,
                            ),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Container(
                                  padding: const EdgeInsets.all(4),
                                  child: CachedNetworkImage(
                                    height: 110,
                                    imageUrl:
                                        "${AppLink.imagep}/${controller.data[index].Imagep}",
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: ListTile(
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Tooltip(
                                        message: "Modifier",
                                        child: IconButton(
                                          icon: const Icon(Icons.edit_outlined),
                                          onPressed: () {
                                            controller.goToPageEdit(
                                                controller.data[index]);
                                          },
                                        ),
                                      ),
                                      Tooltip(
                                        message: "Supprimer",
                                        child: IconButton(
                                          icon:
                                              const Icon(Icons.delete_outline),
                                          onPressed: () {
                                            Get.defaultDialog(
                                              title: "Confirmation",
                                              middleText:
                                                  "Êtes-vous sûr de vouloir supprimer ce produit ?",
                                              onCancel: () {},
                                              textCancel: 'Annuler',
                                              textConfirm: 'Confirmer',
                                              buttonColor: Colors.green,
                                              confirmTextColor: Colors.white,
                                              cancelTextColor: Colors.black,
                                              onConfirm: () {
                                                controller.deleteProduit(
                                                  controller
                                                      .data[index].ProduitID!,
                                                  controller
                                                      .data[index].Imagep!,
                                                );
                                                Get.back();
                                              },
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                  subtitle: Text(
                                    "Prix: ${controller.data[index].prixp} DH",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                  title: Text(
                                    '${controller.data[index].Nomp!} ${controller.data[index].Typep} KG',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
