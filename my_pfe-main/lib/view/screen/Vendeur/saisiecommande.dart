import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:my_pfe/controller/admin_controller/home_controller.dart';
import 'package:my_pfe/view/screen/Vendeur/detailcommande.dart';
import 'dart:convert';
import '../../../core/constant/linkapi.dart';

class Product {
  final String n;
  final String type;
  final String name;
  final String image;
  final double price;
  int quantity;
  double tonnageMax;

  Product({
    required this.n,
    required this.type,
    required this.name,
    required this.image,
    required this.price,
    this.quantity = 0,
    this.tonnageMax = 0,
  });
}

class Saisiecommande extends StatefulWidget {
  @override
  _SaisiecommandeState createState() => _SaisiecommandeState();
}

class _SaisiecommandeState extends State<Saisiecommande> {
  List<Product> products = [];
  double tonnageMax = 0;
  bool showDialogBox = false;

  @override
  void initState() {
    super.initState();
    fetchProducts();
    fetchTonnageMax();
  }

  Future<void> fetchProducts() async {
    final response = await http.get(Uri.parse(AppLink.enregistrerCommandeI));
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = jsonDecode(response.body);
      products = jsonData.map((item) {
        return Product(
          n: item['Nomp'].toString(),
          type: item['Typep'].toString(),
          name: '${item['Nomp']} ${item['Typep'].toString()}\ Kg',
          image: item['Imagep'],
          price: double.parse(item['Prixp'].toString()),
        );
      }).toList();
      setState(() {});
    }
  }

  Future<void> fetchTonnageMax() async {
    HomeControllerA controller = Get.put(HomeControllerA());
    String vendeurId = '${controller.idv}';
    print('VendeurID: $vendeurId');
    final response = await http
        .get(Uri.parse('${AppLink.tonnagevehicule}?vendeurId=$vendeurId'));
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = jsonDecode(response.body);
      if (jsonData.isNotEmpty) {
        tonnageMax = double.parse(jsonData[0]['tonagemax'].toString());
      } else {
        showDialogBox = true;
      }
      setState(() {});
    }
  }

  void incrementQuantity(int index) {
    double totalTonnage = calculateTotalTonnage();
    if (totalTonnage + double.parse(products[index].type) <= tonnageMax) {
      setState(() {
        products[index].quantity++;
      });
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error,
                    color: Colors.red, size: 50.0), // Icône d'erreur
                SizedBox(width: 20.0),
              ],
            ),
            content: const Text(
              'Le tonnage maximal a été atteint. Vous ne pouvez pas ajouter plus de produits de ce type.',
            ),
            actions: [
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.pop(context); // Ferme la boîte de dialogue
                },
              ),
            ],
          );
        },
      );
    }
  }

  void decrementQuantity(int index) {
    setState(() {
      if (products[index].quantity > 0) {
        products[index].quantity--;
      }
    });
  }

  bool isAscending = true; // Variable pour suivre l'état du tri

  void sortProductsByQuantity() {
    setState(() {
      if (isAscending) {
        products.sort((a, b) => a.quantity.compareTo(b.quantity));
      } else {
        products.sort((a, b) => b.quantity.compareTo(a.quantity));
      }
      isAscending = !isAscending; // Inverser l'état du tri
    });
  }

  double calculateTonnage(Product product) {
    return product.quantity * double.parse(product.type);
  }

  double calculateTotalTonnage() {
    double totalTonnage = 0;
    for (var product in products) {
      totalTonnage += calculateTonnage(product);
    }
    return totalTonnage;
  }

  void showUnavailableDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Aucune affectation n\'est disponible',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: const Text(
            'Veuillez réessayer ultérieurement.',
            style: TextStyle(fontSize: 16.0),
          ),
          actions: [
            TextButton(
              child: const Text(
                'Revenir en arrière',
                style: TextStyle(fontSize: 16.0),
              ),
              onPressed: () {
                Navigator.pop(context); // Ferme la boîte de dialogue
                Navigator.pop(context); // Reviens en arrière dans la page
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (showDialogBox) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showUnavailableDialog();
      });
    }

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              const Text('Saisie de commande'),
              const Spacer(),
              TextButton.icon(
                icon: const Icon(Icons.filter_list),
                label: const Text(
                  'Filtrer',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: sortProductsByQuantity,
              ),
            ],
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: products.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    elevation: 10, // Élévation de la carte
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          12), // Bordure circulaire de la carte
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 100,
                            child: AspectRatio(
                              aspectRatio: 1,
                              child: Image.network(
                                '${AppLink.imagep}/${products[index].image}',
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          const SizedBox(width: 4.0),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                products[index].name,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              Text('Prix: ${products[index].price}\ DH'),
                            ],
                          ),
                          const Spacer(),
                          IconButton(
                            icon: const Icon(Icons.remove),
                            onPressed: () => decrementQuantity(index),
                          ),
                          Text(products[index].quantity.toString()),
                          IconButton(
                            icon: const Icon(Icons.add),
                            onPressed: () => incrementQuantity(index),
                            // Désactive le bouton "+" si le tonnage maximal est atteint
                            // ou dépasse le tonnage maximal
                            disabledColor: calculateTotalTonnage() +
                                        double.parse(products[index].type) >
                                    tonnageMax
                                ? Colors.grey
                                : null,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                    'Tonnage actuel: ${calculateTotalTonnage().toStringAsFixed(2)} \kg',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Tonnage maximal: ${tonnageMax.toStringAsFixed(2)} \kg',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              child: const Text('Valider'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          DetailsCommande(products: products)),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
