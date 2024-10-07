import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_pfe/controller/vendeur_controller/enregidtreCommandeController.dart';
import 'package:my_pfe/core/constant/routes.dart';
import '../../../core/class/handlingdataview.dart';
import '../../../core/constant/linkapi.dart';

class EnregistrerCommande extends StatelessWidget {
  const EnregistrerCommande({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(EnregistrerCommandeController());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[700],
        title: const Center(child: Text("Enregister vente  ")),
      ),
      drawerScrimColor: Colors.transparent,
      body: GetBuilder<EnregistrerCommandeController>(
        builder: (controller) => HandlingDataView(
            statusRequest: controller.statusRequest,
            widget: Form(
              key: controller.formKey,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: ListView(children: <Widget>[
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      SizedBox(
                        width: 300,
                        child: DropdownButtonFormField(
                          hint: const Text("Sélectionner un client "),
                          value: controller.selectedValue,
                          items: controller.client.map((client) {
                            return DropdownMenuItem(
                              value: client.nomc,
                              child: Text(client.nomc!),
                            );
                          }).toList(),
                          onChanged: (value) {
                            controller.setSelectedvalue(value);
                          },
                          decoration: InputDecoration(
                            //labelText: 'Sélectionner un client ',
                            border: const OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: const BorderSide(
                                  color: Color.fromARGB(185, 1, 103, 48)),
                            ),
                            filled: true,
                            fillColor: Colors.green[60],
                          ),
                          validator: (value) {
                            if (value == null) {
                              return 'Veuillez sélectionner le client';
                            }
                            return null;
                          },
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          Get.toNamed(AppRoute.clientRegistrationPage);
                        },
                        icon: Icon(
                          Icons.person_add,
                          color: Colors.green[700],
                        ),
                        iconSize: 35,
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Container(
                    height: 456,
                    decoration: BoxDecoration(color: Colors.green[50]),
                    padding: const EdgeInsets.only(top: 5),
                    child: Center(
                      child: ListView.separated(
                          separatorBuilder: (context, index) => const SizedBox(
                              // width: 6,
                              ),
                          // shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: controller.produit.length,
                          itemBuilder: (context, index) {
                            return Card(
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Card(
                                        child: CachedNetworkImage(
                                            height: 110,
                                            width: 76,
                                            imageUrl:
                                                "${AppLink.imagep}/${controller.produit[index].Imagep}"),
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: 148,
                                            child: Text(
                                              "${controller.produit[index].Nomp!} ${controller.produit[index].Typep!}KG ",
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          Text(
                                              'Prix: ${controller.produit[index].prixp!} DH'),
                                        ],
                                      ),
                                      const Spacer(),
                                      IconButton(
                                        icon: const Icon(Icons.remove),
                                        onPressed: () =>
                                            controller.decrementQuantity(index),
                                      ),
                                      Text(controller.produit[index].quantite
                                          .toString()),
                                      IconButton(
                                        icon: const Icon(Icons.add),
                                        onPressed: () =>
                                            controller.incrementQuantity(index),
                                      ),
                                    ],
                                  ),
                                ],
                              ),

                              // ),
                            );
                          }),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      Card(
                        elevation: 6,
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          width: 294,
                          height: 77,
                          child: Column(
                            children: [
                              Text(
                                  'Prix total de la commande: ${controller.calculateTotalPrice().toString()} DH'),
                              const Spacer(),
                              Text(
                                'Prix avec reduction: ${controller.calculateTotalPriceWithDiscount().toString()} DH',
                              ),
                            ],
                          ),
                        ),
                      ),
                      // IconButton(
                      //   icon: Icon(Icons.sort),
                      //   onPressed: () {
                      //     controller
                      //         .sortProductsByQuantity(); // Appeler la méthode de tri dans le contrôleur
                      //   },
                      //   tooltip:
                      //       'Trier par quantité',

                      // ),

                      Tooltip(
                        decoration: BoxDecoration(),
                        message: 'Trier par quantité',
                        child: IconButton(
                          icon: const Icon(Icons.sort),
                          iconSize: 24,
                          color: Colors.redAccent,
                          // Ajouter un effet de surbrillance lorsqu'on survole l'icône
                          hoverColor: Colors.lightBlueAccent,
                          onPressed: () {
                            controller.sortProductsByQuantity();
                          },
                        ),
                      ),
                      //
                    ],
                  ),

                  SizedBox(
                    width: 100,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            const Color.fromARGB(255, 6, 191,
                                52)), // Modifier la couleur de fond du bouton
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        elevation: MaterialStateProperty.all<double>(6),
                      ),
                      onPressed: () {
                        controller.valider(context); //
                      },
                      child: Text('Valider'),
                    ),
                  ),

                  // Text(controller.selectedValue!),
                ]),
              ),
            )),
      ),
    );
  }
}
