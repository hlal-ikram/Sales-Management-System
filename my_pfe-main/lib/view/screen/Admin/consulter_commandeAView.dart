import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../controller/admin_controller/consulterCommandeController.dart';
import '../../../core/class/handlingdataview.dart';
import 'dart:core';

class ConsulterCommandeView extends StatefulWidget {
  const ConsulterCommandeView({super.key});
  @override
  _ConsulterCommandeViewState createState() => _ConsulterCommandeViewState();
}

class _ConsulterCommandeViewState extends State<ConsulterCommandeView> {
  @override
  Widget build(BuildContext context) {
    Get.put(ConsulterCommandeController());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[700],
        title: const Center(child: Text("Consulter les ventes    ")),
      ),
      drawerScrimColor: Colors.transparent,
      body: GetBuilder<ConsulterCommandeController>(
        builder: (controller) => HandlingDataView(
          statusRequest: controller.statusRequest,
          widget: Form(
            key: controller.formKey,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: SizedBox(
                height: 600,
                child: ListView(children: <Widget>[
                  Row(
                    // mainAxisSize: MainAxisSize.min,
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      SizedBox(
                        height: 55,
                        width: 240,
                        child: DropdownButtonFormField(
                          hint: const Text("Sélectionner un vendeur "),
                          value: controller.selectedValue,
                          items: controller.vendeur.map((vendeur) {
                            return DropdownMenuItem(
                              value: vendeur.nom_complet,
                              child: Text(vendeur.nom_complet!),
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
                              return 'Veuillez sélectionner le vendeur';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 6,
                      ),
                      SizedBox(
                        height: 55,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.green),
                          ),
                          onPressed: () {
                            showDatePicker(
                              context: context,
                              initialDate: controller.datee,
                              firstDate: DateTime(2023),
                              lastDate: DateTime(2054),
                            ).then((date) {
                              if (date != null) {
                                setState(() {
                                  controller.datee = date;
                                });
                              }
                            });
                          },
                          child: Row(
                            children: [
                              Text(
                                  ' ${DateFormat('yyyy/MM/dd').format(controller.datee)}'),
                              const Icon(
                                Icons.calendar_today_rounded,
                                color: Colors.black,
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    width: 50,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.green),
                      ),
                      onPressed: () {
                        controller.getCommandes();
                        controller.showCommandes = true;
                      },
                      child: const Text('Chercher '),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  if (controller.showCommandes)
                    //  double totalPrixCommandes = 0;
                    for (var commande in controller.commandes) ...[
                      const SizedBox(height: 16.0),

                      Card(
                        child: ExpansionTile(
                          title: Text(" Nom du client: ${commande.client}"),
                          subtitle:
                              Text("Adresse du client : ${commande.adressec}"),
                          trailing: Text(
                              "Prix du  commande: ${commande.prixCommande}"),
                          children: [
                            Table(
                              border: TableBorder.all(),
                              columnWidths: const {
                                0: FractionColumnWidth(0.4),
                                1: FractionColumnWidth(0.3),
                                2: FractionColumnWidth(0.3),
                              },
                              children: [
                                const TableRow(
                                  children: [
                                    TableCell(
                                        child: Center(
                                            child: Text(
                                                'Nom      Type Kg    Prix DH'))),
                                    TableCell(
                                        child: Center(child: Text('Quantité'))),
                                    TableCell(
                                        child: Center(child: Text('Prix'))),
                                  ],
                                ),
                                ...commande.produits!.split(";").map((product) {
                                  final RegExp regExp = RegExp(
                                      r'\(Nom:(.*?)\)\(Quantité:(.*?)\)\(Prix:(.*?)\)');
                                  final Iterable<RegExpMatch> matches =
                                      regExp.allMatches(product);

                                  if (matches.isNotEmpty) {
                                    final RegExpMatch match = matches.first;
                                    final productName = match.group(1);
                                    final productQuantity = match.group(2);
                                    final productPrice = match.group(3);

                                    return TableRow(
                                      children: [
                                        TableCell(
                                            child: Center(
                                                child: Text(productName!))),
                                        TableCell(
                                            child: Center(
                                                child: Text(productQuantity!))),
                                        TableCell(
                                            child: Center(
                                                child: Text(productPrice!))),
                                      ],
                                    );
                                  }

                                  return const TableRow(children: [
                                    TableCell(
                                        child: Center(
                                            child: Text('Invalid Data'))),
                                    TableCell(
                                        child: Center(
                                            child: Text('Invalid Data'))),
                                    TableCell(
                                        child: Center(
                                            child: Text('Invalid Data'))),
                                  ]);
                                }).toList(),
                              ],
                            ),
                          ],
                        ),
                      ),
                      //  commande.prixtotal += double.parse(commande.prixCommande); // j'ai cette erreur The element type 'double' can't be assigned to the list type 'Widget'.
                    ],
                  if (!controller.showCommandes)
                    const Text(
                      "Aucune vente n'a été trouvée à cette date pour ce vendeur.",
                    ),
                ]),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
