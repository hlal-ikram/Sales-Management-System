import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_pfe/core/constant/routes.dart';

import '../../../core/constant/imagesasset.dart';
//import '../../widget/auth/custombuttomauth.dart';

class ImpressionScreen extends StatelessWidget {
  final String? dateCommande;
  final String? heureCommande;
  final String? nomClient;
  final List<String> produits;
  final List<int> produitsType;
  final List<int> quantites;
  final List<dynamic> produitsPrix;
  final double? prixTotal;
  final double? prixTotalReduction;

  ImpressionScreen({
    this.dateCommande,
    this.heureCommande,
    this.nomClient,
    required this.produits,
    required this.produitsType,
    required this.quantites,
    required this.produitsPrix,
    this.prixTotal,
    this.prixTotalReduction,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[700],
        title: const Center(child: Text("Imprimer la Facture ")),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          padding: EdgeInsets.all(30),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Container(
                      alignment: Alignment.topLeft,
                      padding: EdgeInsets.only(right: 50),
                      child: Image.asset(
                        AppImageAsset.logoFac,
                        height: 90,
                      )),
                  Container(
                    alignment: Alignment.topRight,
                    child: const Text(
                      'Facture ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 10),
              const Divider(
                //  height: 4,
                thickness: 2,
                color: Colors.green,
              ),
              const SizedBox(height: 8),
              Text(
                'Date : $dateCommande',
                style: const TextStyle(fontSize: 17),
              ),
              Text(
                'Heure : $heureCommande',
                style: const TextStyle(fontSize: 17),
              ),
              Text(
                'Client: $nomClient',
                style: const TextStyle(fontSize: 17),
              ),
              const SizedBox(height: 20),
              Table(
                columnWidths: const {
                  0: FlexColumnWidth(1.5),
                  1: FlexColumnWidth(1),
                  2: FlexColumnWidth(1),
                  3: FlexColumnWidth(1),
                },
                border: TableBorder.all(),
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                children: [
                  const TableRow(
                    children: [
                      TableCell(
                        child: Center(
                          child: Text(
                            'Produit',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      TableCell(
                        child: Center(
                          child: Text(
                            'Quantité',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      TableCell(
                        child: Center(
                          child: Text(
                            'Prix',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      TableCell(
                        child: Center(
                          child: Text(
                            'Prix Total',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  for (int index = 0; index < produits.length; index++)
                    TableRow(
                      children: [
                        TableCell(
                          child: Center(
                            child: Text(
                              produits[index],
                              style: TextStyle(fontSize: 17),
                            ),
                          ),
                        ),
                        TableCell(
                          child: Center(
                            child: Text(
                              quantites[index].toString(),
                              style: TextStyle(fontSize: 17),
                            ),
                          ),
                        ),
                        TableCell(
                          child: Center(
                            child: Text(
                              produitsPrix[index].toStringAsFixed(2) + ' DH',
                              style: const TextStyle(fontSize: 17),
                            ),
                          ),
                        ),
                        TableCell(
                          child: Center(
                            child: Text(
                              (quantites[index] * produitsPrix[index])
                                      .toStringAsFixed(2) +
                                  ' DH',
                              style: TextStyle(fontSize: 17),
                            ),
                          ),
                        ),
                      ],
                    ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Prix total: $prixTotal DH',
                style: const TextStyle(fontSize: 20),
              ),
              Text(
                'Prix total avec Reduction: $prixTotalReduction DH',
                style: const TextStyle(fontSize: 20),
              ),
              // Stack(children: [
              //   Positioned(child: child)
              // ]),
              SizedBox(
                height: 150,
              ),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      const Color.fromARGB(255, 6, 191,
                          52)), // Modifier la couleur de fond du bouton
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  elevation: MaterialStateProperty.all<double>(6),
                ),
                onPressed: () {
                  Get.toNamed(AppRoute.enregistrerCommande);
                },
                child: const Text('Imprimer '),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

              // ListView.builder(
              //   shrinkWrap: true,
              //   itemCount: produits.length,
              //   itemBuilder: (context, index) {
              //     final produit = produits[index];
              //     final quantite = quantites[index];
              //     final prixProduit = produitsPrix[index];
              //     final prixTotalProduit = quantite * prixProduit;

              //     return Table(
              //       columnWidths: const {
              //         0: FlexColumnWidth(1.5),
              //         1: FlexColumnWidth(1),
              //         2: FlexColumnWidth(1),
              //         3: FlexColumnWidth(1),
              //       },
              //       border:
              //           TableBorder.all(), // Ajouter des bordures au tableau
              //       defaultVerticalAlignment: TableCellVerticalAlignment
              //           .middle, // Ajuster l'alignement vertical
              //       children: [
              //         TableRow(
              //           children: [
              //             TableCell(
              //                 child: Text(
              //               '$produit ',
              //               style: const TextStyle(fontSize: 17),
              //             )),
              //             TableCell(
              //                 child: Text(
              //               '$quantite',
              //               style: const TextStyle(fontSize: 17),
              //             )),
              //             TableCell(
              //                 child: Text(
              //               '$prixProduit DH',
              //               style: const TextStyle(fontSize: 17),
              //             )),
              //             TableCell(
              //                 child: Text(
              //               '$prixTotalProduit DH',
              //               style: const TextStyle(fontSize: 17),
              //             )),
              //           ],
              //         ),
              //       ],
              //     );
              //   },
              // ),
