import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../controller/admin_controller/home_controller.dart';
import '../../../core/constant/linkapi.dart';

class ConsulterPlaning extends StatefulWidget {
  const ConsulterPlaning({super.key});

  @override
  _ConsulterPlaningState createState() => _ConsulterPlaningState();
}

class _ConsulterPlaningState extends State<ConsulterPlaning> {
  List<dynamic> data = [];
  DateTime currentDate = DateTime.now();
  DateTime tomorrowDate = DateTime.now().add(const Duration(days: 1));
  bool showInfo = false;
  bool isTodayButtonDisabled = false;
  bool isTomorrowButtonDisabled = false;

  @override
  void initState() {
    super.initState();
  }

  Future<void> fetchData(DateTime date) async {
    HomeControllerA controller = Get.put(HomeControllerA());
    String vendeurId = '${controller.idv}';
    print('VendeurID: $vendeurId');

    var url = Uri.parse(
        '${AppLink.consulterPlaning}?vendeurId=$vendeurId&selectedButton=${date.toString()}');

    //   try {
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var responseData = json.decode(response.body);
      print('Réponse du serveur: $responseData');

      setState(() {
        data = responseData;
        showInfo =
            true; // Afficher les informations après la récupération des données
      });
    } else {
      print('Erreur HTTP: ${response.statusCode}');
    }
    // }
    //  catch (error) {
    //   print('Erreur lors de la requête HTTP: $error');
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Consulter Planing',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 10, 99, 29),
        elevation: 0,
      ),
      backgroundColor: Colors.grey[200],
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: isTodayButtonDisabled
                        ? null
                        : () {
                            if (!isTodayButtonDisabled) {
                              setState(() {
                                currentDate = currentDate
                                    .subtract(const Duration(days: 1));
                                showInfo = false;
                                fetchData(currentDate);
                                isTodayButtonDisabled = true;
                                isTomorrowButtonDisabled = false;
                              });
                            }
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          isTodayButtonDisabled ? Colors.grey : Colors.green,
                      textStyle: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    child: const Text('Planning d\'aujourd\'hui'),
                  ),
                  ElevatedButton(
                    onPressed: isTomorrowButtonDisabled
                        ? null
                        : () {
                            if (!isTomorrowButtonDisabled) {
                              setState(() {
                                currentDate = DateTime.now();
                                showInfo = false;
                                fetchData(currentDate);
                                isTodayButtonDisabled = false;
                                isTomorrowButtonDisabled = true;
                              });
                            }
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          isTomorrowButtonDisabled ? Colors.grey : Colors.green,
                      textStyle: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    child: const Text('Planning de demain'),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              if (showInfo)
                for (var secteurData in data) ...[
                  const SizedBox(height: 16.0),
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(
                          255, 198, 223, 199), // Couleur de fond du secteur
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Row(
                          children: [
                            Icon(Icons.info_outline, color: Colors.blue),
                            SizedBox(width: 8.0),
                            Text(
                              'Informations du secteur:',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8.0),
                        Container(
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Icon(Icons.location_on,
                                      color: Colors.green),
                                  const SizedBox(width: 8.0),
                                  RichText(
                                    text: TextSpan(
                                      children: [
                                        const TextSpan(
                                          text: 'Nom du secteur: ',
                                          style: TextStyle(color: Colors.black),
                                        ),
                                        TextSpan(
                                          text: secteurData['secteur'],
                                          style: const TextStyle(
                                            color: Colors
                                                .red, // Couleur du nom du secteur
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8.0),
                              Row(
                                children: [
                                  const Icon(Icons.directions_car,
                                      color: Color.fromARGB(255, 238, 40, 10)),
                                  const SizedBox(width: 8.0),
                                  Text(
                                      'Véhicule ID: ${secteurData['vehiculeIds'].toString().replaceAll('[', '').replaceAll(']', '')}'),
                                ],
                              ),
                              const SizedBox(height: 8.0),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  for (var client
                                      in secteurData['clients']) ...[
                                    const SizedBox(height: 8.0),
                                    Container(
                                      padding: const EdgeInsets.all(8.0),
                                      decoration: BoxDecoration(
                                        color: Colors.grey[100],
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      child: Row(
                                        children: [
                                          const Icon(Icons.person_2_outlined,
                                              color: Color.fromARGB(
                                                  255, 27, 154, 213)),
                                          const SizedBox(width: 8.0),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                    'Nom client: ${client['Nomc']}'),
                                                Text(
                                                    'Prénom client: ${client['Prenomc']}'),
                                                Text(
                                                    'Adresse client: ${client['Adressec']}'),
                                                Text(
                                                    'Téléphone client: ${client['telephone']}'),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
            ],
          ),
        ),
      ),
    );
  }
}
