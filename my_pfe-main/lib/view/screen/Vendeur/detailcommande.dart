import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:my_pfe/view/screen/Vendeur/saisiecommande.dart';
import 'dart:convert';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
// ignore: library_prefixes
import 'package:pdf/widgets.dart' as pdfWidgets;
import 'dart:io';
import 'package:path/path.dart' as path;
// ignore: library_prefixes
import 'package:path_provider/path_provider.dart' as pathProvider;
//import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

import '../../../controller/admin_controller/home_controller.dart';
import '../../../core/constant/linkapi.dart';

class DetailsCommande extends StatefulWidget {
  final List<Product> products;

  const DetailsCommande({required this.products});

  @override
  _DetailsCommandeState createState() => _DetailsCommandeState();
}

class _DetailsCommandeState extends State<DetailsCommande> {
  String nomVendeur = '';
  String prenomVendeur = '';
  String vehiculeId = '';

  @override
  void initState() {
    super.initState();
    // Appeler la méthode pour récupérer les données du vendeur
    fetchVendeurDetails();
    fetchVehiculeId();
    imagePath = 'assets/images/facture.jpg';
  }

  void fetchVendeurDetails() async {
    HomeControllerA controller = Get.put(HomeControllerA());
    String vendeurId = '${controller.idv}';
    print('VendeurID: $vendeurId');
    // Remplacez "YOUR_PHP_API_URL" par l'URL de votre API PHP
    var response =
        await http.get(Uri.parse('${AppLink.infosvend}?idV=$vendeurId'));

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      setState(() {
        nomVendeur = data['nomVendeur'];
        prenomVendeur = data['prenomVendeur'];
      });
    } else {
      // Gérer les erreurs de requête
      print('Erreur de requête : ${response.statusCode}');
    }
  }

  void fetchVehiculeId() async {
    HomeControllerA controller = Get.put(HomeControllerA());
    String vendeurId = '${controller.idv}';
    print('VendeurID: $vendeurId');
    // Remplacez "YOUR_PHP_API_URL" par l'URL de votre API PHP
    var response =
        await http.get(Uri.parse('${AppLink.vehiculeid}?vendeurId=$vendeurId'));

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      setState(() {
        vehiculeId = data['vehiculeId'].toString();
      });
    } else {
      // Gérer les erreurs de requête
      print('Erreur de requête : ${response.statusCode}');
    }
  }

  late String imagePath;

  @override
  Widget build(BuildContext context) {
    // Filtrer les produits avec une quantité différente de zéro
    final filteredProducts =
        widget.products.where((product) => product.quantity != 0).toList();

    // Obtenir la date d'aujourd'hui
    final now = DateTime.now();
    final formattedDate = DateFormat('dd/MM/yyyy').format(now);
    double totalTonnage = 0.0;

    for (Product product in filteredProducts) {
      double type = double.parse(product.type);
      totalTonnage += type * product.quantity.toDouble();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Détails de la commande'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Nom du vendeur: $nomVendeur',
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                Text('Prénom du vendeur: $prenomVendeur',
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                Text('vehicule ID : $vehiculeId',
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Text('Tonnage Total : $totalTonnage kg',
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Text('Date de commande: $formattedDate',
                    style: const TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: DataTable(
                dataRowHeight: 100, // Hauteur de la ligne des données
                columnSpacing: 16, // Espacement entre les colonnes
                dividerThickness: 2, // Épaisseur de la ligne de séparation
                headingRowColor: MaterialStateColor.resolveWith((states) => Colors
                        .grey[
                    300]!), // Couleur de fond pour la première ligne (en-têtes)
                columns: const [
                  DataColumn(
                    label: SizedBox(width: 100, child: Text('Image')),
                  ),
                  DataColumn(
                    label: SizedBox(width: 100, child: Text('Nom')),
                  ),
                  DataColumn(
                    label: SizedBox(width: 50, child: Text('Type')),
                  ),
                  DataColumn(
                    label: SizedBox(width: 100, child: Text('Quantité')),
                  ),
                ],
                rows: filteredProducts.map((product) {
                  return DataRow(
                    cells: [
                      DataCell(
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: SizedBox(
                            width: 80,
                            height: 105,
                            child: Image.network(
                              '${AppLink.imagep}/${product.image}',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      DataCell(Text(product.n)),
                      DataCell(
                        Row(
                          children: [
                            Text(product.type),
                            const Text(' kg'), // Ajouter " kg" après le type
                          ],
                        ),
                      ),
                      DataCell(Text(product.quantity.toString())),
                    ],
                  );
                }).toList(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: enregistrerCommande,
                child: const Text('Enregistrer'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Product> get filteredProducts {
    return widget.products.where((product) => product.quantity != 0).toList();
  }

  void enregistrerCommande() async {
    // Afficher la boîte de dialogue de confirmation
    bool? resultat = await afficherConfirmation(context);

    if (resultat == true) {
      // Récupérer les données nécessaires à partir des variables de l'état
      String nomVendeur = this.nomVendeur;
      String prenomVendeur = this.prenomVendeur;
      String vehiculeId = this.vehiculeId;
      List<Product> products = filteredProducts;

      // Préparer les données pour l'envoi à l'API
      List<Map<String, dynamic>> productsData = products.map((product) {
        return {
          'nom': product.n,
          'type': product.type,
          'quantite': product.quantity,
        };
      }).toList();

      // Afficher les données qui seront envoyées
      print('Données de la commande :');
      print('nomVendeur: $nomVendeur');
      print('prenomVendeur: $prenomVendeur');
      print('vehiculeId: $vehiculeId');
      print('produits: $productsData');

      try {
        // Envoyer les données à votre API pour enregistrement
        var response = await http.post(
          Uri.parse(AppLink.savecommande),
          body: {
            'nomVendeur': nomVendeur,
            'prenomVendeur': prenomVendeur,
            'vehiculeId': vehiculeId,
            'produits': jsonEncode(productsData),
          },
        );

        if (response.statusCode == 200) {
          var data = json.decode(response.body);
          bool success = data['success'];
          String message = data['message'];

          if (success) {
            // La commande a été enregistrée avec succès
            afficherMessageSucces(message);
            // generatePDF();
            sendEmailWithPDF();
          } else {
            // Afficher le message d'erreur
            afficherMessageErreur(message);
          }
        } else {
          // Erreur de requête
          afficherMessageErreur('Erreur de requête : ${response.statusCode}');
        }
      } catch (error) {
        // Gérer les erreurs d'exception
        afficherMessageErreur(
            'Erreur lors de l\'enregistrement de la commande : $error');
      }
    }
  }

  Future<bool?> afficherConfirmation(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmation'),
          content: const Text('Voulez-vous enregistrer la commande ?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Annuler'),
              onPressed: () {
                Navigator.of(context).pop(false); // Annuler l'enregistrement
              },
            ),
            ElevatedButton(
              child: const Text('Confirmer'),
              onPressed: () {
                Navigator.of(context).pop(true); // Confirmer l'enregistrement
              },
            ),
          ],
        );
      },
    );
  }

  void afficherMessageSucces(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Succès'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop(); // Fermer la boîte de dialogue
              },
            ),
            ElevatedButton(
              child: const Text('Ouvrir le fichier'),
              onPressed: () {
                generatePDF();
              },
            ),
          ],
        );
      },
    );
  }

  void afficherMessageErreur(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Erreur'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop(); // Fermer la boîte de dialogue
              },
            ),
          ],
        );
      },
    );
  }

  void generatePDF() async {
    final pdf = pw.Document();
    final now = DateTime.now();
    final formattedDate = DateFormat('dd/MM/yyyy').format(now);

    // Créer un répertoire temporaire pour stocker les images
    final tempDir = await pathProvider.getTemporaryDirectory();
    final imagesDir = Directory('${tempDir.path}/images');
    await imagesDir.create();

    // Télécharger les images et les enregistrer localement
    final downloadedImages =
        await Future.wait(filteredProducts.map((product) async {
      final imageUrl = '${AppLink.imagep}/${product.image}';
      final imageName = path.basename(imageUrl);
      final imagePath = '${imagesDir.path}/$imageName';

      final imageResponse = await http.get(Uri.parse(imageUrl));
      if (imageResponse.statusCode == 200) {
        await File(imagePath).writeAsBytes(imageResponse.bodyBytes);
        return imagePath;
      } else {
        return null;
      }
    }));

    final logoImage = pw.MemoryImage(
      (await rootBundle.load(imagePath)).buffer.asUint8List(),
    );

    // Définir le nombre de produits par page
    const productsPerPage = 3;

    // Calculer le nombre total de pages
    final totalProducts = filteredProducts.length;
    final totalPages = (totalProducts / productsPerPage).ceil();

    // Générer chaque page du document PDF
    for (int page = 1; page <= totalPages; page++) {
      // Obtenir les indices de début et de fin pour les produits de la page actuelle
      final startIndex = (page - 1) * productsPerPage;
      final endIndex = startIndex + productsPerPage < filteredProducts.length
          ? startIndex + productsPerPage
          : filteredProducts.length;

      // Obtenir les produits de la page actuelle
      final pageProducts = filteredProducts.sublist(startIndex, endIndex);

      // Ajouter les informations de la commande et le tableau des produits à la page
      pdf.addPage(
        pw.Page(
          build: (pw.Context context) {
            return pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Image(
                  logoImage,
                  fit: pw.BoxFit.fill,
                ),
                pw.SizedBox(height: 20),
                pw.Text('Nom du vendeur: $nomVendeur',
                    style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                pw.SizedBox(height: 5),
                pw.Text('Prénom du vendeur: $prenomVendeur',
                    style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                pw.SizedBox(height: 5),
                pw.Text('Date de commande: $formattedDate',
                    style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                pw.Text('vehicule id : $vehiculeId',
                    style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                pw.SizedBox(height: 20),
                pw.Table.fromTextArray(
                  context: context,
                  data: <List<pw.Widget>>[
                    <pw.Widget>[
                      pw.Text('Image'),
                      pw.Text('Nom'),
                      pw.Text('Type'),
                      pw.Text('Quantité'),
                    ],
                    ...pageProducts.map((product) {
                      final imagePath =
                          downloadedImages[filteredProducts.indexOf(product)];

                      return [
                        imagePath != null
                            ? pw.Image(
                                pdfWidgets.MemoryImage(
                                  File(imagePath).readAsBytesSync(),
                                ),
                                width: 80,
                                height: 105,
                              )
                            : pw.Container(),
                        pw.Text(product.n),
                        pw.Text(product.type),
                        pw.Text(product.quantity.toString()),
                      ];
                    }),
                  ],
                ),
              ],
            );
          },
        ),
      );
    }

    final output = await getExternalStorageDirectory();
    final file = File('${output?.path}/commande.pdf');
    await file.writeAsBytes(await pdf.save());

    // Afficher un message de réussite après avoir enregistré le fichier
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Le fichier PDF a été enregistré avec succès.'),
      ),
    );

    // Ouvrir le fichier PDF avec une application PDF sur le périphérique

    OpenFile.open(file.path);
  }

  Future<void> sendEmailWithPDF() async {
    final smtpServer = gmail('ominoterie@gmail.com', 'pitjwdulrxvgdnnf');
    final message = Message()
      ..from = const Address('ominoterie@gmail.com')
      ..recipients.add('hlal20ikram@gmail.com')
      ..subject = 'Commande PDF'
      ..text = 'Veuillez trouver ci-joint la commande en PDF.'
      ..attachments.add(FileAttachment(File(await _getPDFFilePath())))
      ..html =
          '<h1>Commande PDF</h1><p>Veuillez trouver ci-joint la commande en PDF.</p>';

    try {
      final sendReport = await send(message, smtpServer);
      if (sendReport != null) {
        print('E-mail envoyé avec succès');
      } else {
        print("Échec de l'envoi de l'e-mail");
      }
    } catch (e) {
      print("Erreur lors de l'envoi de l'e-mail: $e");
    }
  }

  Future<String> _getPDFFilePath() async {
    final output = await getExternalStorageDirectory();
    return '${output?.path}/commande.pdf';
  }
}
